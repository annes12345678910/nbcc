-- Great Giana Sisters for ComputerCraft
-- Copyright (c) Annes Widow - 2026

local config = require("config")
local music = require("streammusic")
local level = require("level")

local w,h = term.getSize()
if not (w == 51 and (h == 19 or h == 18)) then
    print("Screen has to be exactly 51x19 (or 51x18) pixels to play.")
    sleep(3)
    return
end

local speaker = peripheral.find("speaker")

term.setCursorBlink(false)

-- MUSICS

local function play_startmusic()
    while true do
        music.play("xadB80D5BkU") -- Track #1 on The Dev Team's Channel
    end
end

local function play_titlemusic()
    while true do
        os.sleep(0)
        music.play("nIgn5pXfBJc") -- Track #2
    end
end

local function play_stagemusic1()
    while true do
        os.sleep(0)
        music.play("9xngUpobFP8") -- Track #3 (replace with dev team's)
    end
end

-- SCREENS

local function wait_for_enter()
    repeat
        local _, key = os.pullEvent("key")
    until key == keys.enter
    -- intended to be used with parallel
end

local function startscreen()
    local startimage = paintutils.loadImage(config.basepath .. "assets/startscreen.nfp")

    print(startimage)

    paintutils.drawImage(startimage, 1, 1)
    --print(config.basepath .. "assets/startscreen.nfp")

    parallel.waitForAny(play_startmusic, wait_for_enter)
    music.stop()
end

local titlelevel = require("assets.level.title")
local creditstring = "SOUND BY C HUELSBECK                       WRITTEN BY ANNES WIDOW                            ARTWORK BY ANNES WIDOW"
local creditstringpos = #creditstring
local function titlescreen()
    while true do
        term.setBackgroundColor(colors.black)
        term.clear()

        term.setTextColor(colors.lime)

        term.setCursorPos(5, 1)
        term.write("PRESS         ENTER         TO         PLAY")
        
        term.setCursorPos(15, 2)
        term.write("\169 2026 BY ANNES WIDOW")

        creditstringpos = creditstringpos - 1

        term.setCursorPos(creditstringpos, 4)
        term.write(creditstring)

        if creditstringpos < -#creditstring then
            creditstringpos = #creditstring
        end

        level.camerascroll = level.camerascroll + 1
        level.draw_level(titlelevel.level)

        if level.camerascroll > 400 then
            level.camerascroll = -52
        end

        os.sleep(1 / 30)
    end
end

local function getreadyscreen()
    term.setTextColor(colors.yellow)
    term.setBackgroundColor(colors.black)

    term.clear()

    term.setCursorPos(18, 5)
    term.write("GIANA")
    term.setCursorPos(15, 6)
    term.write("GET  READY")
    term.setCursorPos(16, 7)
    term.write(("STAGE %02d"):format(level.currentstage))
    music.play_dfpwm(config.basepath .. "assets/sound/getready.dfpwm")
end

local stage1level = require("assets.level.stage1")
local function stage1screen()
    local function renderlevel()
        while true do
            --parallel.waitForAll(level.update_player, function ()
            --    level.update_physics(stage1level.level)
            --end)

            term.setBackgroundColor(colors.lightBlue)
            term.clear()

            level.draw_level(stage1level.level)
            level.draw_player()

            term.setCursorPos(1, 1)
            term.setBackgroundColor(colors.lightBlue)
            --term.write(("X: %.2f, Y: %.2f VX: %.2f VY: %.2f"):format(level.playerx, level.playery, level.velx, level.vely)) -- debug
            term.write("GIANA       BONUS        LIVES       STAGE     TIME")
            term.setCursorPos(1, 2)
            term.write(("%06d         %02d          %02d          %02d       %02d"):format(level.score, level.bonus, level.lives, level.currentstage, level.timeleft))
            os.sleep(1 / 30)
        end
    end
    level.playerx = stage1level.level.playerx
    level.playery = stage1level.level.playery
    parallel.waitForAll(level.update_player, function ()
        level.update_physics(stage1level.level)
    end, renderlevel)
end

-- MAIN
local function main()
    level.restore_default_palette()
    startscreen()
    parallel.waitForAny(titlescreen, wait_for_enter, play_titlemusic)
    music.stop()
    parallel.waitForAny(getreadyscreen, wait_for_enter)
    level.camerascroll = 0
    level.set_surface_palette()
    parallel.waitForAny(stage1screen, play_stagemusic1)
end

main()
level.restore_default_palette()
