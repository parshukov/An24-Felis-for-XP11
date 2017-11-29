
-- button is clickable area with texture

-- no image
defineProperty("image")

-- function
defineProperty("action")

components = {
    
    -- background image
    texture { image = image };

    -- clickable area
    clickable {
        cursor = { 
            x = 8, 
            y = 26, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },
    };
}

