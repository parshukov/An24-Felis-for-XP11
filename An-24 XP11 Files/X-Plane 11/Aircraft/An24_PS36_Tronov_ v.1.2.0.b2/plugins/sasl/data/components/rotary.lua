
-- no image
defineProperty("image")

-- default value
defineProperty("value", 0)

-- default step
defineProperty("step", 1)

defineProperty('autoRepeat', true)

-- function for adjusting value to near suitable
--defineProperty("adjuster")

--adjuster = function (v) return v ; end

function updateValue(newValue)
    local a = rawget(_C, 'adjuster')
    if a then
        newValue = a(newValue)
    end
    set(value, newValue)
end


-- rotary consists of texture and two clickable areas
components = {
    
    -- background image
    texture { image = image },

    clickable {
        position = { 0, 0, 50, 100 },
        
        cursor = { 
            x = 10, 
            y = 28, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },

        onMouseDown = function(x, y, button)
            if not get(autoRepeat) then
                updateValue(get(value) - get(step))
                return true
            else
                return false
            end
        end,

        onMouseClick = function(x, y, button)
            if get(autoRepeat) then
                updateValue(get(value) - get(step))
                return true
            else
                return false
            end
        end,
    },
    
    clickable {
        position = { 50, 0, 50, 100 },
        
        cursor = { 
            x = 10, 
            y = 28, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },
        
        onMouseDown = function(x, y, button) 
            if not get(autoRepeat) then
                updateValue(get(value) + get(step))
                return true
            else
                return false
            end
        end,

        onMouseClick = function(x, y, button) 
            if get(autoRepeat) then
                updateValue(get(value) + get(step))
                return true
            else
                return false
            end
        end,
    },
    
}

