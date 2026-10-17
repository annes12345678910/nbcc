music = {}

local dfpwm = require("cc.audio.dfpwm")
local decoder = dfpwm.make_decoder()

function music.play_track(track, speaker)
    if not speaker then
        return
    end
    for _, note in ipairs(track) do
        local instrument = note[1]
        local pitch = note[2]
        local delay = note[3]

        -- playNote(instrument, volume, pitch)
        -- Volume ranges from 0.0 to 3.0
        speaker.playNote(instrument, 1.0, pitch)

        -- If a delay is defined, pause execution before the next note
        if delay > 0 then
            os.sleep(delay * 0.05) -- minecraft ticks
        end
    end
end

function music.play_dfpwm(file, speaker)
    if not speaker then
        return
    end
    for chunk in io.lines(file, 16 * 1024) do
        local buffer = decoder(chunk)
        while not speaker.playAudio(buffer) do
            os.pullEvent("speaker_audio_empty")
        end
    end
end

return music
