size = { 2048, 2048 }

createProp("sim/custom/xap/MD41/test", "int", 0);
createProp("sim/custom/xap/MD41/OBSreq", "int", 0);
createProp("sim/custom/xap/MD41/visible", "int", 1);

createProp("sim/custom/xap/KLN90/OBS", "int", 1);
createProp("sim/custom/xap/KLN90/APR", "int", 0);
createProp("sim/custom/xap/KLN90/MSG", "int", 0);
createProp("sim/custom/xap/KLN90/WPT", "int", 0);
createProp("sim/custom/xap/KLN90/Flash", "int", 0);
createProp("sim/custom/xap/KLN90/visible", "int", 1);
createProp("sim/custom/xap/KLN90pop/visible", "int", 1);

createProp("sim/custom/xap/KLN90pop/x", "int", 1);
createProp("sim/custom/xap/KLN90pop/y", "int", 1);

defineProperty("MD41visible", globalPropertyi("sim/custom/xap/MD41/visible"))
defineProperty("KLN90visible", globalPropertyi("sim/custom/xap/KLN90/visible"))
defineProperty("KLN90popupvisible", globalPropertyi("sim/custom/xap/KLN90pop/visible"))

defineProperty("popx", globalPropertyi("sim/custom/xap/KLN90pop/x"))
defineProperty("popy", globalPropertyi("sim/custom/xap/KLN90pop/y"))

-- window size issue for panels
defineProperty("window_height",globalPropertyi("sim/graphics/view/window_height"))
defineProperty("window_width",globalPropertyi("sim/graphics/view/window_width"))
defineProperty("external",globalPropertyi("sim/graphics/view/view_is_external"))
defineProperty("scroll",globalPropertyi("sim/graphics/misc/current_scroll_pos"))


local KLNpopupc_command = createCommand("xap/KLN90/Toggle_Popup_Panel", "KLN90popupvisible")
function KLNpopupc_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		if get(KLN90popupvisible) ~= 0 then
			set(KLN90popupvisible, 0)
		else
			set(KLN90popupvisible, 1)
		end
	end
	return 0
end
registerCommandHandler(KLNpopupc_command, 0, KLNpopupc_handler)

local KLNc_command = createCommand("xap/KLN90/Toggle_KLN_90B_Panel", "KLN90visible")
function KLNc_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		if get(KLN90visible) ~= 0 then
			set(KLN90visible, 0)
		else
			set(KLN90visible, 1)
		end
	end
	return 0
end
registerCommandHandler(KLNc_command, 0, KLNc_handler)
local MD41c_command = createCommand("xap/KLN90/Toggle_MD41_Panel", "MD41visible")
function MD41c_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		if get(MD41visible) ~= 0 then
			set(MD41visible, 0)
		else
			set(MD41visible, 1)
		end
	end
	return 0
end
registerCommandHandler(MD41c_command, 0, MD41c_handler)



local coef = get(window_height) / 1024
if coef > 1 then coef = 1 end  -- set initial coefficient for float panel's size - make 'em smaller, if screen resolution less then 1024 by height.

local popx2 = get(window_width) - 100
local popy2 = get(window_height)- 100

local filename = panelDir .. "/KLNconfig.txt"
local file = io.open(filename, "r")
if file then
	while true do
		local line = file:read("*line")
		if line == nil then break end
		if string.find(line, "#popx") then
			popx2 = tonumber(string.sub(line, 6))
		elseif string.find(line, "#popy") then
			popy2 = tonumber(string.sub(line, 6))
		end
	end
	file:close()
end


defineProperty("closeImage", loadImage("close.png"))  -- close cross image
KLN90_panel = subpanel {
	-- position = { 50, 50, 1024 * coef, 330 * coef };
	position = { get(window_width)/2-458, get(window_height)/3-146, 917 * coef, 293 * coef };
	noBackground = true;
	noClose = true;
	components = {
		KLN90_panel {
			position = { 0, 0, 914 * coef, 293 * coef },
		};
		textureLit {
			position = {(914 - 16) * coef, (293 - 16) * coef, 16 * coef, 16 * coef},
			image = get(closeImage),
		};
	};
}

MD41_panel = subpanel {
	position = { get(window_width) - 512, get(window_height)- 330, 512 * coef, 194 * coef };
	noBackground = true;
	noClose = true;
	components = {
		MD41_panel {
			position = { 0, 0, 512 * coef, 194 * coef },
		};
		textureLit {
			position = {(512 - 16) * coef, (194 - 16) * coef, 16 * coef, 16 * coef},
			image = get(closeImage),
		};
	};
}

KLNpopup_panel = subpanel {
	--	position = { popx2, popy2- get(scroll)*1.25, 64 * coef, 64 * coef };
	position = { popx2, popy2, 64 * coef, 64 * coef };
	noBackground = true;
	noClose = true;
	noResize = true;

	components = {
		KLNpopup_panel {
			position = { 0, 0, 64 * coef, 64 * coef },
			visible = function()
				return get(external) == 0
			end,
		};
		textureLit {
			position = {(64 - 13) * coef, (64 - 13) * coef, 16 * coef, 16 * coef},
			visible = function()
				return get(external) == 0
			end,
			image = get(closeImage),
		};
	};
}


local scrolllast = 0

function update()
	local p1 = KLN90_panel
	local p2 = MD41_panel
	local p3 = KLNpopup_panel
	p1.visible = get(KLN90visible) == 1  
	p2.visible = get(MD41visible) == 1  
	p3.visible = get(KLN90popupvisible) == 1  

	local pos = p3.position
	pos["value"][2] = pos["value"][2] + get(scroll)*1.25 - scrolllast

	scrolllast = get(scroll)*1.25
	set(popx, pos["value"][1])
	set(popy, pos["value"][2] - scrolllast)
	p3.position = pos

end   

