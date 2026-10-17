local perps = require("perps")
local eventpoll = require("eventpoll")
local filemenus = require("filemenus")
local graph = require("graph")

local perplist = {
    front = peripheral.wrap("front"),
    back = peripheral.wrap("back"),
    left = peripheral.wrap("left"),
    right = peripheral.wrap("right"),
    top = peripheral.wrap("top"),
    bottom = peripheral.wrap("bottom")
}

local function skibidi_perp_icon(side, x, y)
    if perps.draw_perp_icon(side, x, y) then
        shell.switchTab(shell.openTab("/disk/perpinfo.lua", side))
    end
end

local function main()

    while true do
        eventpoll.Poll()

        local width, height = term.getSize()
        term.setBackgroundColor(colors.gray)
        term.clear()

        skibidi_perp_icon("right", 3, 9)
        skibidi_perp_icon("front", 11, 9)
        skibidi_perp_icon("left", 19, 9)
        skibidi_perp_icon("back", 27, 9)

        skibidi_perp_icon("top", 19, 2)
        skibidi_perp_icon("bottom", 19, 16)
    end
end

main()
