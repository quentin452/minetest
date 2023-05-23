-- Witches is copyright 2020 Francisco Athens, Ramona Athens, Damon Athens and Simone Athens
-- The MIT License (MIT)
local function print_s(input) print(witches.strip_escapes(input)) end

local function mr(...)
    return witches.mr(...)
end

local S = minetest.get_translator("witches")

-- name parts taken from https://github.com/LukeMS/lua-namegen/blob/master/data/creatures.cfg
witches.name_parts_male = {
    syllablesStart = "Aer, Al, Am, An, Ar, Arm, Arth, B, Bal, Bar, Be, Bel, Ber, Bok, Bor, Bran, Breg, Bren, Brod, Cam, Chal, Cham, Ch, Cuth, Dag, Daim, Dair, Del, Dr, Dur, Duv, Ear, Elen, Er, Erel, Erem, Fal, Ful, Gal, G, Get, Gil, Gor, Grin, Gun, H, Hal, Han, Har, Hath, Hett, Hur, Iss, Khel, K, Kor, Lel, Lor, M, Mal, Man, Mard, N, Ol, Radh, Rag, Relg, Rh, Run, Sam, Tarr, T, Tor, Tul, Tur, Ul, Ulf, Unr, Ur, Urth, Yar, Z, Zan, Zer",
    syllablesMiddle = "de, do, dra, du, duna, ga, go, hara, kaltho, la, latha, le, ma, nari, ra, re, rego, ro, rodda, romi, rui, sa, to, ya, zila",
    syllablesEnd = "bar, bers, blek, chak, chik, dan, dar, das, dig, dil, din, dir, dor, dur, fang, fast, gar, gas, gen, gorn, grim, gund, had, hek, hell, hir, hor, kan, kath, khad, kor, lach, lar, ldil, ldir, leg, len, lin, mas, mnir, ndil, ndur, neg, nik, ntir, rab, rach, rain, rak, ran, rand, rath, rek, rig, rim, rin, rion, sin, sta, stir, sus, tar, thad, thel, tir, von, vor, yon, zor",
    syllablesTown = "mar, ton, veil,  Loch, del,  Pass,  Hillock,  shire, nia, ing"
}

witches.name_parts_female = {
    syllablesStart = "Ad, Aer, Ar, Bel, Bet, Beth, Ce'N, Cyr, Eilin, El, Em, Emel, G, Gl, Glor, Is, Isl, Iv, Lay, Lis, May, Ner, Pol, Por, Sal, Sil, Vel, Vor, X, Xan, Xer, Yv, Zub",
    syllablesMiddle = "bre, da, dhe, ga, lda, le, lra, mi, ra, ri, ria, re, se, ya",
    syllablesEnd = "ba, beth, da, kira, laith, lle, ma, mina, mira, na, nn, nne, nor, ra, rin, ssra, ta, th, tha, thra, tira, tta, vea, vena, we, wen, wyn",
    syllablesTown = "maer, tine, veila,  Loch, dael,  Pass,  Hillock, shire, mia, aeng"
}

witches.words_desc = {
    tool_adj = S(
        "shiny, polished, favorite, beloved, cherished, sharpened, enhanced"),
    titles = S(
        "artificer, librarian, logician, sorcerant, thaumaturgist, polymorphist, elementalist, hedge, herbologist, arcanologist, tutor, historian, mendicant, restorationist")
}

