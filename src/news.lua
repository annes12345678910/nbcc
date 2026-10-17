local eventpoll = require("eventpoll")
local graph = require("graph")

local link = "https://raw.githubusercontent.com/Annes-Dev-Team/nbcc-core-files/refs/heads/main/news.json"
local debugmonitor = peripheral.find("monitor")

local scrolly = 0

local function main()
    local response = http.get(link)
    if not response then
        print("HTTP failed")
        return
    end
    local data = response.readAll()

    local newslist = textutils.unserializeJSON(data)

    response.close()
    print(data)
    
    local oldterm = term.redirect(debugmonitor)

    paintutils.drawImage(paintutils.parseImage(table.concat(newslist[1]["image"], "\n")), 1, 1)
    term.redirect(oldterm)
    print(os.date("Published in %Y-%m-%d", newslist[1]["date"]))

    while true do
        eventpoll.Poll()

        if eventpoll.CurrentEvent.type == "mouse_scroll" then
            scrolly = scrolly + eventpoll.CurrentEvent.button
            --perps.monitor_debug(("SCROLL %i"):format(scrolly))
        end

        local w, h = term.getSize()
        term.setBackgroundColor(colors.gray)
        term.clear()

        local nan = scrolly
        for index, news in ipairs(newslist) do
            graph.DrawSquare(w/4, nan, 30, 15, colors.lightGray)
            paintutils.drawImage(paintutils.parseImage(table.concat(news["image"], "\n")), w / 4, nan)
            graph.DrawText(w / 4, nan + 11, news['title'], colors.black)
            graph.DrawText(w / 4, nan + 12, news['desc'], colors.gray)
            graph.DrawText(w / 4, nan + 13, os.date("Published in %Y-%m-%d", news["date"]), colors.blue)
            nan = nan + 17
        end
    end
end

main()
