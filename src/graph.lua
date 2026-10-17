graph = {}

function graph.DrawSquare(x, y, w, h, color)
    term.setBackgroundColor(color)

    for dy = 0, h - 1 do
        term.setCursorPos(x, y + dy)
        term.write(string.rep(" ", w))
    end
end

function graph.DrawSquareLines(x, y, w, h, color)
    paintutils.drawBox(x,y, x + w, y+h, color)
end

function graph.DrawText(x, y, text, color, bgcolor)
    if color then
        term.setTextColor(color)
    end
    if bgcolor then
        term.setBackgroundColor(bgcolor)
    end
    term.setCursorPos(x, y)
    term.write(text)
end

function graph.CheckPointRectCollision(px, py, rx, ry, rw, rh)
    return px >= rx and px <= rx + rw and 
           py >= ry and py <= ry + rh
end

return graph
