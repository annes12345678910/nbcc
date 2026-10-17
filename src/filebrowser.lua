local eventpoll = require("eventpoll")
local graph = require("graph")
local perps = require("perps")
local filemenus = require("filemenus")

local scrolly = 0
local path = ... or "/"

local function main()
    while true do
        eventpoll.Poll()

        if eventpoll.CurrentEvent.type == "mouse_scroll" then
            scrolly = scrolly + eventpoll.CurrentEvent.button
            --perps.monitor_debug(("SCROLL %i"):format(scrolly))
        end

        local w, h = term.getSize()
        term.setBackgroundColor(colors.gray)
        term.clear()

        local items = fs.list(path)

        local maxScroll = math.max(0, #items * 4 - h)

        --scrolly = math.max(-maxScroll, math.min(0, scrolly))

        local i = 10 + scrolly

        for _, name in ipairs(items) do
            local fullPath = fs.combine(path, name)

            if i + 2 >= 6 and i <= h then
                if perps.draw_button(
                    1,
                    i,
                    w,
                    3,
                    name,
                    colors.white,
                    colors.black
                ) then
                    if fs.isDir(fullPath) then
                        path = fullPath
                        scrolly = 0
                    else
                        shell.switchTab(shell.openTab("edit", fullPath))
                    end
                end
            end

            i = i + 4
        end

        graph.DrawSquare(1, 1, w, 4, colors.black)
        if perps.draw_button(1, 1, 3, 3, "<", colors.white, colors.blue) then
            path = fs.getDir(path)
        end
        graph.DrawText(5, 2, path, colors.white, colors.black)

        if perps.draw_button(10, 3, 10, 2, "New File", colors.white, colors.green) then
            --term.setCursorPos(math.floor(w / 2), math.floor(h / 2))
            --term.setBackgroundColor(colors.green)
            local inputa = filemenus.itemmenu(colors.green)
            shell.switchTab(shell.openTab("edit", fs.combine(path, inputa)))
        end

        if perps.draw_button(21, 3, 13, 2, "Delete Item", colors.white, colors.red) then
            local inputa = filemenus.itemmenu(colors.red)
            fs.delete(fs.combine(path, inputa))
        end

        if perps.draw_button(35, 3, 12, 2, "New Folder", colors.white, colors.lightBlue) then
            local inputa = filemenus.itemmenu(colors.lightBlue)
            fs.makeDir(fs.combine(path, inputa))
        end

        graph.DrawText(1, 4, ("SCROLL %i"):format(scrolly), colors.white, colors.black)
        
        os.sleep(0)
    end
end

main()
