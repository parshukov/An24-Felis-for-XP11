size = {898, 296}

local display_brughtness = globalPropertyf("custom/KLN90/display_brughtness")
local rknobsangle = globalPropertyi("custom/KLN90/3D_R_Angle")
local lknobsangle = globalPropertyi("custom/KLN90/3D_L_Angle")
local rknobbangle = globalPropertyi("custom/KLN90/3D_B_R_Angle")
local lknobbangle = globalPropertyi("custom/KLN90/3D_B_L_Angle")
local scan_mode = globalPropertyi("custom/KLN90/scan_mode")

local bg = sasl.gl.loadImage("kln90b_2d.png", 0, 0, 898, 296)
local glass = sasl.gl.loadImage("KLN90.dds", 10, 17, 426, 199)
local powerknob = sasl.gl.loadImage("kln90b_2d.png", 425, 383, 48, 47)
local rknobstex = sasl.gl.loadImage("kln90b_2d.png", 567, 369, 75, 75)
local lknobstex = sasl.gl.loadImage("kln90b_2d.png", 256, 369, 74, 75)
local rknobbtex = sasl.gl.loadImage("kln90b_2d.png", 756, 351, 111, 111)
local lknobbtex = sasl.gl.loadImage("kln90b_2d.png", 30, 351, 111, 111)

