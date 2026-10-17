titlelevel = {}

-- remember that most tiles are 5 x 3 or a multiple of that.
titlelevel.level = {
    -- The text is from y 1 to 5 so start from y 6

    isplayer = false,
    playerx = 0,
    playery = 0,

    tiles = {
        --*-- The --*--

        -- T --
        -- "-"
        {
            typ = "bricks",
            x = 1,
            y = 6
        },
        {
            typ = "bricks",
            x = 6,
            y = 6
        },
        {
            typ = "bricks",
            x = 11,
            y = 6
        },

        -- "|"
        {
            typ = "bricks",
            x = 6,
            y = 9
        },
        {
            typ = "bricks",
            x = 6,
            y = 12
        },
        
        -- H --
        -- "|"
        {
            typ = "bricks",
            x = 18,
            y = 6
        },
        {
            typ = "bricks",
            x = 18,
            y = 9
        },
        {
            typ = "bricks",
            x = 18,
            y = 12
        },

        -- "-"
        {
            typ = "bricks",
            x = 23,
            y = 9
        },

        -- "|"
        {
            typ = "bricks",
            x = 28,
            y = 6
        },
        {
            typ = "bricks",
            x = 28,
            y = 9
        },
        {
            typ = "bricks",
            x = 28,
            y = 12
        },

        -- E --

        -- "|"

        {
            typ = "bricks",
            x = 35,
            y = 6
        },
        {
            typ = "bricks",
            x = 35,
            y = 9
        },
        {
            typ = "bricks",
            x = 35,
            y = 12
        },

        -- Top long "-"
        {
            typ = "bricks",
            x = 40,
            y = 6
        },

        -- short middle "-"
        {
            typ = "fragile",
            x = 40,
            y = 10
        },
        
        -- Bottom long "-"
        {
            typ = "bricks",
            x = 40,
            y = 12
        },

        -- Bush on top of the E

        {
            typ = "bush",
            x = 35,
            y = 3
        },

        --*-- Great --*--

        -- G --

        -- "|"
        {
            typ = "bricks",
            x = 75,
            y = 6
        },
        {
            typ = "bricks",
            x = 75,
            y = 9
        },
        {
            typ = "bricks",
            x = 75,
            y = 12
        },

        -- Top "-"
        {
            typ = "bricks",
            x = 80,
            y = 6
        },
        {
            typ = "bricks",
            x = 85,
            y = 6
        },

        -- Bottom "-"
        {
            typ = "bricks",
            x = 80,
            y = 12
        },
        {
            typ = "bricks",
            x = 85,
            y = 11
        },

        -- Pool of water in the G
        {
            typ = "water",
            x = 80,
            y = 10
        },

        -- R --

        -- "|"
        {
            typ = "smooth",
            x = 92,
            y = 6
        },
        {
            typ = "smooth",
            x = 92,
            y = 9
        },
        {
            typ = "smooth",
            x = 92,
            y = 12
        },

        -- the top "-"
        {
            typ = "smooth",
            x = 97,
            y = 6
        },
        {
            typ = "smooth",
            x = 100,
            y = 6
        },

        -- the middle "-"
        {
            typ = "fragile",
            x = 97,
            y = 11
        },

        -- the right line closing the hole
        {
            typ = "smooth",
            x = 100,
            y = 9
        },

        -- the little dingaling on the R
        {
            typ = "smooth",
            x = 102,
            y = 12
        },

        -- E --

        -- "|"

        {
            typ = "smooth",
            x = 109,
            y = 6
        },
        {
            typ = "smooth",
            x = 109,
            y = 9
        },
        {
            typ = "smooth",
            x = 109,
            y = 12
        },

        -- Top long "-"
        {
            typ = "smooth",
            x = 114,
            y = 6
        },

        -- short middle "-"
        {
            typ = "fragile",
            x = 114,
            y = 10
        },
        
        -- Bottom long "-"
        {
            typ = "smooth",
            x = 114,
            y = 12
        },

        -- A -- 

        -- bush snuggled in the A
        {
            typ = "bush",
            x = 118,
            y = 9
        },

        -- "|"
        {
            typ = "smooth",
            x = 121,
            y = 6
        },
        {
            typ = "smooth",
            x = 121,
            y = 9
        },
        {
            typ = "smooth",
            x = 121,
            y = 12
        },

        -- the top "-"
        {
            typ = "smooth",
            x = 126,
            y = 6
        },
        {
            typ = "smooth",
            x = 131,
            y = 6
        },

        -- the middle "-"
        {
            typ = "fragile",
            x = 126,
            y = 11
        },

        -- the right line closing the hole
        {
            typ = "smooth",
            x = 131,
            y = 9
        },

        {
            typ = "smooth",
            x = 131,
            y = 12
        },

        -- T --
        -- "-"
        {
            typ = "smooth",
            x = 138,
            y = 6
        },
        {
            typ = "smooth",
            x = 143,
            y = 6
        },
        {
            typ = "smooth",
            x = 148,
            y = 6
        },

        -- "|"
        {
            typ = "smooth",
            x = 143,
            y = 9
        },
        {
            typ = "smooth",
            x = 143,
            y = 12
        },

        --*-- Giana --*--
        
        -- G --

        -- "|"
        {
            typ = "bricks",
            x = 183,
            y = 6
        },
        {
            typ = "bricks",
            x = 183,
            y = 9
        },
        {
            typ = "bricks",
            x = 183,
            y = 12
        },

        -- Top "-"
        {
            typ = "bricks",
            x = 188,
            y = 6
        },
        {
            typ = "bricks",
            x = 193,
            y = 6
        },

        -- Bottom "-"
        {
            typ = "bricks",
            x = 188,
            y = 12
        },
        {
            typ = "bricks",
            x = 193,
            y = 11
        },

        -- Pool of water in the G
        {
            typ = "water",
            x = 188,
            y = 10
        },

        -- I --

        {
            typ = "lid",
            x = 200,
            y = 7
        },
        {
            typ = "screw",
            x = 200,
            y = 9
        },
        {
            typ = "screw",
            x = 200,
            y = 12
        },

        -- A -- 

        -- "|"
        {
            typ = "smooth",
            x = 207,
            y = 6
        },
        {
            typ = "smooth",
            x = 207,
            y = 9
        },
        {
            typ = "smooth",
            x = 207,
            y = 12
        },

        -- the top "-"
        {
            typ = "smooth",
            x = 212,
            y = 6
        },
        {
            typ = "smooth",
            x = 217,
            y = 6
        },

        -- bush on top
        {
            typ = "bush",
            x = 212,
            y = 3
        },

        -- the middle "-"
        {
            typ = "fragile",
            x = 212,
            y = 11
        },

        -- the right line closing the hole
        {
            typ = "smooth",
            x = 217,
            y = 9
        },

        {
            typ = "smooth",
            x = 217,
            y = 12
        },

        -- 2 Ns --

        {
            typ = "N",
            x = 224,
            y = 6
        },

        {
            typ = "N",
            x = 237,
            y = 6
        },

        -- A -- 

        -- "|"
        {
            typ = "smooth",
            x = 250,
            y = 6
        },
        {
            typ = "smooth",
            x = 250,
            y = 9
        },
        {
            typ = "smooth",
            x = 250,
            y = 12
        },

        -- the top "-"
        {
            typ = "smooth",
            x = 255,
            y = 6
        },
        {
            typ = "smooth",
            x = 260,
            y = 6
        },

        -- the middle "-"
        {
            typ = "fragile",
            x = 255,
            y = 11
        },

        -- the right line closing the hole
        {
            typ = "smooth",
            x = 260,
            y = 9
        },

        {
            typ = "smooth",
            x = 260,
            y = 12
        },

        -- fire on top
        {
            typ = "fire",
            x = 255,
            y = 3
        },

        --*-- Sisters --*--

        -- S --
        {
            typ = "S",
            x = 300,
            y = 6
        },

        -- I --
        {
            typ = "lid",
            x = 313,
            y = 7
        },
        {
            typ = "screw",
            x = 313,
            y = 9
        },
        {
            typ = "screw",
            x = 313,
            y = 12
        },

        -- S --

        {
            typ = "S",
            x = 320,
            y = 6
        },

        -- T -- 

        -- "-"
        {
            typ = "smooth",
            x = 335,
            y = 6
        },
        {
            typ = "smooth",
            x = 340,
            y = 6
        },
        {
            typ = "smooth",
            x = 345,
            y = 6
        },

        -- "|"
        {
            typ = "smooth",
            x = 340,
            y = 9
        },
        {
            typ = "smooth",
            x = 340,
            y = 12
        },

        -- The T's bobs

        {
            typ = "gem",
            x = 335,
            y = 9
        },
        {
            typ = "gem",
            x = 345,
            y = 9
        },

        -- E -- 

        -- "|"

        {
            typ = "smooth",
            x = 352,
            y = 6
        },
        {
            typ = "smooth",
            x = 352,
            y = 9
        },
        {
            typ = "smooth",
            x = 352,
            y = 12
        },

        -- Top long "-"
        {
            typ = "smooth",
            x = 357,
            y = 6
        },

        -- short middle "-"
        {
            typ = "fragile",
            x = 357,
            y = 10
        },
        
        -- Bottom long "-"
        {
            typ = "smooth",
            x = 357,
            y = 12
        },

        -- R --

        -- "|"
        {
            typ = "smooth",
            x = 364,
            y = 6
        },
        {
            typ = "smooth",
            x = 364,
            y = 9
        },
        {
            typ = "smooth",
            x = 364,
            y = 12
        },

        -- the top "-"
        {
            typ = "smooth",
            x = 369,
            y = 6
        },
        {
            typ = "smooth",
            x = 374,
            y = 6
        },

        -- the middle "-"
        {
            typ = "fragile",
            x = 369,
            y = 11
        },

        -- the right line closing the hole
        {
            typ = "smooth",
            x = 374,
            y = 9
        },

        -- the little dingaling on the R
        {
            typ = "smooth",
            x = 376,
            y = 12
        },

        -- S --

        {
            typ = "S",
            x = 383,
            y = 6
        }

        --*-- Extra decorations to feel more alive --*--
    }
}

return titlelevel
