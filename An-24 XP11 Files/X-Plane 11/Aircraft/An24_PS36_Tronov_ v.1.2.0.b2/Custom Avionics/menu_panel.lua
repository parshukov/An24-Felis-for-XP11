size = {32, 485}

-- define panels datarefs
defineProperty("main_menu_subpanel", globalPropertyi("sim/custom/xap/An24_panels/main_menu_subpanel"))
defineProperty("nav1_subpanel", globalPropertyi("sim/custom/xap/An24_panels/nav1_subpanel"))
defineProperty("nav2_subpanel", globalPropertyi("sim/custom/xap/An24_panels/nav2_subpanel"))
defineProperty("electropanel_subpanel", globalPropertyi("sim/custom/xap/An24_panels/electropanel_subpanel"))
defineProperty("left_subpanel", globalPropertyi("sim/custom/xap/An24_panels/left_subpanel"))
defineProperty("ap_panel_subpanel", globalPropertyi("sim/custom/xap/An24_panels/ap_panel_subpanel"))
defineProperty("right_subpanel", globalPropertyi("sim/custom/xap/An24_panels/right_subpanel"))
defineProperty("nl10m_subpanel", globalPropertyi("sim/custom/xap/An24_panels/nl10m_subpanel"))
defineProperty("radio_subpanel", globalPropertyi("sim/custom/xap/An24_panels/radio_subpanel"))
defineProperty("service_subpanel", globalPropertyi("sim/custom/xap/An24_panels/service_subpanel"))
defineProperty("payload_subpanel", globalPropertyi("sim/custom/xap/An24_panels/payload_subpanel"))
defineProperty("options_subpanel", globalPropertyi("sim/custom/xap/An24_panels/options_subpanel"))
defineProperty("fuel_subpanel", globalPropertyi("sim/custom/xap/An24_panels/fuel_subpanel"))
defineProperty("map_subpanel", globalPropertyi("sim/custom/xap/An24_panels/map_subpanel"))
defineProperty("info_subpanel", globalPropertyi("sim/custom/xap/An24_panels/info_subpanel"))
defineProperty("camera_subpanel", globalPropertyi("sim/custom/xap/An24_panels/camera_subpanel"))
defineProperty("rsbn_subpanel", globalPropertyi("sim/custom/xap/An24_panels/rsbn_subpanel"))
defineProperty("nas1_subpanel", globalPropertyi("sim/custom/xap/An24_panels/nas1_subpanel"))
defineProperty("uphone_subpanel", globalPropertyi("sim/custom/xap/An24_panels/uphone_subpanel"))
defineProperty("fplan_subpanel", globalPropertyi("sim/custom/xap/An24_panels/fplan_subpanel"))


-- images
defineProperty("background", loadImage("menu_panel.png", 0, 0, size[1], size[2] - 10))

-- get panels for manipulate them
--defineProperty("panel_1") 
defineProperty("panel_2")
defineProperty("panel_3")  
defineProperty("panel_4") 
defineProperty("panel_5")   
defineProperty("panel_6")
defineProperty("panel_7")
defineProperty("panel_8")   
defineProperty("panel_9")  
defineProperty("panel_10") 
defineProperty("panel_11") 
defineProperty("panel_12") 
defineProperty("panel_13") 
defineProperty("panel_14") 
defineProperty("panel_15") 
defineProperty("panel_16")
defineProperty("panel_17")
defineProperty("panel_18")
defineProperty("panel_19")
defineProperty("panel_20")

--[[
	panel_1 = main_menu
	panel_2 = nav_panel1
	panel_3 = nav_panel2
	panel_4 = electropanel
	panel_5 = fuel_panel
	panel_6 = left_panel
	panel_7 = right_panel
	panel_8 = ap_panel
	panel_9 = radio_panel
	panel_10 = service_panel
	panel_11 = payload
	panel_12 = nl10m_panel
	panel_13 = map_panel
	panel_14 = options
	panel_15 = info panel
--]]

    --local p1 = get(panel_1)
    local p2 = get(panel_2)
    local p3 = get(panel_3)
    local p4 = get(panel_4)
    local p5 = get(panel_5) 
    local p6 = get(panel_6)
    local p7 = get(panel_7)
    local p8 = get(panel_8)
    local p9 = get(panel_9)
    local p10 = get(panel_10)
	local p11 = get(panel_11)
	local p12 = get(panel_12)
	local p13 = get(panel_13)
	local p14 = get(panel_14)
	local p15 = get(panel_15)
	local p16 = get(panel_16)
	local p17 = get(panel_17)
	local p18 = get(panel_18)
	local p19 = get(panel_19)
	local p20 = get(panel_20)

