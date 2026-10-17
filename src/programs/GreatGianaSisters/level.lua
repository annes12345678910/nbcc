level = {}

local config = require("config")

level.camerascroll = 0

level.tiletextures = {
    -- Example: water = <water image>
}

level.afps = { -- Animated thingies
    -- Example: gem = {gem1 = 0, gem2 = 15}
}

level.animframe = 0 -- From 0 to 30 because 30 fps
level.gravity = 0.05

local function getExtension(filename)
    return filename:match("^.+(%.%w+)$")
end

function level.draw_afp(afpname, x, y, flipit)
    local afpdata = level.afps[afpname]
    local tiletodraw = "bricks"
    local bestframe = -1

    for index, framedata in ipairs(afpdata) do
        if framedata[2] <= level.animframe and framedata[2] > bestframe then
            tiletodraw = framedata[1]
            bestframe = framedata[2]
        end
    end

    if flipit then
        paintutils.drawImage(level.flip_image_h(level.tiletextures[tiletodraw]), x, y)
        return
    end
    paintutils.drawImage(level.tiletextures[tiletodraw], x, y)
end

function level.flip_image_h(image) -- Important for player and enemies
    local flipped = {}
    local height = #image
    
    for y = 1, height do
        flipped[y] = {}
        local width = #image[y]
        for x = 1, width do
            -- Invert the X coordinate
            flipped[y][x] = image[y][width - x + 1]
        end
    end
    
    return flipped
end

for _, file in ipairs(fs.list(config.basepath .. "assets/tile/")) do
    if getExtension(file) == ".nfp" then
        level.tiletextures[file:gsub("%.%w+$", "")] = paintutils.loadImage(config.basepath .. "assets/tile/" .. file)
    end
    if getExtension(file) == ".afp" then
        local fa = fs.open(config.basepath .. "assets/tile/" .. file, "r")
        level.afps[file:gsub("%.%w+$", "")] = textutils.unserialiseJSON(fa.readAll())
        fa.close()
    end
end

level.isplayerflipped = false -- facing the left?
level.playerx = 1
level.playery = 1
level.isplayerwalking = false

level.keys_down = {}
level.playerwidth = 5
level.playerheight = 6
level.movespeed = 0.5
level.jumpspeed = -1
level.onground = false

level.lives = 03
level.bonus = 00
level.timeleft = 00
level.score = 000000

level.currentstage = 1
level.ispunk = false

function level.draw_player()
    if level.isplayerwalking then
        if level.ispunk then
            level.draw_afp("punkwalk", level.playerx - level.camerascroll, level.playery, level.isplayerflipped)
        else
            level.draw_afp("playerwalk", level.playerx - level.camerascroll, level.playery, level.isplayerflipped)
        end
    else
        if level.isplayerflipped then
            if level.ispunk then
                paintutils.drawImage(level.flip_image_h(level.tiletextures["punkidle"]), level.playerx - level.camerascroll, level.playery)
            else
                paintutils.drawImage(level.flip_image_h(level.tiletextures["playeridle"]), level.playerx - level.camerascroll, level.playery)
            end
            return
        end
        if level.ispunk then
            paintutils.drawImage(level.tiletextures["punkidle"], level.playerx - level.camerascroll, level.playery)
        else
            paintutils.drawImage(level.tiletextures["playeridle"], level.playerx - level.camerascroll, level.playery)
        end
    end
end

level.velx = 0 -- Relative x for player to move
level.vely = 0 -- Relative y for player to move

local speaker = peripheral.find("speaker")

function level.update_player()
    while true do
    local event, button, x, y = os.pullEvent()

    if event == "key" then
        level.keys_down[button] = true
        if button == keys.up and level.onground then
            speaker.playNote("iron_xylophone", 1, 15)
            level.vely = level.jumpspeed
        end
    elseif event == "key_up" then
        level.keys_down[button] = false
    end

    level.velx = 0

    if level.keys_down[keys.left] then
        level.isplayerflipped = true
        level.velx = -level.movespeed
    elseif level.keys_down[keys.right] then
        level.isplayerflipped = false
        level.velx = level.movespeed
    end

    level.isplayerwalking = level.velx ~= 0
    
    if level.playerx - level.camerascroll < 1 then
        level.playerx = level.camerascroll + 1
    end

    if level.playerx - level.camerascroll >= 25 then
        level.camerascroll = level.camerascroll + 1
    end

    end
