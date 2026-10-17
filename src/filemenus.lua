graph = require("graph")

local filemenus = {}

function filemenus.itemmenu(color)
    local width, height = term.getSize()
    graph.DrawSquare((width / 2) - 6, (height / 2) - 4, 12, 5, color)
    term.setCursorPos((width / 2) - 6, (height / 2))
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)
    local inp = read(nil, nil, shell.complete)
    return inp
end

function filemenus.getfilenameonly(filenamewithext)
    return string.match(filenamewithext, "(.+)%.[^%.]+$") or filenamewithext
end

return filemenus
