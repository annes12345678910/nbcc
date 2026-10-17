graph = require("graph")
gui = require("gui")
eventpoll = require("eventpoll")
perps = require("perps")
filemenus = require("filemenus")

local LogoImage = paintutils.loadImage("disk/nbcclogo.nfp")
local CursorImage = paintutils.loadImage("disk/cursor.nfp")

ShouldCursorShow = false
CursorX = 0
CursorY = 0

local function main()
    while true do
        eventpoll.Poll()
        if eventpoll.CurrentEvent.type == "mouse_click" then
            perps.monitor_debug(("Clicked button %s at %d, %d"):format(eventpoll.CurrentEvent.button, eventpoll.CurrentEvent.x, eventpoll.CurrentEvent.y))
            --speaker_note("harp", 0.5, 24)
            ShouldCursorShow = true
            CursorX = eventpoll.CurrentEvent.x
            CursorY = eventpoll.CurrentEvent.y
        elseif eventpoll.CurrentEvent.type == "key" then
            --[[if button == keys.rightCtrl then
                print("back to CraftOS")
                os.queueEvent("terminate")
            end]]--
        elseif eventpoll.CurrentEvent.type == "mouse_up" then
            ShouldCursorShow = false
        end
        local width, height = term.getSize()
        term.setBackgroundColor(colors.lightGray)
        term.clear()
        graph.DrawSquare(width - 2, height - 2, 2, 2, colors.blue)
        paintutils.drawImage(LogoImage, height - 12, 1)
        graph.DrawText(1, 1, string.format("%d, %d", width, height), colors.white, colors.blue)

        if perps.draw_button(1, height - 3, 19, 3, "Open File Browser", colors.red, colors.blue) then
            shell.switchTab(shell.openTab("/disk/filebrowser.lua"))
        end

        if perps.draw_button(21, height - 3, 19, 3, "New Shell Session", colors.white, colors.yellow) then
            shell.switchTab(shell.openTab("shell"))
        end

        if perps.draw_button(21, height - 7, 19, 3, "Open Program Manager", colors.green, colors.red) then
            shell.switchTab(shell.openTab("/disk/programmanager.lua"))
        end

        if perps.draw_button(1, height - 7, 19, 3, "New program from file", colors.blue, colors.green) then
            local programname = io.read()
            fs.makeDir("/disk/programs/"..programname)
            local launchfile = filemenus.itemmenu(colors.green)
            fs.copy(launchfile, "/disk/programs/"..programname.."/launch.lua")
            shell.run("edit", "/disk/programs/"..programname.."/desc")

            fs.move("/disk/programs/"..programname.."/desc.lua", "/disk/programs/"..programname.."/desc") -- prevent the edit quirk

            shell.run("paint", "/disk/programs/"..programname.."/icon.nfp")
        end

        if perps.draw_button(21, height - 12, 19, 3, "Manage Peripherals", colors.black, colors.gray) then
            shell.switchTab(shell.openTab("/disk/perpmanager.lua"))
        end

        if perps.draw_button(21, height - 17, 19, 3, "The News", colors.green, colors.white) then
            shell.switchTab(shell.openTab("/disk/news.lua"))
        end

        if perps.draw_button(41, height - 17, 7, 3, "Store", colors.red, colors.yellow) then
            shell.switchTab(shell.openTab("/disk/store.lua"))
        end

        if ShouldCursorShow then
            paintutils.drawImage(CursorImage, CursorX, CursorY)
        end
        os.sleep(0)
    end
end

main()
