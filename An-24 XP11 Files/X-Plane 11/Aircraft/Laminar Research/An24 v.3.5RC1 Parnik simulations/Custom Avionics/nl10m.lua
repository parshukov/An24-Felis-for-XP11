size = {1280, 330}

-- define property table
defineProperty("nl10m_subpanel", globalPropertyi("sim/custom/xap/An24_panels/nl10m_subpanel"))

-- add map textures
defineProperty("ruler1", loadImage("nl10m.dds", 0, 0, 2048, 300))
defineProperty("ruler2", loadImage("nl10m.dds", 0, 296, 2048, 300))

defineProperty("slider1", loadImage("nl10m.dds", 0, 638, 2048, 145))
defineProperty("slider2", loadImage("nl10m.dds", 0, 806, 2048, 145))

--defineProperty("visir_img", loadImage("fuel_panel_2d.dds", 502, 723, 10, 300))
defineProperty("change_side_img", loadImage("fuel_panel_2d.dds", 0, 1000, 132, 23))

-- vars for textures
local side = 0
local background_img = get(ruler1)
local bar_img = get(slider1)
-- movement
local click_X_bkg = 0  -- place where mouse was clicked
local move_X_bkg = 0   -- places ower mouse was moved
local drag_bkg = false   -- indicator of drag
local X_scroll_bkg = 0   -- variables for scroll the map
local X_bkg = 0

local click_X_slider = 0  -- place where mouse was clicked
local move_X_slider = 0   -- places ower mouse was moved
local X_scroll_slider = 0.001   -- variables for scroll the map
local X_slider = 0
local drag_slider = false

local click_X_vis = 0  -- place where mouse was clicked
local move_X_vis = 0   -- places ower mouse was moved
local X_scroll_vis = 0   -- variables for scroll the map
local X_vis = 0
local drag_vis = false

local winWidth = size[1] / 2048  -- relative to map's size width of window

local MAX = 1 - winWidth
local MAX2 = 1.55 - winWidth
local MIN = 0
local MIN2 = -0.55

local last_bkg = 0
local last_slider = 0

function update()

    -- calculate background movement
    X_bkg = move_X_bkg - click_X_bkg
    X_scroll_bkg = X_scroll_bkg - X_bkg / 100 * winWidth
    click_X_bkg = move_X_bkg

    if X_scroll_bkg > MAX then X_scroll_bkg = MAX end
    if X_scroll_bkg < MIN then X_scroll_bkg = MIN end

    -- calculate slider movement
	X_slider = move_X_slider - click_X_slider
	X_scroll_slider = X_scroll_slider - X_slider / 100 * winWidth
    -- stop slider move, if background moved and it stops at the end
	if X_scroll_bkg == MAX and drag_bkg then X_scroll_slider = last_slider + MAX - last_bkg
	elseif X_scroll_bkg == MIN and drag_bkg then X_scroll_slider = last_slider - last_bkg end
	
	click_X_slider = move_X_slider
	
    if X_scroll_slider > MAX2 then X_scroll_slider = MAX2 end
    if X_scroll_slider < MIN2 then X_scroll_slider = MIN2 end
	
    -- calculate visir movement
    X_vis = move_X_vis - click_X_vis
    X_scroll_vis = X_scroll_vis + X_vis * size[1] / 35
    click_X_vis = move_X_vis
	
	X_scroll_vis = click_X_vis * size[1] / 100 - 50 -- test
	
    if X_scroll_vis > size[1]-100 then X_scroll_vis = size[1]-100 end
    if X_scroll_vis < 0 then X_scroll_vis = 0 end
	
	-- define side texture
	if side == 0 then 
		background_img = get(ruler1)
		bar_img = get(slider1)
	else
		background_img = get(ruler2)
		bar_img = get(slider2)
	end

	last_bkg = X_scroll_bkg
	last_slider = X_scroll_slider
	
end





-- map table consist of several components
components = {
	-- background
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {0,0,0,0.5},
	},
	texture {
		position = {30, 305, 132, 23},
		image = get(change_side_img),
	},
	
	
-- show the background
   tape {
      position = {0, 0, size[1], 300},
       image = function()
           return background_img
       end,
       window = function()
          local a = {winWidth, 1}
          return a
       end,
       scrollX = function()
           return X_scroll_bkg
       end, 
   },


-- show the scale bar
   tape {
      position = {0, 87, size[1], 145},
       image = function()
           return bar_img
       end,
       window = function()
          local a = {winWidth, 1}
          return a
       end,
       scrollX = function()
           return X_scroll_slider
       end, 
	   --visible = side == 0
   },
   
   -- clickables for change side
       clickable {
       position = {30, 305, 132, 23},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			side = math.abs(side - 1)
        return true
        end
    },   
    


-- clickable area for background moving
       clickable {
       position = {10, 0, size[1]-20, 86},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  

        onMouseClick = function(comp, x, y)
           if not drag_bkg then  
              click_X_bkg = x
              move_X_bkg = x
			  click_X_slider = x
              move_X_slider = x
              drag_bkg = true
           end
        return true
        end,

        onMouseMove = function(comp, x, y)
           if drag_bkg then   
                move_X_bkg = x 
				move_X_slider = x 
           end
           return true
        end,
      
        onMouseUp = function()
              drag_bkg = false
              click_X_bkg = 0
              move_X_bkg = 0
              click_X_slider = 0
              move_X_slider = 0
            return true
        end,

    },   
	
-- clickable area for scale bar moving
       clickable {
       position = {10, 86, size[1]-20, 145},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  

        onMouseClick = function(comp, x, y)
           if not drag_slider then  
              click_X_slider = x
              move_X_slider = x
              drag_slider = true
           end
        return true
        end,

        onMouseMove = function(comp, x, y)
           if drag_slider then   
                move_X_slider = x 
           end
           return true
        end,
      
        onMouseUp = function()
              drag_slider = false
              click_X_slider = 0
              move_X_slider = 0
            return true
        end,
    }, 
	
-- visir image
	rectangle_ctr {
		R = 0.5, G = 0.5, B = 0.3, A = 0.4,
		position_x = function()
			return X_scroll_vis
		end,
		position_y = 0,
		width = 100,
		height = 300,	
	},
	rectangle_ctr {
		R = 0, G = 0, B = 0, A = 0.6,
		position_x = function()
			return X_scroll_vis + 49
		end,
		position_y = 0,
		width = 2,
		height = 300,	
	},
	
--[[	
	free_texture {
		image = get(visir_img),
		position_x = function()
			return X_scroll_vis + 49
		end,
		position_y = 0,
		width = 10,
		height = 310,	
	
	
	},
--]]
-- clickable area for visir moving
       clickable {
       position = {0, 231, size[1], 70},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  

        onMouseClick = function(comp, x, y)
           --if not drag_slider then  
              click_X_vis = x
              move_X_vis = x
              --drag_vis = true
           --end
        return true
        end,

    }, 	
   -- clickable area for closing main menu
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
        set(nl10m_subpanel, 0 )
        return true
        end
    },		
	
}
