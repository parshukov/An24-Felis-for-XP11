size = {241, 446}

defineProperty("bg", loadImage("UPhone.dds", 0, 0, 241, 446))
defineProperty("APPS", loadImage("UPhone.dds", 260, 0, 205, 305))
defineProperty("digitsImage", loadImage("UPhone.dds", 493, 0, 14, 280))
defineProperty("uphone_subpanel", globalPropertyi("sim/custom/xap/An24_panels/uphone_subpanel"))

program = 0

components = {
	texture {
		position = {0, 0, 240, 444},
		image = get(bg),
		visible = true
	},
	
	--menu
	clickable {
		position = {71, 19, 99, 40 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		program = 0
		return true
		end  

	},

	--APPS
	textureLit {
		position = {20, 68, 205, 305},
		image = get(APPS),
		visible = function()
		return program == 0
		end,
	},
	clickable {
		position = {30, 300, 25, 25 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return program == 0
		end,
		onMouseClick = function()
		program = 1
		end  
	},
	UHUD {
		position = { 20, 68, 205, 305 },
		visible = function()
		return program == 1
		end,
	},	

	clickable {
		position = {65, 300, 25, 25 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return program == 0
		end,
		onMouseClick = function()
		program = 2
		end  
	},	

	UConvert {
		position = { 20, 68, 205, 305 },
		visible = function()
		return program == 2
		end,
	}, 
	clickable {
		position = {100, 300, 25, 25 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return program == 0
		end,
		onMouseClick = function()
		program = 3
		end  
	},	

	UTurn {
		position = { 20, 68, 205, 305 },
		visible = function()
		return program == 3
		end,
	}, 
	clickable {
		position = {135, 300, 25, 25 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return program == 0
		end,
		onMouseClick = function()
		program = 4
		end  
	},	
	UMETAR {
		position = { 20, 68, 205, 305 },
		visible = function()
		return program == 4
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
		set(uphone_subpanel, 0 )
		return true
		end
	},
}
