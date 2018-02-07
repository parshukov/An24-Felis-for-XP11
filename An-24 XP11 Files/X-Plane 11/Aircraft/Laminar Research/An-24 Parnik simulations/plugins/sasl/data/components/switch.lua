-- general two-state toggable button

-- image used when button in "ON" state
defineProperty("btnOn")

-- image used when button in "OFF" state
defineProperty("btnOff")

-- function called to get button state
defineProperty("state")


components = {

    -- "on" state texture
    texture {
        image = btnOn,
        visible = function() return get(state); end,
    };
    
    -- "off" state texture
    texture {
        image = btnOff,
        visible = function() return not get(state); end,
    };

    -- clickable area
    clickable {
        cursor = {
            x = 8,
            y = 26,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png"),
        },
    };
}

