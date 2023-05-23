-- Witches is copyright 2020 Francisco Athens, Ramona Athens, Damon Athens and Simone Athens
-- The MIT License (MIT)
local function print_s(input) print(witches.strip_escapes(input)) end

local S = minetest.get_translator("witches")

witches.find_item_quest = {}
witches.found_item_ask = {}
witches.found_item_quest = {}

-- local item_request = witches.generate_name(witches.quest_dialogs, {"item_request"})

local _contexts = {}
local function get_context(name)
    local context = _contexts[name] or {}
    _contexts[name] = context
    return context
end

minetest.register_on_leaveplayer(function(player)
    _contexts[player:get_player_name()] = nil
end)

local function formspec_check(formspec)
    if not formspec then
        print("ERROR: NO FORMSPEC!")
        return
    end
    if type(formspec) ~= "table" then
        print("ERROR: FORMSPEC is not table!")
        return
    end
    for i,v in ipairs(formspec) do
        if not v then
            print("ERROR: FORMSPEC index "..i.." value is NIL!")
            return
        end
    end
    witches.debug(dump(formspec),"witches.find_item_quest.get_formspec")
    return table.concat(formspec, "")
end

function witches.find_item_quest.get_formspec(self, name)
    -- retrieve the thing
    -- local quest_item = witches.looking_for(self)
    local text = ""
    local item = self.item_request.item
    if not item.name then
         item.name = "item name missing!"
         print("ERROR: item name not found:"..dump(item))
    end
    if not item.count then
        print("ERROR: item count not found:"..dump(item))
        item.count = 1
    end

    if self.item_request.text and type(self.item_request.text) == "table" then
        local intro = self.item_request.text.intro
        local request = "\n" .. self.item_request.text.request
        text = S("@1 @2", intro, request)
        -- print(text)

    else
        text = "hey, " .. name .. ", I am error!"
    end

    if self.dev_mode == name and self.hair_style and self.hat_style then
        text = text .. "\nhair: " .. self.hair_style .. ",hat: " ..
                   self.hat_style
    end

    if not text then
         text = "quest text not parsed!"
         print("ERROR: quest text not found")
    end

    local formspec = {
        "formspec_version[3]",
        "size[6,3.5,true]",
         "position[0.5,0.5]",
        "anchor[0.5,0.5]",
         "style_type[label;font=bold;font_size=+4]",
        "textarea[0.25,0.25;5.50,2.0;;;",
         minetest.formspec_escape(text), "]",
        "item_image[2.5,2.25;1,1;", minetest.formspec_escape(item.name),"]",
        "label[2.5,2.25;", item.count,"]"

    }
    return formspec_check(formspec)


end

function witches.found_item_ask.get_formspec(context, name)
    --print("SHOWING FORMSPEC!")
    local qi = context.target.item_request.item

    local witch = context.target.secret_name
    local text = S("I see you found some @1!\nDo you wish to give me @2 @3?",
                   qi.desc, qi.count, qi.desc)

    local display_item = qi.name

    local formspec = {
        "formspec_version[3]", "size[5,4,true]", "position[0.5,0.5]",
        "anchor[0.5,0.5]",
        "style_type[item_image_button;border=true;font=bold;font_size=+4;bgcolor_hovered=black]",
        "style_type[label;font=bold;font_size=+4]", 
        "textarea[0.1,0.25;5,2;;;", minetest.formspec_escape(text), "]",
         --"item_image[2,2;1,1;",display_item,"]",
        "item_image_button[1,2.5;1,1;", minetest.formspec_escape(display_item), ";give_yes;]",
        "label[1.1,2.8;", qi.count, "]", "item_image_button[3,2.5;1,1;",
        minetest.formspec_escape(display_item), ";give_no;]", "label[3.1,2.8;0]"
    }
    
    return formspec_check(formspec)
end

function witches.found_item_quest.get_formspec(self, name)
    local display_item = "default:mese"
    -- retrieve the thing
    local qi = self.item_request.item

    local text = S("Thank you @1, for finding @2 @3!", name, qi.count, qi.desc)
    -- print(dump(self.players[name].reward_text))
    if self.players[name].reward_text then
        text = text .. "\n(" .. self.players[name].reward_text .. ")"
    end
    if self.players[name].reward_item then
        display_item = self.players[name].reward_item
    else
        display_item = qi.name
    end
    local formspec = {
      "formspec_version[3]", "size[5,3.5,true]", "position[0.5,0.5]",
      "anchor[0.5,0.5]", 
      "textarea[0.15,0.15;4.7,2;;;", minetest.formspec_escape(text), "]",
      "item_image[2,2.25;1,1;" .. minetest.formspec_escape(display_item) .. "]"
    }

    return formspec_check(formspec)
end

function witches.find_item_quest.show_to(self, name)
    minetest.show_formspec(name, "witches:find_item_quest",
                           witches.find_item_quest.get_formspec(self, name))
    self.item_request.text = nil
    self.dev_mode = nil
end

function witches.found_item_ask.show_to(self, name)
    local context = get_context(name)
    context.target = self

    local fs = witches.found_item_ask.get_formspec(context, name)
    minetest.show_formspec(name, "witches:found_item_ask", fs)
    -- self.item_request.text = nil

end

function witches.found_item_quest.show_to(self, name)

    minetest.show_formspec(name, "witches:found_item_quest",
                           witches.found_item_quest.get_formspec(self, name))
    self.players[name].reward_item = nil
    self.players[name].reward_text = nil
end

minetest.register_on_player_receive_fields(
    function(player, formname, fields)
        if formname ~= "witches:found_item_ask" then return end

        if formname == "witches:found_item_ask" then
            local name = player:get_player_name()
            local context = get_context(name)
            local qi = context.target.item_request.item
            if fields.give_yes then

                witches.take_item(context.target, player)
                minetest.close_formspec(name, 'witches:found_item_ask')
            else
                minetest.close_formspec(name, 'witches:found_item_ask')
            end
        end
    end)