local function quest_dialogs(self, qty)
    local thing = self.item_request.item.desc
    local thing_l = string.lower(self.item_request.item.desc)
    qty = qty or self.item_request.item.count or 1

    local dialogs = {
        intro = {
            S("Hello, @1, I am @2, @3 of @4! ", self.speaking_to,
              self.secret_name, self.secret_title, self.secret_locale),
            S("Just one minute, @1! @2, @3 of @4 seeks your assistance! ",
              self.speaking_to, self.secret_name, self.secret_title,
              self.secret_locale), S(
                "If you are indeed @1, perhaps you and I, @2, @3 of @4 can help each other! ",
                self.speaking_to, self.secret_name, self.secret_title,
                self.secret_locale),
            S(
                "Being a long way from @1, can be confusing. I'm known as @2 the @3! ",
                self.secret_locale, self.secret_name, self.secret_title), S(
                "You look as though you could be from @1, but I'm sure we have not yet met. I am @2 the @3! ",
                self.secret_locale, self.secret_name, self.secret_title)
        },
        having_met = {
            S("Well, @1, I have yet to return to @2. Can you help me? ",
              self.speaking_to, self.secret_locale),
            S("@1, do you have any intention of helping me? ", self.speaking_to),
            S("There are some matters that still need my attention, @1. ",
              self.speaking_to),
            S("I have been so busy in my search for materials, @1. ",
              self.speaking_to),
            S("It's just that the @1 is so difficult to procure, @2! ", thing_l,
              self.speaking_to),
            S("Great @1!, Where could that be found, @2?!? ", thing_l,
              self.speaking_to)

        },
        item_request = {
            S("Just @1 of the @2 will do! ", qty, thing_l),
            S("I've been looking all over for @1 of the @2! ", qty, thing_l),
            S("I seem to have misplaced @1 of the @2! ", qty, thing_l),
            S("Would you happen to have @1 of the @2? ", qty, thing_l),
            S("Would you kindly retrieve for me @1 of the @2? ", qty, thing_l),
            S("Might you please return with @1 of the @2? ", qty, thing_l),
            S("Do you know I seek only @1 of the @2? ", qty, thing_l),
            S("Have you but @1 of the @2? ", qty, thing_l),
            S("Why must my task require @1 of the @2? ", qty, thing_l),
            S("Is it so difficult to find @1 of the @2? ", qty, thing_l),
            S("Wherefor about this land art @1 of the @2? ", qty, thing_l),
            S("Must not there be but @1 of the @2 about? ", qty, thing_l),
            S("Could I trouble you for @1 of some @2? ", qty, thing_l),
            S("@1 of the @2 would make my collection complete! ", qty, thing_l),
            S("I sense that @1 of the @2 are not far away...", qty, thing_l),
            S("Certainly @1 of the @2 is not as rare as a blood moon! ", qty,
              thing_l),
            S("You look like you know where to find @1 of the @2! ", qty,
              thing_l)
        }
    }
    -- print(dump(dialogs))
    return dialogs
end

