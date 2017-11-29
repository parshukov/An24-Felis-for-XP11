size = {205, 305}

defineProperty("bg", loadImage("UMETAR.dds", 0, 0, 205, 305))

local font = loadFont('UPhone.fnt')

local METAR1 = ""
local METAR2 = ""
local METAR3 = ""
local METAR4 = ""
local METAR5 = ""
local METAR6 = ""


local name = 0
local input = ""

function readmetar()
local filename = "METAR.rwx"
local file = io.open(filename, "r")
-- if file exist - read it and fill the variables with new values
if file then
METAR1 =  input
METAR2 =  "NOT FOUND"
METAR3 = ""
METAR4 = ""
METAR5 = ""
METAR6 = ""
while true do
	local line = file:read("*line")
	if line == nil then break end
	name = string.sub(line, 1, 4)
	if name == input then
METAR1 =  string.sub(line, 1, 20)
METAR2 =  string.sub(line, 21, 40)
METAR3 =  string.sub(line, 41, 60)
METAR4 =  string.sub(line, 61, 80)
METAR5 =  string.sub(line, 81, 100)
METAR6 =  string.sub(line, 101, 120)
end
end
file:close()
else print ("METAR.rwx couldn't be read")
METAR1 = "METAR.RWX NOT FOUND"
METAR2 = "ENABLE REAL WEATHER"
METAR3 = "DOWNLOAD"
METAR4 = ""
METAR5 = ""
METAR6 = ""
end
input =""
end

local notLoaded = false


function update()
input = string.sub(input, 1, 4)

if notLoaded then
	readmetar()
notLoaded = false

end
end


	
components = {
	textureLit {
		position = {0, 0, 205, 305},
		image = get(bg),
		visible = true
	},
	clickable {
		position = {3, 64, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "Q")
		return true
		end 
	},	
	clickable {
		position = {23, 64, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "W")
		return true
		end 
	},	
	clickable {
		position = {43, 64, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "E")
		return true
		end 
	},	
	clickable {
		position = {63, 64, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "R")
		return true
		end 
	},
	clickable {
		position = {83, 64, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "T")
		return true
		end 
	},	
	clickable {
		position = {103, 64, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "Y")
		return true
		end 
	},		
	clickable {
		position = {123, 64, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "U")
		return true
		end 
	},
	clickable {
		position = {143, 64, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "I")
		return true
		end 
	},	
	clickable {
		position = {163, 64, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "O")
		return true
		end 
	},
	clickable {
		position = {183, 64, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "P")
		return true
		end 
	},
	clickable {
		position = {13, 44, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "A")
		return true
		end 
	},		
	clickable {
		position = {33, 44, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "S")
		return true
		end 
	},	
	clickable {
		position = {53, 44, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "D")
		return true
		end 
	},	
	clickable {
		position = {73, 44, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "F")
		return true
		end 
	},	
	clickable {
		position = {93, 44, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "G")
		return true
		end 
	},	
	clickable {
		position = {113, 44, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "H")
		return true
		end 
	},	
	clickable {
		position = {133, 44, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "J")
		return true
		end 
	},	
	clickable {
		position = {153, 44, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "K")
		return true
		end 
	},	
	clickable {
		position = {173, 44, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "L")
		return true
		end 
	},	
	clickable {
		position = {33, 24, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "Z")
		return true
		end 
	},	
	clickable {
		position = {53, 24, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "X")
		return true
		end 
	},	
	clickable {
		position = {73, 24, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "C")
		return true
		end 
	},	
	clickable {
		position = {93, 24, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "V")
		return true
		end 
	},	
	clickable {
		position = {113, 24, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "B")
		return true
		end 
	},	
	clickable {
		position = {133, 24, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "N")
		return true
		end 
	},	
	clickable {
		position = {153, 24, 19, 19 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		input = string.format("%s%s",input, "M")
		return true
		end 
	},	
	clickable {
		position = {10, 3, 82, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
input = string.sub(input, 1, -2)
		return true
		end 
	},
	clickable {
		position = {113, 3, 82, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
notLoaded = true
		return true
		end 
	},
}
function draw()
 drawAll(components)
 drawText(font, 10, 264, METAR1, 1.0, 1.0, 1.0)
 drawText(font, 10, 237, METAR2, 1.0, 1.0, 1.0)
 drawText(font, 10, 210, METAR3, 1.0, 1.0, 1.0)
 drawText(font, 10, 183, METAR4, 1.0, 1.0, 1.0)
 drawText(font, 10, 156, METAR5, 1.0, 1.0, 1.0)
 drawText(font, 10, 129, METAR6, 1.0, 1.0, 1.0)
 drawText(font, 10, 92, input, 1.0, 1.0, 1.0)


end