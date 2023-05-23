--[[
    Mobs Takodachi — Adds takodachis to Minetest.
    Written in 2022‒2023 by Silver Sandstone <@SilverSandstone@craftodon.social>

    To the extent possible under law, the author has dedicated all copyright
    and related and neighbouring rights to this file to the public
    domain worldwide. This software is distributed without any warranty.

    You should have received a copy of the CC0 Public Domain Dedication
    along with this software. If not, see
    <https://creativecommons.org/publicdomain/zero/1.0/>.
]]


--- Mobs Takodachi


local S = minetest.get_translator('mobs_takodachi');


mobs_takodachi = {};

mobs_takodachi.EXPRESS_INTERVAL = 2.0;

mobs_takodachi.rng = PseudoRandom(0x77616821);

mobs_takodachi.expressions =
{
    [0] = 'mobs_takodachi_face.png';
    'mobs_takodachi_expression_01.png',
    'mobs_takodachi_expression_02.png',
    'mobs_takodachi_expression_03.png',
    'mobs_takodachi_expression_04.png',
    'mobs_takodachi_expression_05.png',
    'mobs_takodachi_expression_06.png',
    'mobs_takodachi_expression_07.png',
};


local hitbox = {-7/16,  0/16, -7/16,
                 7/16, 15/16,  7/16,
                 rotate = true};


--- Takodachi mob definition.
mobs_takodachi.Takodachi =
{
    type            = 'animal';
    hp_min          = 10;
    hp_max          = 10;
    fly             = true;
    fly_in          = {'air', 'group:airlike', 'group:water'};
    sounds          =
    {
        damage      = {name = 'mobs_takodachi_bonk', pitch = 0.75};
        death       = {name = 'mobs_takodachi_ascend', gain = 0.75};
    };

    visual          = 'mesh';
    visual_size     = vector.new(10, 10, 10);
    mesh            = 'mobs_takodachi.obj';
    textures        = {'mobs_takodachi.png^mobs_takodachi_face.png'};
    blood_texture   = 'mobs_takodachi_tskr.png';
    collisionbox    = hitbox;
    selectionbox    = hitbox;
    textures        = 'mobs_takodachi.png';
    rotate          = 180;
};

--- Initialises a takodachi.
-- @param staticdata Ignored.
-- @param def        Ignored.
-- @param dtime      Ignored.
function mobs_takodachi.Takodachi:after_activate(staticdata, def, dtime)
    if not self.scale then
        self.scale = mobs_takodachi.rng:next(5, 12);
        if mobs_takodachi.chance(1, 64) then
            self.scale = self.scale * 8;
        end;
    end;
    local scaled_hitbox = table.copy(hitbox);
    for index, value in ipairs(scaled_hitbox) do
        scaled_hitbox[index] = value * self.scale / 10;
    end;
    self.base_colbox = scaled_hitbox;
    self.base_selbox = scaled_hitbox;
    self.object:set_properties(
    {
        visual_size  = vector.new(self.scale, self.scale, self.scale);
        collisionbox = scaled_hitbox;
        selectionbox = scaled_hitbox;
    });
end;

--- Called every tick for each takodachi.
-- @param dtime Seconds since the last tick.
function mobs_takodachi.Takodachi:do_custom(dtime)
    self.express_timer = (self.express_timer or 0.0) + dtime;
    if self.express_timer >= mobs_takodachi.EXPRESS_INTERVAL then
        mobs_takodachi.Takodachi.express(self);
        if mobs_takodachi.chance(1, 24) then
            mobs_takodachi.Takodachi.wah(self);
        end;
    end;
end;

--- Handles a takodachi being right-clicked.
-- @param clicker The player clicking the takodachi.
function mobs_takodachi.Takodachi:on_rightclick(clicker)
    mobs_takodachi.Takodachi.wah(self);
    mobs_takodachi.Takodachi.express(self, true);
end;

--- Says ‘wah!’
function mobs_takodachi.Takodachi:wah()
    local sound = 'mobs_takodachi_wah';
    local smolness = math.sqrt(10 / (self.scale or 10));
    local pitch = mobs_takodachi.frand(1.0, 1.1) * smolness;
    local params = {pos = self.object:get_pos(), pitch = pitch};
    minetest.sound_play(sound, params, true);
end;

--- Shows a random expression, or resets to the default expression.
-- @param force If this is true, a non-default expression will always be shown.
function mobs_takodachi.Takodachi:express(force)
    local index = 0;
    if force or mobs_takodachi.chance(1, 12) then
        index = mobs_takodachi.rng:next(1, #mobs_takodachi.expressions);
    end;
    if force or mobs_takodachi.chance(1, 12) then
        mobs_takodachi.Takodachi.waggle(self);
    end;

    local overlay = mobs_takodachi.expressions[index];
    local texture = 'mobs_takodachi.png';
    if overlay then
        texture = texture .. '^' .. overlay;
    end;
    if texture ~= self.current_texture then
        self.object:set_properties{textures = {texture}};
        self.current_texture = texture;
    end;
    self.express_timer = 0.0;
end;

--- Waggles the ears.
function mobs_takodachi.Takodachi:waggle()
    local frames =
    {
        'mobs_takodachi_waggle.obj',
        'mobs_takodachi.obj',
        'mobs_takodachi_waggle.obj',
        'mobs_takodachi.obj',
    };
    for index, mesh in ipairs(frames) do
        minetest.after((index - 1) * 0.125, function() self.object:set_properties{mesh = mesh}; end);
    end;
end;


mobs:register_mob('mobs_takodachi:takodachi', mobs_takodachi.Takodachi);
mobs:register_egg('mobs_takodachi:takodachi', S'Takodachi', 'mobs_takodachi_inv.png');

mobs:spawn(
{
   name         = 'mobs_takodachi:takodachi';
   nodes        = {'group:cracky', 'group:crumbly', 'group:choppy', 'group:water'};
   min_light    = 7;
});


if minetest.get_modpath('subtitles') then
    subtitles.register_description('mobs_takodachi_wah',    S'Takodachi wahs');
    subtitles.register_description('mobs_takodachi_bonk',   S'Takodachi gets bonked');
    subtitles.register_description('mobs_takodachi_ascend', S'Takodachi ascends');
end;


--- Returns a random float within the specified range.
-- @param min The minimum value.
-- @param max The maximum value.
-- @return    A float between `min` and `max`.
function mobs_takodachi.frand(min, max)
    return min + mobs_takodachi.rng:next() * (max - min) / 32768;
end;

--- Has a (dart) in (board) chance of returning true.
-- @param dart  The size of the dart.
-- @param board The size of the board.
-- @return      true or false, with the specified probability.
function mobs_takodachi.chance(dart, board)
    return mobs_takodachi.rng:next(1, board) <= dart;
end;