function witches.generate_text(name_parts, rules, separator)
    -- print_s("generating name")
    local name_arrays = {}
    local r_parts = {}
    local generated_name = {}
    for k, v in pairs(name_parts) do
        --  name_arrays.k = mysplit(v)
        if separator then
            name_arrays.k = string.split(v, separator)
        else
            name_arrays.k = string.split(v, ", ")
        end
        -- print_s(dump(name_arrays.k))
        r_parts[k] = k
        r_parts[k] = name_arrays.k[mr(1, #name_arrays.k)]
    end
    -- local r_parts.k = name_arrays.k[mr(1,#name_arrays.k)] did not work
    -- print_s(name_a)
    if r_parts.list_opt and mr(2) == 1  then r_parts.list_opt = "" end
    -- print_s(r_parts.list_a..r_parts.list_b..r_parts.list_opt)
    if rules then
        -- print_s(dump(rules))
        local gen_name = ""
        for i, v in ipairs(rules) do
            if v == "-" then
                gen_name = gen_name .. "-"
            elseif v == "\'" then
                gen_name = gen_name .. "\'"
            else
                gen_name = gen_name .. r_parts[v]
            end
        end
        generated_name = gen_name
        -- print_s(dump(generated_name))
        return generated_name
    else
        generated_name = r_parts.syllablesStart .. r_parts.syllablesMiddle ..
                             r_parts.syllablesEnd
        return generated_name
    end
end

witches.rnd_colors = {
    "none", "red", "green", "blue", "orange", "yellow", "violet", "cyan",
    "pink", "black", "magenta", "grey"
}

witches.hair_colors = {
    "black", "brown", "blonde", "gray", "red", "blue", "green"
}

local rnd_color = witches.rnd_color
local rnd_colors = witches.rnd_colors

function witches.rnd_color(colors)
    colors = colors or rnd_colors
    local color = colors[mr(1, #colors)]
    return color
end

function witches.color_mod_string()
    local str = "^[colorize:\"" .. rnd_color(rnd_colors) .. ":50\""
    return str
end

-- for rng of small floats
function witches.variance(min, max)
    local target = mr(min, max) / 100
    -- print(target)
    return target
end

--- witches.special_gifts drops a special, personlized item.
--- called by witches.found_item(self, clicker)
function witches.special_gifts(self, pname, drop_chance, max_drop)
    if not pname then
        print(" pname FAILED", "witches.special_gifts")
        return
    end

    if not self.special_drops then
        print(" self.special_drops FAILED", "witches.special_gifts")
        return
    end

    drop_chance = drop_chance or 1000
    max_drop = max_drop or 1

    if max_drop == 0 or #self.special_drops == 0 then
        print(" no more drops", "witches.special_gifts")
        return
    end

    local pos = self.object:get_pos()
    pos.y = pos.y + 0.5
    -- witches.mixitup(pos)

    for k, v in ipairs(self.special_drops) do
        if max_drop < 1 then return end

        if not self.players[pname].gifts then
            -- self.players[pname] = {met = self.players[pname].met , favors = 0}
            self.players[pname].gifts = {}
        end

        -- print(v.name)

        if not self.players[pname].gifts[v.name] then

            witches.debug(dump(self.special_drops[k]),"witches.special_gifts")
            local count = mr(v.min, v.max)
            if count < 1 then
                return print(
                           "drop num of special drops should be at least 1 as they don't occur on mob death")
            end
            self.players[pname].gifts[v.name] = 1
             witches.debug("given gifts: "..dump(self.players[pname].gifts),"witches.special_gifts")
            max_drop = max_drop - 1
            --[[
            minetest.sound_play("goblins_goblin_cackle", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = self.sounds.distance or 10
            })
            --]]
            local item_wear = mr(8000, 10000)
            local stack = ItemStack({name = v.name, wear = item_wear})
            local org_desc = minetest.registered_items[v.name].description
            stack:set_count(count)
            local meta = stack:get_meta()
            -- boost the stats!
            local capabilities = stack:get_tool_capabilities()

            local bonuses = 0
            for x, y in pairs(capabilities) do
                if x == "groupcaps" then
                    for a, b in pairs(y) do
                        -- print(dump(a).." is "..dump(b).."\n---")
                        if b and b.uses then
                            -- print("original uses: "..capabilities.groupcaps[a].uses)

                            capabilities.groupcaps[a].uses = b.uses + 10
                            -- print("boosted uses: "..capabilities.groupcaps[a].uses)

                            -- print(dump(a).." is now "..dump(b))
                        end
                        if b and b.times then
                            for i, t in pairs(b.times) do
                                if t > 0.3 then
                                    -- print("original time:".. t )
                                    local t_rnd = mr(1, 3) / 10
                                    t = t - t_rnd
                                    -- print("boosted time:".. t )
                                end
                                capabilities.groupcaps[a].times[i] = t
                            end
                        end
                    end
                elseif x == "damage_groups" then
                    for a, b in pairs(y) do
                        -- print(dump(a.." = "..capabilities.damage_groups[a]))
                        capabilities.damage_groups[a] = b + mr(1, 2)
                        -- print(dump(capabilities.damage_groups[a]))
                    end
                end
            end
            meta:set_tool_capabilities(capabilities)
            -- print (dump(capabilities))
            local tool_adj = witches.generate_text(witches.words_desc,
                                                   {"tool_adj"})
            -- special thanks here to rubenwardy for showing me how translation works!
            meta:set_string("description", S("@1's @2 @3", self.secret_name,
                                             tool_adj, org_desc))
            -- minetest.chat_send_player()
            local inv = minetest.get_inventory({type = "player", name = pname})
            local reward_text = {}
            local reward = {}

            for i, _ in pairs(inv:get_lists()) do
                -- print(i.." = "..dump(v))
                if i == "main" and stack and inv:room_for_item(i, stack) then
                    reward_text = S("You are rewarded with @1 @2", count,
                                    meta:get_string("description"))
                    -- print("generated text: "..reward_text)
                    local reward_item = stack:get_name()
                    stack:set_count(count)
                    -- print("generated:"..stack:get_name())
                    reward = {r_text = reward_text, r_item = reward_item}
                    inv:add_item(i, stack)
                    return reward
                end
            end
            reward_text = S(
                              "You are rewarded with @1 @2, but you cannot carry it",
                              count, meta:get_string("description"))
            -- print("generated text: "..reward_text)
            local reward_item = stack:get_name()
            -- print("generated:"..stack:get_name())
            reward = {r_text = reward_text, r_item = reward_item}
            minetest.add_item(pos, stack)
            -- print("generated text: "..reward_text)

                 return reward
        end
    end
    --if no reward available then give a regular item gift..
    local reward = witches.gift(self, pname)
    return reward
end

-- @witches.gift called by witches.found_item(self, clicker)
function witches.gift(self, pname, drop_chance_min, drop_chance_max, item_wear,
                      item_count)
    if not pname then
        witches.debug("no player defined!", "witches.gift")
        return
    end
    if not self.drops then
        witches.debug("no droplist defined in this mob!", "witches.gift")
        return
    end

    if not self.players[pname].gifts then
        -- self.players[pname] = {met = self.players[pname].met , favors = 0}
        self.players[pname].gifts = {}
    end

    -- print(v.name)

    local list = {}
    local reward_text = {}
    local reward_item = {}
    local reward = {}
    local inv = minetest.get_inventory({type = "player", name = pname})
    local pos = self.object:get_pos()
    pos.y = pos.y + 0.5

    drop_chance_min = drop_chance_min or 0
    drop_chance_max = drop_chance_max or 100

    for i = 1, #self.drops do
        if self.drops[i].chance <= drop_chance_max and self.drops[i].chance >=
            drop_chance_min then table.insert(list, self.drops[i]) end
    end

    witches.debug("reward list: " .. dump(list), "witches.gift")

    local item_ix = mr(#list)

    local item_name = list[item_ix].name

    local min = list[item_ix].min or 1
    local max = list[item_ix].max or 1

    witches.debug("reward list: " .. dump(list), "witches.gift")

    item_count = mr(min, max)

    if item_count < 1 then
        witches.debug("reward count 0" .. dump(list), "witches.gift")
        return 
    end
    local fate = mr(1,list[item_ix].chance)

    if  fate ~= 1 then
        witches.debug("gift did not pass chance" .. dump(list), "witches.gift")
        return end

        if not self.players[pname].gifts[item_name] then
        self.players[pname].gifts[item_name] = item_count
    else 
        self.players[pname].gifts[item_name] = self.players[pname].gifts[item_name] + item_count
    end
    witches.debug(dump(self.players[pname].gifts),"witches.gift")

    item_wear = item_wear or mr(8000, 10000)

    local stack = ItemStack({
        name = item_name,
        count = item_count,
        item_wear = item_wear or mr(8000, 10000)
    })

    local org_desc = minetest.registered_items[item_name].description
    local meta = stack:get_meta()
       meta:set_string("description", S("@1's @2", self.secret_name, org_desc))
       if meta:get_int("light_source") then
        local illum = meta:get_int("light_source")
        meta:set_int("light_source", illum + 1)
       end
       witches.debug("stack meta "..dump(meta),"witches.gift")
    -- print(dump(inv:get_lists()))
    for i, _ in pairs(inv:get_lists()) do
        -- print(i.." = "..dump(v))
        if i == "main" and stack and inv:room_for_item(i, stack) then
            reward_text = S("You are rewarded with " .. item_count .. " of @1",
                            meta:get_string("description"))
            -- print("generated text: "..reward_text)
            reward_item = stack:get_name()
            -- print("generated:"..stack:get_name())
            reward = {r_text = reward_text, r_item = reward_item}
            inv:add_item(i, stack)
            return reward
        else
        end
    end

    reward_text = S("You are rewarded with @1, but you cannot carry it",
                    meta:get_string("description"))
    -- print("generated text: "..reward_text)
    reward_item = stack:get_name()
    -- print("generated:"..stack:get_name())
    reward = {r_text = reward_text, r_item = reward_item}
    minetest.add_item(pos, stack)
    -- print("generated text: "..reward_text)
    return reward

end

function witches.attachment_check(self)
    if not self.owner or not self.owner:get_luaentity() then
        self.object:remove()
    else
        local owner_head_bone = self.owner:get_luaentity().head_bone
        -- local position,rotation = self.owner:get_bone_position(owner_head_bone)
        -- self.object:set_attach(self.owner, owner_head_bone, vector.new(0,0,0), rotation)
    end
end

function witches.stop_and_face(self, pos)
    mobs:yaw_to_pos(self, pos)
    self.state = "stand"
    self:set_velocity(0)
    self:set_animation("stand")
    self.attack = nil
    self.v_start = false
    self.timer = -5
    self.pause_timer = .25
    self.blinktimer = 0
    self.path.way = nil
end

-- why ?!
local function stop_and_face(self, pos) witches.stop_and_face(self, pos) end

function witches.award_witches_chest(self, player)
    if player and self.witches_chest and self.witches_chest_owner ==
        self.secret_name then
        local pname = ""
        local meta = minetest.get_meta(self.witches_chest_pos)

        if player:is_player() then pname = player:get_player_name() end

        meta:set_string("owner", pname)
        local sname = meta:get_string("secret_name")
        local info = {self.secret_name, sname, self.witches_chest_pos, pname}
        local pos_string = minetest.pos_to_string(info[3])
        local reward_text = S(
                                "You receive permission from @1 to access their magic chest located at @2!",
                                info[1], pos_string)
        local reward = {r_text = reward_text, r_item = "default:chest"}
        -- meta:set_string("infotext", S("@1's chest of @2", info[1], info[2]))
        meta:set_string("infotext", S("@1's unlocked chest", info[1]))
        self.witches_chest_owner = pname
        return reward
    end
end

function witches.claim_witches_chest(self)
    local pos = self.object:get_pos()
    pos.min = vector.subtract(pos, 10)
    pos.max = vector.add(pos, 10)
    local meta_table = minetest.find_nodes_with_meta(pos.min, pos.max)
    -- if meta_table then print(dump(meta_table)) end
    for i = 1, #meta_table do
        local meta = minetest.get_meta(meta_table[i])
        if meta:get_string("secret_type") == "witches_chest" then
            local sn = meta:get_string("secret_name")
            -- if sn then print(sn) end
            local o = meta:get_string("owner")
            if o and sn and sn == o then
                witches.debug("unbound chest found by: " .. self.secret_name,
                              "witches.claim_witches_chest")
                meta:set_string("secret_name", self.secret_name)
                -- meta:set_string("secret_name", self.secret_name)
                meta:set_string("infotext",
                                S("Sealed chest of @1", self.secret_name))
                self.witches_chest = self.secret_name
                self.witches_chest_owner = self.secret_name
                self.witches_chest_pos = meta_table[i]
            end
        end
    end
end

function witches.firefly_mod(self)
    if minetest.registered_tools["fireflies:bug_net"] then
        local check = 0
        for i = 1, #self.drops do
            if self.drops[i].name == "fireflies:bug_net" then
                check = check + 1
            end
        end

        if check < 1 then
            table.insert(self.drops, {
                name = "fireflies:bug_net",
                chance = 1000,
                min = 0,
                max = 1
            })
            table.insert(self.drops, {
                name = "fireflies:firefly_bottle",
                chance = 100,
                min = 0,
                max = 2
            })
        end
    end
end

function witches.item_list_check(list)
    witches.debug("full list " .. dump(list),"witches.item_list_check")
    for i, v in ipairs(list) do
        if not minetest.registered_items[v.name] then
            witches.debug(i .. ". " .. v.name ..
                              " not found and removing from list",
                          "witches.item_list_check")
            list[i] = nil
        end
    end
    witches.debug("new list: " .. dump(list), "witches.item_list_check")
    return list
end

function witches.item_request(self, name)
    self.speaking_to = name
    if not self.item_request then self.item_request = {} end
    if not self.item_request.item then
        -- we'd be in trouble if we dont have it already!
        self.item_request.item = witches.looking_for(self)

    end
    if not self.item_request.text then
        -- we need text for the quest!
        -- print("generating")
        local dialog_list = quest_dialogs(self)
        if not self.players then self.players = {} end
        if not self.players[name] then
            self.players[name] = {}
            -- if not self.players.met or #self.players.met < 1 or type(self.players.met) == string then

            -- table.insert(self.players_met, self.secret_name)
        end
        local intro_text = ""

        if not self.players[name].met then
            -- print(dump(self.players[name]))
            -- print( "We don't know "..name.."!")
            local dli_num = mr(1, #dialog_list.intro)
            intro_text = dialog_list.intro[dli_num]

            self.players[name] = {met = math.floor(os.time())}

        else
            -- print(dump(self.players.met))
            -- print( "We first met "..name.." ".. os.time() - self.players[name].met.." seconds ago")
            local dli_num = mr(1, #dialog_list.having_met)
            intro_text = dialog_list.having_met[dli_num]
        end

        -- print(intro_text)
        local quest_item = self.item_request.item.desc
        local dlr_num = mr(1, #dialog_list.item_request)
        local request_text = dialog_list.item_request[dlr_num]
        -- print(request_text)
        self.item_request.text = {intro = intro_text, request = request_text}
        -- print(dump(self.item_request.text))
        return self.item_request.text
    end
end

function witches.found_item(self, clicker)
    local item = clicker:get_wielded_item()
    local pname = clicker:get_player_name()
    if item and item:get_name() == self.item_request.item.name then
        if item:get_count() >= self.item_request.item.count then
            witches.found_item_ask.show_to(self, pname)
        else
            witches.find_item_quest.show_to(self, pname)
        end
    end
end

function witches.take_item(self, clicker)
    local item = clicker:get_wielded_item()

    if item and item:get_name() == self.item_request.item.name and
        item:get_count() >= self.item_request.item.count then
        local pname = clicker:get_player_name()

        if not minetest.settings:get_bool("creative_mode") then
            item:take_item(self.item_request.item.count)
            clicker:set_wielded_item(item)
        end

        if not self.players then
            witches.debug("no player records", "witches.found_item")
            self.players = {}
        end

        if not self.players[pname] then
            witches.debug("no records of this player name", "witches.found_item")
            self.players[pname] = {}
        end
        witches.debug(dump(self.players), "witches.found_item")
        if not self.players[pname].favors then
            -- self.players[pname] = {met = self.players[pname].met , favors = 0}
            self.players[pname].favors = 0
        end

        self.players[pname].favors = self.players[pname].favors + 1
        local reward = {}
        witches.debug(self.secret_name .. " has now received " ..
                          self.players[pname].favors .. " favors from " .. pname,
                      "witches.found_item")
        --every 5 favors give something special
        if self.players[pname].favors >= 5 and math.fmod(self.players[pname].favors,5) == 0
        then
            if self.witches_chest and self.witches_chest_owner ==
                self.secret_name then
                reward = witches.award_witches_chest(self, clicker)
            else
                -- define special gift args
                reward = witches.special_gifts(self, pname)
                witches.debug("special reward given", "witches.found_item")

            end
        else     
            reward = witches.gift(self, pname)
            witches.debug(dump(reward), "witches.found_item")
        end
        
        if reward and reward.r_text then
            self.players[pname].reward_text = reward.r_text
        end

        if reward and reward.r_item then
            witches.debug("reward: " .. reward.r_item, "witches.found_item")
            self.players[pname].reward_item = reward.r_item
        end

        -- end
        witches.found_item_quest.show_to(self, pname)

        self.item_request = nil
        -- change the requested item
        if self.special_follow then
            self.follow = {}
            self.follow_qty = 0
            self.item_request = {}
            witches.looking_for(self)
            --[[
             witches.item_list_check(self.special_follow)
            local ssf_idx = mr(#self.special_follow)
            local ssf_amt = mr(self.special_follow[ssf_idx].min,self.special_follow[ssf_idx].max)
            self.follow = {
                name = self.special_follow[ssf_idx].name
            }
            self.follow_amt = ssf_amt
            --]]

        end
        return item
    end

end

-- call this to set the self.item_request.item from the witches follow list!
function witches.looking_for(self)
    if not self.item_request then self.item_request = {} end

    if not self.item_request.item then

        if not self.follow or #self.follow < 1 then
            witches.item_list_check(self.special_follow)
            witches.debug(
                "looking for something but no self.follow so picking one of these: " ..
                    dump(self.special_follow), "witches.looking_for")
            self.follow = {}
            local ssf_idx = mr(#self.special_follow)
            local ssf_qty = mr(self.special_follow[ssf_idx].min,
                                        self.special_follow[ssf_idx].max)

            self.follow = {self.special_follow[ssf_idx].name}
            self.follow_qty = ssf_qty
            witches.debug(dump(self.follow) .. " picked", "witches.looking_for")
        end

        if self.follow and #self.follow >= 1 then
            if not self.follow_qty then self.follow_qty = 1 end
            -- print("testing: "..type(self.follow).." "..#self.follow.." "..dump(self.follow).." "..mr(1,#self.follow))
            witches.debug(self.secret_name .. "'s self.follow" ..
                              dump(self.follow) .. " " .. self.follow_qty,
                          "witches.looking_for")
            local item = self.follow[mr(1, #self.follow)]
            -- local stack = ItemStack({name = item})
            witches.debug(self.secret_name .. "'s chosen follow item: " .. item,
                          "witches.looking_for")

            local find = {
                name = minetest.registered_items[item].name,
                count = self.follow_qty or 1,
                desc = minetest.registered_items[item].description,
                icon = minetest.registered_items[item].inventory_image
            }
            -- local meta = item:get_meta()
            -- print_s(S(dump(desc)))
            -- print(dump(find))
            self.item_request.item = find
            return self.item_request
        end
    else
        return self.item_request
    end
end

-- first thing on right click
function witches.quests(self, clicker)
    local pname = clicker:get_player_name()
    -- print(pname.."  clicked on a witch!")
    local item = clicker:get_wielded_item()
    local pos = clicker:get_pos()
    stop_and_face(self, pos)

    -- make sure we are looking for an item
    witches.looking_for(self)

    local var1 = item:get_name()
    local var2 = self.name
    -- print(var1.."  "..var2)

    if var1 == var2 then
        self.dev_mode = pname
        witches.debug("dev mode active for: " .. pname, "witches.quests")
    end

    -- print("we are holding a "..dump(item:get_name()))
    if item:get_name() ~= self.item_request.item.name then
        -- create the dialog
        witches.item_request(self, pname)
        -- we can now show the quest!
        witches.find_item_quest.show_to(self, pname)
        -- now that we said what we had to say, we clean up!

        self.item_request.text = nil
        self.dev_mode = nil

        -- print(self.secret_name.." wants a ".. self.item_quest.name)
    elseif self.item_request and self.item_request.item and item and
        item:get_name() == self.item_request.item.name then
            if not item:get_count() then
                print("Warning: no items counted!!") return
            end
            if not self.item_request.item.count then
                print("Warning: no requested item counted") 
                self.item_request.item.count = 1
            end
        if item:get_count() >= self.item_request.item.count then
            -- print(self.item_quest.name.." and "..item:get_name())
            witches.found_item(self, clicker)
        else
            witches.item_request(self, pname)
            witches.find_item_quest.show_to(self, pname)
            self.item_request.text = nil
        end
    end

end

