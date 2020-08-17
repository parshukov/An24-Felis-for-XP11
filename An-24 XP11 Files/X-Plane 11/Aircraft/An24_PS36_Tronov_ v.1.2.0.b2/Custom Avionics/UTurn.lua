size = {205, 305}

defineProperty("bg", loadImage("UTurn.dds", 0, 0, 205, 305))
--defineProperty("selection", loadImage("UConvert.dds", 5, 315, 48, 20))
defineProperty("digitsImage", loadImage("UPhone.dds", 473, 0, 14, 280))

local course1 = 0
local course2 = 0
local bank = 15
local TAS = 400
local start = 0
local nas_c = 0
local nas_b = 0
local diff = 0

function update()
--limits
if course1 > 360 then
course1 = course1 - 360
elseif course1 < 0 then
course1 = course1 + 360
end
if course2 > 360 then
course2 = course2 - 360
elseif course2 < 0 then
course2 = course2 + 360
end
if bank > 45 then
bank = 45
elseif bank < 5 then
bank = 5
end
if TAS > 999 then
TAS = 999
elseif TAS < 100 then
TAS = 100
end
--calculations
diff = course1 - course2
if diff > 180 then
diff = diff - 360
elseif diff  < -180 then
diff = diff + 360
end
if diff == 180 or diff == -180 then
start = 0
nas_c = 0
nas_b = 0
else
start = ( (TAS / 3.6) ^ 2 / ( 9.81 * math.tan (bank * math.pi / 180) ) ) * math.tan ( math.abs(diff) * math.pi / 180 / 2) 
nas_c = -start * math.cos (math.abs(diff) * math.pi / 180)
nas_b = start * math.sin(-diff * math.pi / 180)
end
end

components = {
	textureLit {
		position = {0, 0, 205, 305},
		image = get(bg),
		visible = true
	},
	-- course1	
	clickable {
		position = {87, 254, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		onMouseClick = function()
		course1 = course1 - 10
		return true
		end   
	},
	clickable {
		position = {112, 254, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		onMouseClick = function()
		course1 = course1 - 1
		return true
		end   
	},
	

	digitstapeLit {
		position = { 113, 256, 32, 16},
		image = digitsImage;
		digits = 3;
		allowNonRound = true;
		showLeadingZeros = false;
		--		fractional = 1;
		value = function()
		return course1
		end;
	},
	clickable {
		position = {134, 254, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		onMouseClick = function()
		course1 = course1 + 1
		return true
		end   
	},
	clickable {
		position = {159, 254, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		onMouseClick = function()
		course1 = course1 + 10
		return true
		end   
	},
	-- course2
	clickable {
		position = {87, 224, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		onMouseClick = function()
		course2 = course2 - 10
		return true
		end   
	},
	clickable {
		position = {112, 224, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		onMouseClick = function()
		course2 = course2 - 1
		return true
		end   
	},
	

	digitstapeLit {
		position = { 113, 226, 32, 16},
		image = digitsImage;
		digits = 3;
		allowNonRound = true;
		showLeadingZeros = false;
		--		fractional = 1;
		value = function()
		return course2
		end;
	},
	clickable {
		position = {134, 224, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		onMouseClick = function()
		course2 = course2 + 1
		return true
		end   
	},
	clickable {
		position = {159, 224, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		onMouseClick = function()
		course2 = course2 + 10
		return true
		end   
	},
	-- bank
	clickable {
		position = {87, 194, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		onMouseClick = function()
		bank = bank - 5
		return true
		end   
	},
	clickable {
		position = {112, 194, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		onMouseClick = function()
		bank = bank - 1
		return true
		end   
	},
	

	digitstapeLit {
		position = { 113, 196, 32, 16},
		image = digitsImage;
		digits = 3;
		allowNonRound = true;
		showLeadingZeros = false;
		--		fractional = 1;
		value = function()
		return bank

		end;
	},
	clickable {
		position = {134, 194, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		onMouseClick = function()
		bank = bank + 1
		return true
		end   
	},
	clickable {
		position = {159, 194, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		onMouseClick = function()
		bank = bank + 5
		return true
		end   
	},	
	-- TAS
	clickable {
		position = {87, 164, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		onMouseClick = function()
		TAS = TAS - 10
		return true
		end   
	},
	clickable {
		position = {112, 164, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		onMouseClick = function()
		TAS = TAS - 1
		return true
		end   
	},
	

	digitstapeLit {
		position = { 113, 166, 32, 16},
		image = digitsImage;
		digits = 3;
		allowNonRound = true;
		showLeadingZeros = false;
		value = function()
		return TAS
		end;
	},
	clickable {
		position = {134, 164, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		onMouseClick = function()
		TAS = TAS + 1
		return true
		end   
	},
	clickable {
		position = {159, 164, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		onMouseClick = function()
		TAS = TAS + 10
		return true
		end   
	},	
	--calculated
	digitstapeLit {
		position = { 113, 106, 53, 16},
		image = digitsImage;
		digits = 5;
		allowNonRound = true;
		showLeadingZeros = false;
		--		fractional = 1;
		value = function()
		return start
		end;
	},
	digitstapeLit {
		position = { 103, 76, 64, 16},
		image = digitsImage;
		digits = 6;
		allowNonRound = true;
		showLeadingZeros = false;
		showSign = true;
		--		fractional = 1;
		value = function()
		return nas_c
		end;
	},
	digitstapeLit {
		position = { 103, 46, 64, 16},
		image = digitsImage;
		digits = 6;
		allowNonRound = true;
		showLeadingZeros = false;
		showSign = true;
		--		fractional = 1;
		value = function()
		return nas_b
		end;
	},
}
