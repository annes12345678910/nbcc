graph = require("graph")
gui = {}
eventpoll = require("eventpoll")

function gui.DrawButton(x, y, w, h, text, textcolor, bgcolor)
    graph.DrawSquare(x, y, w, h, bgcolor)
    graph.DrawText(x + 1, y + 1, text, textcolor, bgcolor)

    if eventpoll.CurrentEvent.type == "mouse_click" and graph.CheckPointRectCollision(eventpoll.CurrentEvent.x, eventpoll.CurrentEvent.y, x, y, w, h) then
        return true
    end
    return false
end

return gui
