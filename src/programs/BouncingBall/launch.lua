-- Simple Object Definition
local ball = {
    x = 5, y = 5,
    vx = 1, vy = 0,
    gravity = 0.5,
    bounce = -0.7
}

local termWidth, termHeight = term.getSize()

term.setCursorBlink(false)

while true do
    -- Apply Gravity & Physics
    ball.vy = ball.vy + ball.gravity
    ball.x = ball.x + ball.vx
    ball.y = ball.y + ball.vy
    
    -- Floor Collision
    if ball.y >= termHeight then
        ball.y = termHeight
        ball.vy = ball.vy * ball.bounce
    end
    
    -- Wall Collisions
    if ball.x >= termWidth or ball.x <= 1 then
        ball.vx = ball.vx * ball.bounce
    end

    local event, button, x, y = os.pullEvent()
    if event == "key" then
        if button == keys.space then
            ball.vy = 5
        end
    end
    -- Render
    term.clear()
    term.setCursorPos(math.floor(ball.x), math.floor(ball.y))
    term.write("O")
    
    sleep(0.05) -- Cap the frame rate/simulation step
end
