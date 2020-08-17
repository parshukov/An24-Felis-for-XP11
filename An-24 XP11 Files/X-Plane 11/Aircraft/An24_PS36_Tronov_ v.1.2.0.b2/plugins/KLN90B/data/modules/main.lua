--main.lua
size = {210, 110}

draw3d = true

addSearchPath(sasl.getXPlanePath ().."/Resources/bitmaps/interface")
addSearchPath(sasl.getXPlanePath ().."/Resources/bitmaps/interface11")


if draw3d == true then
display  = sasl.gl.createTexture(size[1], size[2])
else
display = sasl.gl.createRenderTarget(size[1], size[2])
end

local popout_img = sasl.gl.loadImage("floating_window@1.5x.png", 27, 0, 28, 28)
local close_img = sasl.gl.loadImage("floating_window@1.5x.png", 0, 28, 26, 26)
local hide_ui_kln = true
local hide_ui_md = true

components = {
   KLN90_panel {
         position = { 1280, 5, size[1], size[2]}
   },
}


KLN90B = contextWindow {
    name      = "KLN90B",
    position    = {50, 50, 898, 296},
    minimumSize = {898/2, 296/2},
    maximumSize = {898*2, 296*2},
    noDecore = false,
	customDecore = true,
    resizeMode = SASL_CW_RESIZE_RIGHT_BOTTOM, 
	proportional = true,
    visible     = false,
	savePosition = true,  
	saveState = true,
        components = {
            KLN90_2D {
                position    = {0, 0, 898, 296}
            }
          },
	decoration = {
		headerHeight = 0 ,
			
			 main = {
				draw = function(w, h)-- draw  window  header...
					if hide_ui_kln == false then
					sasl.gl.drawTexture(popout_img, w-20, h-20, 20, 20)
					sasl.gl.drawTexture(close_img, 0, h-20, 20, 20)
					end
				end, 
				
				onMouseMove = function(x, y, w, h)
					if y > h - 20 and y < h and KLN90B:isPoppedOut() == false then
						hide_ui_kln = false
					else
						hide_ui_kln = true
					end
					
				end ,
				
				onMouseDown = function(x, y, w, h, button)
					if  KLN90B:isPoppedOut() == false and button == MB_LEFT then
						if y > h - 20 then
							if x > w - 20 then
								KLN90B:setMode(SASL_CW_MODE_POPOUT)
							elseif x < 20 then
								KLN90B:setIsVisible(false)
							end
						end	
						
						
					end

				end ,				
				
			}
	}	
}

MD41 = contextWindow {
    name      = "MD41",
    position    = {500, 505, 411, 152},
    savePosition = true,
    noDecore = true,
    minimumSize = {411/2, 152/2},
    maximumSize = {411*2, 152*2},
    noDecore = false,
	customDecore = true,
    resizeMode = SASL_CW_RESIZE_RIGHT_BOTTOM, 
	proportional = true,
    visible     = false,
	saveState = true,
        components = {
            MD41_2D {
                position    = {0, 0, 411, 152}
            }
          },
	decoration = {
		headerHeight = 0 ,
			
			 main = {
				draw = function(w, h)-- draw  window  header...
					if hide_ui_md == false then
					sasl.gl.drawTexture(popout_img, w-20, h-20, 20, 20)
					sasl.gl.drawTexture(close_img, 0, h-20, 20, 20)
					end
				end, 
				
				onMouseMove = function(x, y, w, h)
					if y > h - 20 and y < h and MD41:isPoppedOut() == false then
						hide_ui_md = false
					else
						hide_ui_md = true
					end
					
				end ,
				
				onMouseDown = function(x, y, w, h, button)
					if  MD41:isPoppedOut() == false and button == MB_LEFT then
						if y > h - 20 then
							if x > w - 20 then
								MD41:setMode(SASL_CW_MODE_POPOUT)
							elseif x < 20 then
								MD41:setIsVisible(false)
							end
						end					
					end

				end ,				
				
			}
	}	
}

KLNPanel = contextWindow {
  name = "KLN popup panel",
  position = { 0, 150, 64, 64 },
  savePosition = true,
  noBackground = true,
  noDecore = true,
  layer = SASL_CW_LAYER_FLIGHT_OVERLAY,
  noClose = true,
  noMove = false,
  visible = false,
  noResize = true,
  components = {
    KLNpopup_panel {
      position = { 0 , 0 , 64, 64 },
    }
  }
}

KLNc_command = sasl.createCommand("custom/KLN90/Toggle_KLN_90B_Panel", "KLN90visible")
function KLNc_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
  if 0 == phase then
    if KLN90B:isVisible () then
      KLN90B:setIsVisible(false)
    else
      KLN90B:setIsVisible(true)
    end
  end
  return false
end
sasl.registerCommandHandler(KLNc_command, 0, KLNc_handler)

MD41c_command = sasl.createCommand("custom/KLN90/Toggle_MD41_Panel", "MD41visible")
function MD41c_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
  if 0 == phase then
    if MD41:isVisible () then
      MD41:setIsVisible(false)
    else
      MD41:setIsVisible(true)
    end
  end
  return 0
end
sasl.registerCommandHandler(MD41c_command, 0, MD41c_handler)


menu_master = sasl.appendMenuItem (PLUGINS_MENU_ID, "KLN90B/MD41" )
menu_main = sasl.createMenu ("", PLUGINS_MENU_ID, menu_master)
menu_option = sasl.appendMenuItem(menu_main, "Toggle KLN90B Window", function() 
                                                                        KLN90B:setIsVisible(not KLN90B:isVisible ())
                                                                        return false
                                                                        end)
menu_option = sasl.appendMenuItem(menu_main, "Toggle MD41 Window", function() 
                                                                        MD41:setIsVisible(not MD41:isVisible ())
                                                                        return false
                                                                        end)
menu_option = sasl.appendMenuItem(menu_main, "Toggle KLN popup panel", function() 
                                                                        KLNPanel:setIsVisible(not KLNPanel:isVisible ())
                                                                        return false
                                                                        end)																	
