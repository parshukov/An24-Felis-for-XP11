size = {64, 64}

addSearchPath(sasl.getXPlanePath ().."/Resources/bitmaps/interface")
local bg = sasl.gl.loadImage("KLNpopup.dds", 0, 0, 64, 64)


--defineProperty("KLN90popupvisible", globalPropertyi("sim/custom/xap/KLN90pop/visible"))
--defineProperty("MD41visible", globalPropertyi("sim/custom/xap/MD41/visible"))
--defineProperty("KLN90visible", globalPropertyi("sim/custom/xap/KLN90/visible"))



components = {

texture {
position = {0, 0, size[1], size[2]},
image = get(bg),
	},


		clickable {
	position = {0, 28, 64, 26 },
	
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },

       	onMouseDown = function() 
		   KLN90B:setIsVisible(not KLN90B:isVisible ())
			return false
		end,
	},	
clickable {
	position = {0, 0, 64, 26 },
	
    cursor = {
      x =  -15.5,
      y =  -16.5,
      width = 31,
      height = 33,
      shape = sasl.gl.loadImage("mc_button.png"),
      hideOSCursor = true
      },

       	onMouseDown = function() 
      MD41:setIsVisible(not MD41:isVisible ())
			return false
		end,
	}
}