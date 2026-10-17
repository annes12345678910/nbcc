eventpoll = {}

eventpoll.IsMouseDown = false
eventpoll.CurrentEvent = nil

function eventpoll.Poll()
    local event, button, x, y = os.pullEvent()

    eventpoll.CurrentEvent = {
        type = event,
        button = button,
        x = x,
        y = y
    }

    if event == "mouse_click" then
        eventpoll.IsMouseDown = true
    elseif event == "mouse_up" then
        eventpoll.IsMouseDown = false
    end

    return eventpoll.CurrentEvent
end

function eventpoll.IsMouseClicked()
    return eventpoll.CurrentEvent
        and eventpoll.CurrentEvent.type == "mouse_click"
end

return eventpoll
