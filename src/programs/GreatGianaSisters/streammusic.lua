local music = {}

local api_base_url = "https://ipod-2to6magyna-uc.a.run.app/"
local version = "2.1"
local decoder = require "cc.audio.dfpwm".make_decoder()

local speaker = peripheral.find("speaker")
if not speaker then
    --error("No speaker attached.", 0)
end

local streaming = false

-- Stop playback immediately
function music.stop()
    streaming = false
    speaker.stop()
end

-- Stream and play a track by its YouTube ID
function music.play(id)
    if not speaker then
        os.sleep(60)
        return
    end
    music.stop()
    streaming = true

    local url = api_base_url .. "?v=" .. version .. "&id=" .. textutils.urlEncode(id)
    
    local response, err = http.get({url = url, binary = true})
    if not response then
        print("Error: " .. (err or "Connection failed"))
        streaming = false
        return
    end

    local start = response.read(4)
    local size = 16 * 1024 - 4
    
    while streaming do
        local chunk = response.read(size)
        if not chunk then break end
        
        if start then
            chunk = start .. chunk
            start = nil
            size = size + 4
        end

        local buffer = decoder(chunk)
        while streaming and not speaker.playAudio(buffer, 1.5) do
            os.pullEvent("speaker_audio_empty")
        end
    end

    response.close()
    streaming = false
end

function music.play_dfpwm(file)
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