end

function level.update_physics(leveldata)
    while true do
    
    -- Gravity
    if level.vely < 1 then
        level.vely = level.vely + level.gravity
    end

    -- Apply Y velocity
    level.playery = level.playery + level.vely

    -- ceiling collision
    if level.vely < 0 then
        local ceiling = level.check_ceiling(leveldata)
        if ceiling then
            level.playery = ceiling.y + 3
            level.vely = 0

            if ceiling.typ == "luck" then
                if ceiling.luck == "punkball" then
                    speaker.playNote("cow_bell", 3, 10)
                    level.ispunk = true
                    level.score = level.score + 50
                elseif ceiling.luck == "gem" then
                    speaker.playNote("chime", 3, 20)
                    level.bonus = level.bonus + 1
                    level.score = level.score + 25
                end
                leveldata.tiles[ceiling['index']].typ = "smooth"
            end

            if level.ispunk then
                if ceiling.canbreak then
                    speaker.playNote("snare", 3, 15)
                    level.score = level.score + 50
                    table.remove(leveldata.tiles, ceiling['index'])
                end
            end
        end
    end

    -- ground collision
    local ground = level.check_ground(leveldata)

    if ground and level.vely >= 0 then
        level.playery = ground.y - level.playerheight
        level.vely = 0
        level.onground = true
    else
        level.onground = false
    end

    -- x vel
    level.playerx = level.playerx + level.velx

    -- left and right collision

    if level.velx < 0 then
        local wall = level.check_left(leveldata)

        if wall then
            level.playerx = wall.x + 5
            level.velx = 0
        end

    elseif level.velx > 0 then
        local wall = level.check_right(leveldata)

        if wall then
            level.playerx = wall.x - level.playerwidth
            level.velx = 0
        end
    end

    os.sleep(1 / 30) -- pass to parallel
    end
end

function level.draw_level(leveldata)
    level.animframe = level.animframe + 1
    if level.animframe > 30 then
        level.animframe = 0
    end

    local tiles = leveldata["tiles"]

    for _, tile in ipairs(tiles) do
        -- {typ = "tiletype", x = 0, y = 0}
        if level.tiletextures[tile["typ"]] then
            paintutils.drawImage(level.tiletextures[tile["typ"]], tile['x'] - level.camerascroll, tile['y'])
            
        end
        if level.afps[tile["typ"]] then
            level.draw_afp(tile["typ"], tile['x'] - level.camerascroll, tile['y'])
        end
    end
end

function level.check_ground(leveldata)
    for _, tile in ipairs(leveldata.tiles) do
        if tile.solid then
            if level.rect_collision(
                level.playerx,
                level.playery + level.playerheight,
                level.playerwidth,
                1,
                tile.x,
                tile.y,
                5,
                3
            ) then
                return tile
            end
        end
    end

    return nil
end

function level.check_ceiling(leveldata)
    for index, tile in ipairs(leveldata.tiles) do
        if tile.solid then
            if level.rect_collision(
                level.playerx,
                level.playery,
                level.playerwidth,
                1,
                tile.x,
                tile.y,
                5,
                3
            ) then
                tile['index'] = index
                return tile
            end
        end
    end

    return nil
end

function level.check_left(leveldata)
    for _, tile in ipairs(leveldata.tiles) do
        if tile.solid then
            if level.rect_collision(
                level.playerx,
                level.playery,
                1,
                level.playerheight,
                tile.x,
                tile.y,
                5,
                3
            ) then
                return tile
            end
        end
    end

    return nil
end

function level.check_right(leveldata)
    for _, tile in ipairs(leveldata.tiles) do
        if tile.solid then
            if level.rect_collision(
                level.playerx + level.playerwidth,
                level.playery,
                1,
                level.playerheight,
                tile.x,
                tile.y,
                5,
                3
            ) then
                return tile
            end
        end
    end

    return nil
end

function level.rect_collision(ax, ay, aw, ah, bx, by, bw, bh)
    return ax < bx + bw
       and ax + aw > bx
       and ay < by + bh
       and ay + ah > by
end

function level.restore_default_palette()
    for i = 0, 15 do
        local c = 2 ^ i
        term.setPaletteColour(c, term.nativePaletteColour(c))
    end
end

function level.set_surface_palette()
    term.setPaletteColour(colors.lightGray, 0x7F664f)
end

return level
