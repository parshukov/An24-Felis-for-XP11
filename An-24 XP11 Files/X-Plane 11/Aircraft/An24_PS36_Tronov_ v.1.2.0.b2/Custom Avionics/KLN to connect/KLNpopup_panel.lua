size = {64, 64}


defineProperty("bg", loadImage("KLNpopup.png", 0, 0, 64, 64))


defineProperty("KLN90popupvisible", globalPropertyi("sim/custom/xap/KLN90pop/visible"))
defineProperty("MD41visible", globalPropertyi("sim/custom/xap/MD41/visible"))
defineProperty("KLN90visible", globalPropertyi("sim/custom/xap/KLN90/visible"))



components = {

texture {
position = {0, 0, size[1], size[2]},
image = get(bg),
	},


		clickable {
	position = {0, 28, 64, 26 },
	
	cursor = { 
	x = 16, 
	y = 32,  
	width = 16, 
	height = 16, 
	shape = loadImage("clickable.png")
},  

       	onMouseClick = function() 
		if get(KLN90visible) == 1 then
			set(KLN90visible, 0)
			else
			set(KLN90visible, 1)
		end
			return true
		end,
	},	
clickable {
	position = {0, 0, 64, 26 },
	
	cursor = { 
	x = 16, 
	y = 32,  
	width = 16, 
	height = 16, 
	shape = loadImage("clickable.png")
},  

       	onMouseClick = function() 
		if get(MD41visible) == 1 then
			set(MD41visible, 0)
			else
			set(MD41visible, 1)
		end
			return true
		end,
	},		
	
	-- clickable area for closing main menu
	clickable {
	position = { size[1]-10, size[2]-10, 10, 10 },
	
	cursor = { 
	x = 16, 
	y = 32,  
	width = 16, 
	height = 16, 
	shape = loadImage("clickable.png")
},  

onMouseClick = function()
	set(KLN90popupvisible, 0 )
	return true
end
	},	
}
