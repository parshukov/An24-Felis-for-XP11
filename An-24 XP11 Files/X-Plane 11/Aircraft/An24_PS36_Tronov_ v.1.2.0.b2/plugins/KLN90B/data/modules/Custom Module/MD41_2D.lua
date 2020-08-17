size = {822, 304}

-- addSearchPath(sasl.getXPlanePath ().."/Resources/bitmaps/interface")
-- addSearchPath(sasl.getXPlanePath ().."/Resources/bitmaps/interface11")
local MD41test = globalPropertyi("custom/MD41/test")
local test = globalPropertyi("sim/cockpit/warnings/annunciator_test_pressed")
local OBS = globalPropertyi("custom/KLN90/OBS")
local APR = globalPropertyi("custom/KLN90/APR")
local MSG = globalPropertyi("custom/KLN90/MSG")
local WPT = globalPropertyi("custom/KLN90/WPT")
local HSIsource = globalPropertyi("sim/cockpit2/radios/actuators/HSI_source_select_pilot")


local bg = sasl.gl.loadImage("MD41.png", 0, 0, 822, 304)
local navlt = sasl.gl.loadImage("MD41.png", 185, 445, 53, 22)
local gpslt = sasl.gl.loadImage("MD41.png", 185, 393, 53, 22)
local armlt = sasl.gl.loadImage("MD41.png", 304, 445, 70, 22)
local actvlt = sasl.gl.loadImage("MD41.png", 304, 393, 70, 22)
local obslt = sasl.gl.loadImage("MD41.png", 442, 444, 53, 22)
local leglt = sasl.gl.loadImage("MD41.png", 442, 393, 53, 22)
local wptlt = sasl.gl.loadImage("MD41.png", 569, 393, 58, 23)
local msglt = sasl.gl.loadImage("MD41.png", 569, 445, 58, 23)



components = {

    textureLit2 {
      position = {0, 0, 822, 304},
      image = get(bg),
      brt2 = 1,
    },

    clickable {
    position = {139, 174, 535, 94 },

    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_handle.png"),
      hideOSCursor = true
      },
   
    onMouseDown = function()
      MD41:setIsVisible(false)
      return false
    end  

      },

    
    clickable {
    position = {700, 129, 50, 50 },

    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
   
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/MD_41_Test_Lamps")) --not working... WTF?

     
      return false
    end,

      },
      
     clickable {
    position = {153, 38, 90, 90  },
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
    
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/MD_41_Toggle_NAV-GPS"))
      
      return false
    end  
      },
      
      clickable {
    position = {292, 38, 90, 90  },
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
    
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/MD_41_Toggle_Approach"))
      
      return false
    end  
      },
      
      clickable {
    position = {432, 38, 90, 90 },
    
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/MD_41_Toggle_OBS-LEG"))
      
      return false
    end  
      },  
    
    
     textureLit2 {
  
      position = {173, 240, 53, 22},
      image = get(navlt),
       brt2 = 1,
      visible = function()
      if get(HSIsource) == 0 or get(MD41test) == 1 or get(test) == 1 then return true end
      return false end
    },
 
       textureLit2 {
  
      position = {173, 184, 53, 22},
      image = get(gpslt),
       brt2 = 1,
      visible = function()
      if get(HSIsource) == 2 or get(MD41test) == 1 or get(test) == 1 then return true end
      return false end
    },
    
      textureLit2 {
  
      position = {303, 240, 70, 22},
      image = get(armlt),
       brt2 = 1,
      visible = function()
      if get(APR) == 1 or get(MD41test) == 1 or get(test) == 1 then return true end
      return false end
    },
 
       textureLit2 {
  
      position = {303, 184, 70, 22},
      image = get(actvlt),
       brt2 = 1,
      visible = function()
      if get(APR) == 2 or get(MD41test) == 1 or get(test) == 1 then return true end
      return false end     
    },  
    
      textureLit2 {
  
      position = {448, 240, 53, 22},
      image = get(obslt),
       brt2 = 1,
      visible = function()
      if get(OBS) == 2 or get(MD41test) == 1 or get(test) == 1 then return true end
      return false end
    },
 
       textureLit2 {
  
      position = {448, 184, 53, 22},
      image = get(leglt),
       brt2 = 1,
      visible = function()
      if get(OBS) == 1 or get(MD41test) == 1 or get(test) == 1 then return true end
      return false end
    },  

      textureLit2 {
  
      position = {584, 240, 58, 23},
      image = get(msglt),
       brt2 = 1,
      visible = function()
      if get(MSG) == 1 or get(MD41test) == 1 or get(test) == 1 then return true end
      return false end  
    },
 
       textureLit2 {
  
      position = {584, 184, 58, 23},
      image = get(wptlt),
       brt2 = 1,
      visible = function()
      if get(WPT) == 1 or get(MD41test) == 1 or get(test) == 1 then return true end
      return false end  
    },  

}


function draw()
  --  sasl.gl.drawTexture(bg, 0, 0, 822, 304)
    drawAll(components)

end