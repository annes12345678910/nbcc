local gui = require("gui")
local filemenus = require("filemenus")

perps = {}

perps.Monitors = { peripheral.find("monitor") }
perps.Speakers = { peripheral.find("speaker") }
perps.Drives = { peripheral.find("drive") }
perps.CurrentMonitor = perps.Monitors[1]
perps.CurrentSpeaker = perps.Speakers[1]

function perps.monitor_debug(text)
    if not perps.CurrentMonitor then
        return 
    end
    local tert = term.redirect(perps.CurrentMonitor)
    print(text)
    term.redirect(tert)
end

function perps.speaker_note(instrument, volume, pitch)
    if not perps.CurrentSpeaker then
        return 
    end
    perps.CurrentSpeaker.playNote(instrument, volume, pitch)
end

function perps.draw_button(x, y, w, h, text, textcolor, bgcolor)
    local doe = gui.DrawButton(x, y, w, h, text, textcolor, bgcolor)
    if doe == true then
        perps.speaker_note("harp", 0.5, 24)
        perps.monitor_debug("BUTTON CLICK")
    end
    return doe
end

function perps.PrintTable(tbl, indent)
    indent = indent or 0
    -- Handle cases where the input isn't actually a table
    if type(tbl) ~= "table" then
        perps.monitor_debug(string.rep("  ", indent) .. tostring(tbl))
        return
    end
    
    for k, v in pairs(tbl) do
        -- Format keys nicely depending on whether they are strings or numbers
        local key = type(k) == "string" and '["' .. k .. '"]' or '[' .. k .. ']'
        
        if type(v) == "table" then
            print(string.rep("  ", indent) .. key .. " = {")
            perps.PrintTable(v, indent + 1)
            perps.monitor_debug(string.rep("  ", indent) .. "}")
        else
            -- Print primitive values
            local value = type(v) == "string" and '"' .. tostring(v) .. '"' or tostring(v)
            perps.monitor_debug(string.rep("  ", indent) .. key .. " = " .. value)
        end
    end
end

perps.perpicons = {

}

for _, pif in ipairs(fs.list("/disk/perpicons")) do
    perps.perpicons[filemenus.getfilenameonly(pif)] = paintutils.loadImage("/disk/perpicons/" .. filemenus.getfilenameonly(pif) .. ".nfp")
end

function perps.draw_perp_icon(side, x, y)
    graph.DrawText(x, y - 1, side, colors.white, colors.black)

    if not peripheral.getType(side) then return end
    if perps.draw_button(x, y, 7, 6, "", colors.black, colors.white) then
        return true
    end

    paintutils.drawImage(perps.perpicons[ peripheral.getType(side) ], x + 1, y + 1)
    return false
end

return perps
