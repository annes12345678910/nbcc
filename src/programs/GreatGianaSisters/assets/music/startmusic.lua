-- DEPRECATED for the new streaming music system

startmusic = {}

-- Instruments: 1 = harp, 2 = bass, 3 = flute, 4 = hat (snare/click)

startmusic.music = {
    -- Intro Arpeggio Loop (Compressed data format)
    {"harp", 12, 2}, {"harp", 15, 2}, {"harp", 19, 2}, {"harp", 24, 2},
    {"harp", 14, 2}, {"harp", 17, 2}, {"harp", 21, 2}, {"harp", 24, 2},
    {"bass", 0,  4}, {"bass", 7,  4}, {"bass", 0,  4}, {"bass", 12, 4},
    
    -- Main Melodic hook start
    {"flute", 12, 4}, {"flute", 11, 4}, {"flute", 12, 4}, {"flute", 14, 4},
    {"harp", 12, 2}, {"hat", 0,  2}, {"harp", 16, 2}, {"hat", 0,  2},
    {"flute", 16, 4}, {"flute", 14, 4}, {"flute", 12, 4}, {"flute", 11, 4}
}

return startmusic
