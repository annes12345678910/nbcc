graph = require("graph")
gui = require("gui")
eventpoll = require("eventpoll")
perps = require("perps")

local scrolly = 0

local function buttonwithicon(image, text, desc, x, y, w)
    graph.DrawSquare(x, y, 12, 8, colors.lightGray)
    paintutils.drawImage(image, x + 1, y + 1)
    local er = perps.draw_button(x + 12, y, w, 8, text, colors.white, colors.gray)

    term.setCursorPos(x + 13, y + 3)
    print(desc)

    return er
end

local function main()
    local programs = {}
    --[[
        {
            "title",
            image,
            "desc"
        }
    ]]--

    local prgbasefolders = fs.list("/disk/programs")
    for _, basefolder in ipairs(prgbasefolders) do -- load programs from the programs folder
        if fs.isDir("/disk/programs/"..basefolder) then
            local programtoadd = {
                basefolder, 
                paintutils.loadImage(fs.combine(fs.combine("/disk/programs", basefolder), "icon.nfp"))
            }

            local f = fs.open(fs.combine(fs.combine("/disk/programs", basefolder), "desc"), "r")
            local desc = f.readAll()
            f.close()

            table.insert(programtoadd, desc)

            table.insert(programs, programtoadd)
        end
    end

    perps.PrintTable(programs, 4)

    while true do
        eventpoll.Poll()

        if eventpoll.CurrentEvent.type == "mouse_scroll" then
            scrolly = scrolly + eventpoll.CurrentEvent.button
            --perps.monitor_debug(("SCROLL %i"):format(scrolly))
        end

        local width, height = term.getSize()
        term.setBackgroundColor(colors.blue)
        term.clear()

        local i = scrolly + 10

        for _, program in ipairs(programs) do
            if buttonwithicon(program[2], program[1], program[3], 1, i, width) then
                term.setBackgroundColor(colors.black)
                term.clear()
                shell.run(fs.combine(fs.combine("/disk/programs", program[1]), "launch.lua"))
            end
            i = i + 9
        end
    end
end

main()