components = {

    textureLit {
      position = {250, 60, 399, 230},
      image =     get(display),
      brt2 = 1, --function() return get(display_brughtness) end,
      x = 399,
      y = 230,
    },  

    textureLit2 {
      position = {0,0, 898, 296},
      image = get(bg),
      brt2 = 1,
    },

    
      clickable {
    position = {250, 70, 399, 201},
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_handle.png"),
      hideOSCursor = true
      },
    
    onMouseDown = function()
      KLN90B:setIsVisible(false)
      return false
    end  
      },
    
      
  clickable {
    position = {77, 151, 70, 40 },
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
    
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Toggle_Left_Cursor"))
      
      return false
    end  
   },
      
   clickable {
    position = {751, 151, 70, 40 },
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
    
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Toggle_Right_Cursor"))
      
      return false
    end  
   },
      
   clickable {
    position = {602, 15, 70, 40 },
    
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Press_ENT"))
      
      return false
    end  
   },  
    
   clickable {
    position = {507, 15, 70, 40 },
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
    
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Press_CLR"))
      
      return false
    end  
    },
      
    clickable {
    position = {414, 15, 70, 40 },
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
    
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Toggle_Direct_To_Page"))
      
      return false
    end  
    },
      
    clickable {
    position = {321, 15, 70, 40 },
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
    
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Toggle_Altitude_Page"))
      
      return false
    end  
    },
      
    clickable {
    position = {227, 19, 70, 40 },
    
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },
    
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Toggle_Message_Page"))
      
      return false
    end  
    },
      
    clickable {
      position = {736, 209, 100, 62 },
 
    
      cursor = {
        x =  -31,
        y =  -18,
        width = 62,
        height = 36,
        shape = sasl.gl.loadImage("mc_rot2.png"),
        hideOSCursor = true
        },
        
      onMouseDown = function()
        commandOnce(sasl.findCommand("custom/KLN90/Toggle_Power_Switch"))
        
        return false
      end,
      
      onMouseWheel = function(x,y,w,h,r,t,clicks)
        if clicks > 0 then commandOnce(sasl.findCommand("custom/KLN90/Increase_Brightness"))
        elseif clicks < 0 then commandOnce(sasl.findCommand("custom/KLN90/Decrease_Brightness"))
        end
        
        return false
      end,
    },
      
    clickable {
    position = {754, 14, 60, 120 },
    
    cursor = {
      x =  -31,
      y =  -14.5,
      width = 62,
      height = 29,
      shape = sasl.gl.loadImage("mc_rot1.png"),
      hideOSCursor = true
      },
    
    onMouseWheel = function(x,y,w,h,r,t,clicks)
      if clicks > 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Right_Small_Knob_Clockwise"))
      elseif clicks < 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Right_Small_Knob_Counterclockwise"))
      end
      
      return false
    end  
    },
      
    clickable {
    position = {84, 14, 60, 120},
    
    cursor = {
      x =  -31,
      y =  -14.5,
      width = 62,
      height = 29,
      shape = sasl.gl.loadImage("mc_rot1.png"),
      hideOSCursor = true
      },
    
    onMouseWheel = function(x,y,w,h,r,t,clicks)
      if clicks > 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Left_Small_Knob_Clockwise"))
      elseif clicks < 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Left_Small_Knob_Counterclockwise"))
      end
      
      return false
    end  
    },
      
    clickable {
    position = {145, 14, 70, 120},
    
    cursor = {
      x =  -16,
      y =  -23.5,
      width = 32,
      height = 47,
      shape = sasl.gl.loadImage("mc_rot3_rgt.png"),
      hideOSCursor = true
      },
    
    onMouseWheel = function(x,y,w,h,r,t,clicks)
      if clicks > 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Left_Large_Knob_Clockwise"))
      elseif clicks < 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Left_Large_Knob_Counterclockwise"))
      end  
      return false
    end,
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Turn_Left_Large_Knob_Clockwise"))
      
      return false
    end        
    },
   
    clickable {
    position = {14, 14, 70, 120 },
    
    cursor = {
      x =  -16,
      y =  -23.5,
      width = 32,
      height = 47,
      shape = sasl.gl.loadImage("mc_rot3_lft.png"),
      hideOSCursor = true
      },
    
    onMouseWheel = function(x,y,w,h,r,t,clicks)
      if clicks > 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Left_Large_Knob_Clockwise"))
      elseif clicks < 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Left_Large_Knob_Counterclockwise"))
      end
     
      return false
    end,
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Turn_Left_Large_Knob_Counterclockwise"))
      
      return false
    end         
    },
      
    clickable {
    position = {685, 14, 70, 120 },
    
    cursor = {
      x =  -16,
      y =  -23.5,
      width = 32,
      height = 47,
      shape = sasl.gl.loadImage("mc_rot3_lft.png"),
      hideOSCursor = true
      },
    
    onMouseWheel = function(x,y,w,h,r,t,clicks)
      if clicks > 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Right_Large_Knob_Clockwise"))
      elseif clicks < 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Right_Large_Knob_Counterclockwise"))
      end
      
      return false
    end,
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Turn_Right_Large_Knob_Counterclockwise"))
      
      return false
    end    
    },
    
    clickable {
    position = {814, 14, 70, 120},
    
    cursor = {
      x =  -16,
      y =  -23.5,
      width = 32,
      height = 47,
      shape = sasl.gl.loadImage("mc_rot3_rgt.png"),
      hideOSCursor = true
      },
    
    onMouseWheel = function(x,y,w,h,r,t,clicks)
      if clicks > 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Right_Large_Knob_Clockwise"))
      elseif clicks < 0 then commandOnce(sasl.findCommand("custom/KLN90/Turn_Right_Large_Knob_Counterclockwise"))
      end
      
      return false
    end,
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Turn_Right_Large_Knob_Clockwise"))
      
      return false
    end         
    },
    
      
    clickable {
    position = {755, 43, 60, 60},
    
    onMouseDown = function()
      commandOnce(sasl.findCommand("custom/KLN90/Toggle_Scan_Mode"))
      
      return false
    end  
    },
  
    
    textureRotate {
  
      position = {762, 217, 48, 47},
      image = get(powerknob),
      angle = function()
                  return get(display_brughtness)*270
                end,
      brt2 = 1,
    },
    
    textureRotate {
  
      position = {58, 18, 111, 111},
      image = get(lknobbtex),
      angle = function()
                  return get(lknobbangle)*24
                end,
      brt2 = 1,
    },
    
    textureRotate {
  
      position = {729, 18, 111, 111},
      image = get(rknobbtex),
      angle = function()
                  return get(rknobbangle)*24
                end,
     brt2 = 1,
    },  
    
    textureRotate {
  
     -- position = {763, 36, 77, 77},
      position = function() 
        if get(scan_mode) == 1 then return {734, 26, 100, 100}
         else return {747, 35, 75, 75}
         end
      end,
      image = get(rknobstex),
      angle = function()
                  return get(rknobsangle)*24
                end,
      brt2 = 1,
    },
    
    textureRotate {
  
      position = {76, 35, 74, 75},
      image = get(lknobstex),
      angle = function()
                  return get(lknobsangle)*24
                end,
      brt2 = 1,
    },    
    
}


function draw()

 --   sasl.gl.drawTexture(display, 250, 60, 399, 230)
 --   sasl.gl.drawTexture(bg, 0,0, 898, 296)
    drawAll(components)
end