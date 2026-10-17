local eventpoll = require("eventpoll")
local graph = require("graph")
local perps = require("perps")

local link = "https://raw.githubusercontent.com/Annes-Dev-Team/nbcc-core-files/refs/heads/main/store.json"
local folderpath = "/games/"

local scrolly = 0

local function main()
    local response = http.get(link)
    if not response then
        print("HTTP failed")
        return
    end
    local data = response.readAll()

    local storelist = textutils.unserializeJSON(data)

    response.close()
    print(data)

    while true do
        eventpoll.Poll()

        if eventpoll.CurrentEvent.type == "mouse_scroll" then
            scrolly = scrolly + eventpoll.CurrentEvent.button
        end

        local w, h = term.getSize()
        term.setBackgroundColor(colors.lightBlue)
        term.clear()

        local nan = scrolly
        for index, gameentry in ipairs(storelist) do
            if perps.draw_button(w / 4, nan, 30, 5, "", colors.black, colors.gray) then
                if fs.exists(folderpath .. gameentry['file']) then
                    term.setBackgroundColor(colors.black)
                    term.setTextColor(colors.white)
                    term.clear()
                    term.setCursorPos(1,1)
                    shell.run(folderpath .. gameentry['file'])
                    perps.CurrentMonitor.setTextScale(1)
                else
                    shell.run("pastebin", "get", gameentry['pastebin'], folderpath .. gameentry['file'])
                end
            end
            graph.DrawText(w / 4, nan, gameentry['title'], colors.green)
            if fs.exists(folderpath .. gameentry['file']) then
                graph.DrawText(w / 4, nan + 1, "Installed", colors.blue)
            end
            graph.DrawText(w / 4, nan + 2, gameentry['desc'], colors.black)
            graph.DrawText(w / 4, nan + 4, ("Pastebin: %s"):format(gameentry['pastebin']), colors.yellow)
            nan = nan + 10
        end
    end
end

main()
