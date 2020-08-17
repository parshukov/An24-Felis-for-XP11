size = {520,390}

-------------------------------- Имплементация ГНС 430 в Ан-24 РВ -------------------------------------
g430n1_coarse_down=findCommand("sim/GPS/g430n1_coarse_down")
g430n1_coarse_up=findCommand("sim/GPS/g430n1_coarse_up")
g430n1_fine_down=findCommand("sim/GPS/g430n1_fine_down")
g430n1_fine_up=findCommand("sim/GPS/g430n1_fine_up")
g430n1_chapter_up=findCommand("sim/GPS/g430n1_chapter_up")
g430n1_chapter_dn=findCommand("sim/GPS/g430n1_chapter_dn")
g430n1_page_up=findCommand("sim/GPS/g430n1_page_up")
g430n1_page_down=findCommand("sim/GPS/g430n1_page_dn")

defineProperty("gns430coarseupdown", globalPropertyi("PNV/GNS430/coarseupdown"))
defineProperty("gns430finetune", globalPropertyi("PNV/GNS430/finetune"))
defineProperty("gns430chapterupdown", globalPropertyi("PNV/GNS430/chapterupdown"))
defineProperty("gns430pageupdown", globalPropertyi("PNV/GNS430/pageupdown"))

g430n1_menu=findCommand("sim/GPS/g430n1_menu")
g430n1_direct=findCommand("sim/GPS/g430n1_direct")
g430n1_ent=findCommand("sim/GPS/g430n1_ent")
g430n1_cvol=findCommand("sim/GPS/g430n1_cvol")
g430n1_vvol=findCommand("sim/GPS/g430n1_vvol")
g430n1_zoom_in=findCommand("sim/GPS/g430n1_zoom_in")
g430n1_zoom_out=findCommand("sim/GPS/g430n1_zoom_out")
g430n1_fpl=findCommand("sim/GPS/g430n1_fpl")
g430n1_msg=findCommand("sim/GPS/g430n1_msg")
g430n1_obs=findCommand("sim/GPS/g430n1_obs")
g430n1_cdi=findCommand("sim/GPS/g430n1_cdi")
g430n1_com_ff=findCommand("sim/GPS/g430n1_com_ff")
g430n1_nav_ff=findCommand("sim/GPS/g430n1_nav_ff")
g430n1_nav_com_tog=findCommand("sim/GPS/g430n1_nav_com_tog")
g430n1_cursor=findCommand("sim/GPS/g430n1_cursor")

local knob = loadSample('Custom Sounds/ga430_sound/knob.wav')                   -- крутилка
local pull = loadSample('Custom Sounds/ga430_sound/pull.wav')                   -- большая кнопка 
local button_click = loadSample('Custom Sounds/ga430_sound/button_click.wav')   --нажимная кнопка
local button_click2 = loadSample('Custom Sounds/ga430_sound/button_click2.wav')   --нажимная кнопка

local gns430coarseupdownLOC = 0
local gns430finetuneLOC = 0
local gns430chapterupdownLOC = 0
local gns430pageupdownLOC = 0
local navchange=0

function update()

registerCommandHandler(findCommand("sim/GPS/g430n1_nav_com_tog"), 0, function(p) if p == 0 then playSample(pull, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_cursor"), 0, function(p) if p == 0 then playSample(pull, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_clr"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_menu"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_direct"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_ent"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_cvol"), 0, function(p) if p == 0 then playSample(button_click2, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_vvol"), 0, function(p) if p == 0 then playSample(button_click2, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_zoom_in"), 0, function(p) if p == 0 then playSample(button_click2, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_zoom_out"), 0, function(p) if p == 0 then playSample(button_click2, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_proc"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_fpl"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_msg"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_obs"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_cdi"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_com_ff"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)
registerCommandHandler(findCommand("sim/GPS/g430n1_nav_ff"), 0, function(p) if p == 0 then playSample(button_click, 0) end return 0 end)

---GNS rotary logic
	if get(gns430coarseupdown)>gns430coarseupdownLOC then
		playSample(knob, 0)
		commandOnce(g430n1_coarse_up)
		gns430coarseupdownLOC=get(gns430coarseupdown)
	end
	if get(gns430coarseupdown)<gns430coarseupdownLOC then
		playSample(knob, 0)
		commandOnce(g430n1_coarse_down)
		gns430coarseupdownLOC=get(gns430coarseupdown)
	end
	if get(gns430finetune)>gns430finetuneLOC then
		playSample(knob, 0)
		commandOnce(g430n1_fine_up)
		gns430finetuneLOC=get(gns430finetune)
	end
	if get(gns430finetune)<gns430finetuneLOC then
		playSample(knob, 0)
		commandOnce(g430n1_fine_down)
		gns430finetuneLOC=get(gns430finetune)
	end
	if get(gns430chapterupdown)>gns430chapterupdownLOC then
		playSample(knob, 0)
		commandOnce(g430n1_chapter_up)
		gns430chapterupdownLOC=get(gns430chapterupdown)
	end
	if get(gns430chapterupdown)<gns430chapterupdownLOC then
		playSample(knob, 0)
		commandOnce(g430n1_chapter_dn)
		gns430chapterupdownLOC=get(gns430chapterupdown)
	end
	if get(gns430pageupdown)>gns430pageupdownLOC then
		playSample(knob, 0)
		commandOnce(g430n1_page_up)
		gns430pageupdownLOC=get(gns430pageupdown)
	end
	if get(gns430pageupdown)<gns430pageupdownLOC then
		playSample(knob, 0)
		commandOnce(g430n1_page_down)
		gns430pageupdownLOC=get(gns430pageupdown)
	end

end

----------------------------- Из Як-40 Фелис, автор Н. Паршуков ---------------------------------------

