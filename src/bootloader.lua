graph = require("graph")
gui = require("gui")
eventpoll = require("eventpoll")
perps = require("perps")

local function main()

    local buttons = {
        {"NBCC", "/disk/main.lua"},
        {"CraftOS", "shell"}
    }

    if fs.exists("MinceOS/mainkernel.lua") then -- optional minceos
        table.insert(buttons, {"MinceOS", "/MinceOS/mainkernel.lua"})
    end

    while true do
        eventpoll.Poll()

        local width, height = term.getSize()
        term.setBackgroundColor(colors.black)
        term.clear()

        graph.DrawText((width / 2) - 20, 2, "NebulaOS ComputerCraft (NBCC) Bootloader", colors.white, colors.black)
        paintutils.drawBox(3, 3, width - 2, height - 2, colors.white)

        local i = 5
        for _, button in ipairs(buttons) do
            if perps.draw_button(4, i, width - 6, 3, button[1], colors.white, colors.gray) then
                term.setBackgroundColor(colors.black)
                shell.run("clear")
                shell.run(button[2])
            end
            i = i + 4
        end
    end
end

main()
