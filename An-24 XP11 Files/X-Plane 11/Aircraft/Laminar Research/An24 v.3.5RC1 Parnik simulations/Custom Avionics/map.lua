size = {530, 530}

-- define property table
defineProperty("map_subpanel", globalPropertyi("sim/custom/xap/An24_panels/map_subpanel"))

-- create new search path for maps
addSearchPath("Aircraft/General Aviation/An24_930_Felis/maps")  
addSearchPath("Aircraft/Heavy Metal/An24_930_Felis/maps") 
addSearchPath("Aircraft/General Aviation/An24_930_Felis")  
addSearchPath("Aircraft/Heavy Metal/An24_930_Felis")

-- add map textures
if isFileExists(panelDir.."/maps/map_1.png")==true then
defineProperty("map_1", loadImage(panelDir.."/maps/map_1.png"))
end
if isFileExists(panelDir.."/maps/map_2.png")==true then
defineProperty("map_2", loadImage(panelDir.."/maps/map_2.png"))
end
if isFileExists(panelDir.."/maps/map_3.png")==true then
defineProperty("map_3", loadImage(panelDir.."/maps/map_3.png"))
end
if isFileExists(panelDir.."/maps/map_4.png")==true then
defineProperty("map_4", loadImage(panelDir.."/maps/map_4.png"))
end
if isFileExists(panelDir.."/maps/map_5.png")==true then
defineProperty("map_5", loadImage(panelDir.."/maps/map_5.png"))
end
-- texture table
defineProperty("cover", loadImage("map_cover.dds", 0, 0, 350, 365))
defineProperty("num_1", loadImage("map_cover.dds", 379, 7, 32, 13))    
defineProperty("num_2", loadImage("map_cover.dds", 379, 26, 32, 13))   
defineProperty("num_3", loadImage("map_cover.dds", 379, 46, 32, 13))   
defineProperty("num_4", loadImage("map_cover.dds", 379, 66, 32, 13))   
defineProperty("num_5", loadImage("map_cover.dds", 379, 86, 32, 13))   
defineProperty("size_025", loadImage("map_cover.dds", 379, 107, 32, 13))   
defineProperty("size_05", loadImage("map_cover.dds", 379, 125, 32, 13))    
defineProperty("size_1", loadImage("map_cover.dds", 379, 144, 32, 13))  
defineProperty("size_2", loadImage("map_cover.dds", 379, 164, 32, 13))  
defineProperty("size_4", loadImage("map_cover.dds", 379, 185, 32, 13)) 

--defineProperty("closeImage", loadImage("close.dds"))  -- altimeter handler image

local num = {num_1, num_2, num_3, num_4, num_5}
local map_size = {size_025, size_05, size_1, size_2, size_4}
local size_num = 3

-- calculate map sizes
local w = {1, 1, 1, 1, 1,}
local h = {1, 1, 1, 1, 1,}

local maps = {map_1, map_2, map_3, map_4, map_5}

for i = 1, 5, 1 do  
    if get(maps[i]) then w[i], h[i] = getTextureSize(get(maps[i])) end 
    print ("map", i, "size", w[i], h[i])
end
 

local click_X = 0  -- place where mouse was clicked
local click_Y = 0

local move_X = 0   -- places ower mouse was moved
local move_Y = 0

local drag = false   -- indicator of drag

local winWidth  -- relative to map's size width of window
local winHeight  -- relative to map's size height of window
 
local curent_map = 1   -- counter for switch maps
local scale = 1     -- zoom of map.

local X_scroll = 0   -- variables for scroll the map
local Y_scroll = 0

local X = 0
local Y = 0

function update()

    -- calculate window sizes
    winWidth = (530) / w[curent_map] / scale
    winHeight = (530) / h[curent_map] / scale
    
    -- calculate map movement
    X = move_X - click_X
    Y = move_Y - click_Y
    
    X_scroll = X_scroll - X / 100 * winWidth
    Y_scroll = Y_scroll + Y / 100 * winHeight
    
    click_X = move_X
    click_Y = move_Y
    
    if X_scroll > 1 - winWidth then X_scroll = 1 - winWidth end
    if X_scroll < 0 then X_scroll = 0 end
    
    if Y_scroll > 1 - winHeight then Y_scroll = 1 - winHeight end
    if Y_scroll < 0 then Y_scroll = 0 end 
    
    -- recalculate size num
    if scale == 0.25 then size_num = 1
    elseif scale == 0.5 then size_num = 2
    elseif scale == 1 then size_num = 3
    elseif scale == 2 then size_num = 4
    else size_num = 5 
    end
	
end





-- map table consist of several components
components = {
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {0,0,0,0.5},
	},
	
	

-- show the map
   tape {
      position = {0, 40, 530, 490},
       image = function()
           return get(maps[curent_map])
       end,
       window = function()
          local a = {winWidth, winHeight}
          return a
       end,
       scrollX = function()
           return X_scroll
       end, 
       scrollY = function()
           return Y_scroll
       end,
   
   },

-- cover twxture
   texture {
       position = {-5, -5, 540, 540},
       image = get(cover),
   
   },

-- number of map texture
      texture {
       position = {180, 10, 50, 20},
       image = function()
          return get(num[curent_map])      
       end,
   
   },

-- scale number texture
      texture {
       position = {403, 10, 50, 20},
       image = function()
          return get(map_size[size_num])      
       end,
   },   

-- clickables for change map
       clickable {
       position = { 130, 0, 50, 40 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
              curent_map = curent_map - 1
              if curent_map < 1 then curent_map = 5 end
              scale = 1
        return true
        end
    },   
       clickable {
       position = { 200, 0, 50, 40 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
              curent_map = curent_map + 1
              if curent_map > 5 then curent_map = 1 end
              scale = 1
        return true
        end
    },    

-- clickables for change map's scale
       clickable {
       position = { 365, 0, 50, 40 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
              scale = scale / 2
              if scale < 0.25 then scale = 0.25 end
             -- X_Scroll = X_scroll - winWidth / 2
             -- Y_scroll = Y_scroll - winHeight / 2
        return true
        end
    },   
       clickable {
       position = { 435, 0, 50, 40 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
              scale = scale * 2
              if scale > 4 then scale = 4 end
        return true
        end
    },

-- clickable area for map moving
       clickable {
       position = {0, 40, 530, 490},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  

        onMouseClick = function(comp, x, y)
           if not drag then  
              click_X = x
              click_Y = y
              move_X = x
              move_Y = y
              drag = true
           end
        return true
        end,

        onMouseMove = function(comp, x, y)
           if drag then   
                move_X = x 
                move_Y = y
           end
           return true
        end,
      
        onMouseUp = function()
              drag = false
              click_X = 0
              click_Y = 0
              move_X = 0
              move_Y = 0
            return true
        end,

    },   

   -- clickable area for closing main menu
	textureLit {
		 position = {(size[1] - 16), (size[2] - 16) , 16, 16 },
		 image = get(closeImage),
		 },
    clickable {
       position = { size[1]-20, size[2]-20, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
        set(map_subpanel, 0 )
		return true
        end
    },
	
--[[	rectangle {
		position = {0,0,540,540},
		color = {0.5, 0.5, 0.5, 1},
	},
	--]]
	
}
