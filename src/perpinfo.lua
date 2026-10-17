-- Usage: perpinfo <side>

local perps = require("perps")
local eventpoll = require("eventpoll")
local graph = require("graph")
local filemenus = require("filemenus")

local dfpwm = require("cc.audio.dfpwm")

local decoder = dfpwm.make_decoder()

local side = ...

if not side then
    print("Usage: perpinfo <side>")
    return
end

local sidetype = peripheral.getType(side)
local sidewrapped = peripheral.wrap(side)

local function main()
    while true do
        eventpoll.Poll()

        local width, height = term.getSize()
        term.setBackgroundColor(colors.gray)
        term.clear()
        perps.draw_perp_icon(side, 5, 5)

        graph.DrawText(13, 5, ("Type: %s"):format(sidetype), colors.white, colors.gray)

        if sidetype == "drive" then -- Drive options
            local diskinserted = "None"

            if disk.isPresent(side) then
                if disk.hasAudio(side) then
                    diskinserted = ("Music record with title %s"):format(disk.getAudioTitle(side))
                    
                    if perps.draw_button(21, 9, 16, 3, "Play Audio", colors.white, colors.green) then
                        disk.playAudio(side)
                    end
                end
                if disk.hasData(side) then
                    diskinserted = ("Data disk with mount path [%s]"):format(disk.getMountPath(side))

                    if perps.draw_button(21, 9, 16, 3, "Open Directory", colors.white, colors.green) then
                        shell.switchTab(shell.openTab("/disk/filebrowser.lua", "/" .. disk.getMountPath(side)))
                    end
                end

                if perps.draw_button(13, 9, 7, 3, "Eject", colors.white, colors.red) then
                    disk.eject(side)
                    return
                end
            end
            graph.DrawText(13, 7, diskinserted, colors.white, colors.gray)
        end

        if sidetype == "speaker" then -- Speaker options
            if perps.draw_button(21, 9, 12, 3, "Play DFPWM", colors.white, colors.green) then
                for chunk in io.lines(filemenus.itemmenu(colors.green), 16 * 1024) do
                    local buffer = decoder(chunk)

                    while not sidewrapped.playAudio(buffer) do
                        os.pullEvent("speaker_audio_empty")
                    end
                end
            end
        end

        if sidetype == "monitor" then -- Monitor options
            if perps.draw_button(21, 9, 13, 3, "Run Program", colors.white, colors.green) then
                shell.run("monitor", side, filemenus.itemmenu(colors.green))
            end
        end
    end
end

main()
