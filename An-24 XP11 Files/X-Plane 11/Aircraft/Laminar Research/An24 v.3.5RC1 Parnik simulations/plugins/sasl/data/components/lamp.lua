-- general two-state indicator

-- image used when button in "ON" state
defineProperty("lightOn")

-- image used when button in "OFF" state
defineProperty("lightOff")

-- function called to get button state
defineProperty("state")


components = {

    -- "on" state texture
    textureLit {
        image = lightOn,
        visible = function() return toboolean(get(state)); end;
    };
    
    -- "off" state texture
    textureLit {
        image = lightOff,
        visible = function() return not toboolean(get(state)); end,
    };

}


