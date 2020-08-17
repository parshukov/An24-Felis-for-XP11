size = {761, 288}


defineProperty("bg", loadImage("MD41.png", 0, 0, 761, 288))
defineProperty("NAVimg", loadImage("MD41.png", 150, 310, 85, 30))
defineProperty("ARMimg", loadImage("MD41.png", 275, 310, 85, 30))
defineProperty("OBSimg", loadImage("MD41.png", 400, 310, 85, 30))
defineProperty("MSGimg", loadImage("MD41.png", 525, 310, 85, 30))
defineProperty("GPSimg", loadImage("MD41.png", 150, 363, 85, 30))
defineProperty("ACTVimg", loadImage("MD41.png", 275, 363, 85, 30))
defineProperty("LEGimg", loadImage("MD41.png", 400, 363, 85, 30))
defineProperty("WPTimg", loadImage("MD41.png", 525, 363, 85, 30))



defineProperty("HSIsource", globalPropertyi("sim/cockpit2/radios/actuators/HSI_source_select_pilot"))
defineProperty("test", globalPropertyi("sim/custom/xap/MD41/test"))
defineProperty("OBS", globalPropertyi("sim/custom/xap/KLN90/OBS"))
defineProperty("OBSreq", globalPropertyi("sim/custom/xap/MD41/OBSreq"))
defineProperty("APR", globalPropertyi("sim/custom/xap/KLN90/APR"))
defineProperty("MSG", globalPropertyi("sim/custom/xap/KLN90/MSG"))
defineProperty("WPT", globalPropertyi("sim/custom/xap/KLN90/WPT"))
defineProperty("Flash", globalPropertyi("sim/custom/xap/KLN90/Flash"))

defineProperty("Night", globalPropertyf("sim/graphics/scenery/percent_lights_on"))
defineProperty("Panel", globalPropertyf("sim/cockpit/electrical/cockpit_lights"))

defineProperty("MD41visible", globalPropertyi("sim/custom/xap/MD41/visible"))

local Dim = 1
local Testdim = 0

function update()
	if Testdim == 0 then
		--0.75 is the minimum brightness when the panel is fully lit.
		Dim = (-get(Night)*0.75*-get(Panel))/2-get(Night)/2+1
	elseif Testdim == 2 then
		Dim = Dim + 0.05
		if Dim > (-get(Night)*0.75*-get(Panel))/2-get(Night)/2+1 then
			Dim = (-get(Night)*0.75*-get(Panel))/2-get(Night)/2+1
			Testdim = 0
		end
	end

end


local MD41NAVGPSc_command = createCommand("xap/KLN90/MD_41_Toggle_NAV-GPS", "Right Cursor")
function MD41NAVGPSc_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
			if get(HSIsource) == 2  then
				set(HSIsource, 0)
			else
				set(HSIsource, 2)
			end	
			end
	return 0
end
registerCommandHandler(MD41NAVGPSc_command, 0, MD41NAVGPSc_handler)

local MD41APRc_command = createCommand("xap/KLN90/MD_41_Toggle_Approach", "Right Cursor")
function MD41APRc_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
			if get(APR) == 0  then
				set(APR, 1)
			else
				set(APR, 0)
			end
			end
	return 0
end
registerCommandHandler(MD41APRc_command, 0, MD41APRc_handler)
local MD41OBSc_command = createCommand("xap/KLN90/MD_41_Toggle_OBS-LEG", "Right Cursor")
function MD41OBSc_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
			if get(OBS) == 1  then
				set(OBSreq, 2)
			else
				set(OBSreq, 1)
			end
			end
	return 0
end
registerCommandHandler(MD41OBSc_command, 0, MD41OBSc_handler)
local MD41testc_command = createCommand("xap/KLN90/MD_41_Test_Lamps", "Right Cursor")
function MD41testc_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
			set(test, 1)
			elseif 2 == phase then
set(test, 0)
						end
	return 0
end
registerCommandHandler(MD41testc_command, 0, MD41testc_handler)


components = {

	texture {
		position = {0, 0, size[1], size[2]},
		image = get(bg),
	},


	textureLit2 {
		position = {150, 208, 85, 30},
		image = get(NAVimg),
		brt2 = function() 
			return get(Dim)
		end,
		visible = function()
			return get(HSIsource) ~= 2 or get(test) == 1
		end,
	},

	textureLit2 {
		position = {150, 155, 85, 30},
		image = get(GPSimg),
		brt2 = function() 
			return get(Dim)
		end,
		visible = function()
			return get(HSIsource) == 2 or get(test) == 1
		end,
	},








	clickable {
		position = {143, 33, 80, 80 },

		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
			if get(HSIsource) == 2  then
				set(HSIsource, 0)
			else
				set(HSIsource, 2)
			end
			return true
		end  
	},	

	textureLit2 {
		position = {275, 208, 85, 30},
		image = get(ARMimg),
		brt2 = function() 
			return get(Dim)
		end,
		visible = function()
			return get(APR) == 1 or get(test) == 1
		end,
	},
	textureLit2 {
		position = {275, 155, 85, 30},
		image = get(ACTVimg),
		brt2 = function() 
			return get(Dim)
		end,
		visible = function()
			return get(APR) == 2 or get(test) == 1
		end,
	},



	clickable {
		position = {272, 33, 80, 80 },

		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
			if get(APR) == 1  then
				set(APR, 0)
			else
				set(APR, 1)
			end
			return true
		end  
	},	


	textureLit2 {
		position = {400, 208, 85, 30},
		image = get(OBSimg),
		brt2 = function() 
			return get(Dim)
		end,
		visible = function()
			return get(OBS) == 2 or get(test) == 1
		end,
	},
	textureLit2 {
		position = {400, 155, 85, 30},
		image = get(LEGimg),
		brt2 = function() 
			return get(Dim)
		end,
		visible = function()
			return get(OBS) == 1 or get(test) == 1
		end,
	},




	clickable {
		position = {409, 33, 80, 80 },

		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
			if get(OBS) == 1  then
				set(OBSreq, 2)
			else
				set(OBSreq, 1)
			end
			return true
		end  
	},	

	textureLit2 {
		position = {525, 208, 85, 30},
		image = get(MSGimg),
		brt2 = function() 
			return get(Dim)
		end,
		visible = function()
			return (get(MSG) == 1 and get(Flash) == 1) or get(test) == 1
		end,
	},
	textureLit2 {
		position = {525, 155, 85, 30},
		image = get(WPTimg),
		brt2 = function() 
			return get(Dim)
		end,
		visible = function()
			return (get(WPT) == 1 and get(Flash) == 1) or get(test) == 1
		end,
	},

	clickable {
		position = {50, 119, 40, 40 },

		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function() 
			Testdim = 1
			Dim = Dim - 0.05
			if Dim < 0.5 then
				Dim = 0.5
			end
			return true
		end,
		onMouseUp = function()
			Testdim = 2
			return true
		end,
	},	


	clickable {
		position = {665, 125, 30, 30 },

		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function() 
			set(test, 1)
			return true
		end,
		onMouseUp = function()
			set(test, 0)
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
			set(MD41visible, 0 )
			return true
		end
	},	
}