components = {
	-- background
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {0,0,0,0.5},
	},
	textureLit {
		position = {0, 10, size[1], size[2] - 10},
		image = get(background),
	},


	
	-- panel's switchers
	-- options
    switch {
        position = { 0, 10, 32, 25},
        state = function()
            return get(options_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(options_subpanel) ~= 0 then
                set(options_subpanel, 0)
            else
                set(options_subpanel, 1)
				movePanelToTop(p14)
            end 
            return true;
        end 
    }, 	

	
	-- uphone
    switch {
        position = { 0, 285, 32, 25},
        state = function()
            return get(uphone_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(uphone_subpanel) ~= 0 then
                set(uphone_subpanel, 0)
            else
                set(uphone_subpanel, 1)
				movePanelToTop(p19)
            end 
            return true;
        end 
    }, 	
	-- nas1
    switch {
        position = { 0, 60, 32, 25},
        state = function()
            return get(nas1_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(nas1_subpanel) ~= 0 then
                set(nas1_subpanel, 0)
            else
                set(nas1_subpanel, 1)
				movePanelToTop(p18)
            end 
            return true;
        end 
    }, 	
	-- rsbn
    switch {
        position = { 0, 85, 32, 25},
        state = function()
            return get(rsbn_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(rsbn_subpanel) ~= 0 then
                set(rsbn_subpanel, 0)
            else
                set(rsbn_subpanel, 1)
				movePanelToTop(p17)
            end 
            return true;
        end 
    }, 	
	-- map
    switch {
        position = { 0, 335, 32, 25},
        state = function()
            return get(map_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(map_subpanel) ~= 0 then
                set(map_subpanel, 0)
            else
                set(map_subpanel, 1)
				movePanelToTop(p13)
            end 
            return true;
        end 
    }, 

	-- NL10
    switch {
        position = { 0, 310, 32, 25},
        state = function()
            return get(nl10m_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(nl10m_subpanel) ~= 0 then
                set(nl10m_subpanel, 0)
            else
                set(nl10m_subpanel, 1)
				movePanelToTop(p12)
            end 
            return true;
        end 
    }, 
	--Flightplan
    switch {
        position = { 0, 385, 32, 25},
        state = function()
            return get(fplan_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(fplan_subpanel) ~= 0 then
                set(fplan_subpanel, 0)
            else
                set(fplan_subpanel, 1)
				movePanelToTop(p20)
            end 
            return true;
        end 
    }, 	

	-- payload
    switch {
        position = { 0, 410, 32, 25},
        state = function()
            return get(payload_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(payload_subpanel) ~= 0 then
                set(payload_subpanel, 0)
            else
                set(payload_subpanel, 1)
				movePanelToTop(p11)
            end 
            return true;
        end 
    }, 
	
	-- service
    switch {
        position = { 0, 435, 32, 25},
        state = function()
            return get(service_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(service_subpanel) ~= 0 then
                set(service_subpanel, 0)
            else
                set(service_subpanel, 1)
				movePanelToTop(p10)
            end 
            return true;
        end 
    }, 	
	
	-- radio
    switch {
        position = { 0, 160, 32, 25},
        state = function()
            return get(radio_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(radio_subpanel) ~= 0 then
                set(radio_subpanel, 0)
            else
                set(radio_subpanel, 1)
				movePanelToTop(p9)
            end 
            return true;
        end 
    }, 	
	
	-- autopilot
    switch {
        position = { 0, 35, 32, 25},
        state = function()
            return get(ap_panel_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(ap_panel_subpanel) ~= 0 then
                set(ap_panel_subpanel, 0)
            else
                set(ap_panel_subpanel, 1)
				movePanelToTop(p8)
            end 
            return true;
        end 
    }, 	
	
	-- right panel
    switch {
        position = { 0, 185, 32, 25},
        state = function()
            return get(right_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(right_subpanel) ~= 0 then
                set(right_subpanel, 0)
            else
                set(right_subpanel, 1)
				movePanelToTop(p7)
            end 
            return true;
        end 
    }, 	
	
	-- left panel
    switch {
        position = { 0, 210, 32, 25},
        state = function()
            return get(left_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(left_subpanel) ~= 0 then
                set(left_subpanel, 0)
            else
                set(left_subpanel, 1)
				movePanelToTop(p6)
            end 
            return true;
        end 
    }, 	
	
	-- fuel panel
    switch {
        position = { 0, 235, 32, 25},
        state = function()
            return get(fuel_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(fuel_subpanel) ~= 0 then
                set(fuel_subpanel, 0)
            else
                set(fuel_subpanel, 1)
				movePanelToTop(p5)
            end 
            return true;
        end 
    }, 	
	
	-- electric panel
    switch {
        position = { 0, 260, 32, 25},
        state = function()
            return get(electropanel_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(electropanel_subpanel) ~= 0 then
                set(electropanel_subpanel, 0)
            else
                set(electropanel_subpanel, 1)
				movePanelToTop(p4)
            end 
            return true;
        end 
    }, 	
	
	-- nav2 panel
    switch {
        position = { 0, 110, 32, 25},
        state = function()
            return get(nav2_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(nav2_subpanel) ~= 0 then
                set(nav2_subpanel, 0)
            else
                set(nav2_subpanel, 1)
				movePanelToTop(p3)
            end 
            return true;
        end 
    }, 	
	
	-- nav1 panel
    switch {
        position = { 0, 135, 32, 25},
        state = function()
            return get(nav1_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(nav1_subpanel) ~= 0 then
                set(nav1_subpanel, 0)
            else
                set(nav1_subpanel, 1)
				movePanelToTop(p2)
            end 
            return true;
        end 
    }, 		
	
	-- info_subpanel panel
    switch {
        position = { 0, 360, 32, 25},
        state = function()
            return get(info_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(info_subpanel) ~= 0 then
                set(info_subpanel, 0)
            else
                set(info_subpanel, 1)
				movePanelToTop(p15)
            end 
            return true;
        end 
    }, 	

	-- camera_subpanel
    switch {
        position = { 0, 460, 32, 25},
        state = function()
            return get(camera_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(camera_subpanel) ~= 0 then
                set(camera_subpanel, 0)
            else
                set(camera_subpanel, 1)
				movePanelToTop(p16)
            end 
            return true;
        end 
    },
--]]

}

