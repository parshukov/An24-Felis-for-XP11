
--sim/flightmodel/controls/mwing01_ail1def
--sim/flightmodel/controls/mwing02_ail1def
--sim/multiplayer/controls/yoke_roll_ratio
--sim/flightmodel/controls/mwing03_elv1def






defineProperty("set_real_fuel_meter", globalPropertyi("sim/custom/xap/An24_set/real_fuel_meter")) -- real fuel meter will show less fuel amount, then it's really is

defineProperty("ed", globalPropertyf("sim/flightmodel/controls/mwing01_elv1def"))
defineProperty("ed2", globalPropertyf("sim/flightmodel/controls/mwing02_elv1def"))
defineProperty("ar", globalPropertyf("sim/flightmodel/controls/mwing06_ail1def"))
defineProperty("al", globalPropertyf("sim/flightmodel/controls/mwing07_ail1def"))
defineProperty("ja", globalPropertyf("sim/multiplayer/controls/yoke_roll_ratio"))
defineProperty("jt", globalPropertyf("sim/multiplayer/controls/yoke_pitch_ratio"))
defineProperty("trimm", globalPropertyf("sim/cockpit2/controls/elevator_trim"))

tlast = 0
alr = 0
el = 0

function update()

trim = get(trimm) * -20
jr = get(ja) * -20
je = get(jt) * -20


ald = (jr - alr)
if ald < 0 then ald = ald * -1 end
if ald > 0.1 then

--down
if alr < jr and alr < 0 then alr = (alr + 1)
elseif alr < jr and alr >= 0 then alr = (alr + 0.5)

--up
elseif alr > jr and alr > 0 then alr = (alr - 1)
elseif alr > jr and alr <= 0 then alr = (alr - 0.5) end


end
ald1 = (je - el)
if ald1 < 0 then ald1 = ald1 * -1 end

if ald1 > 0.1 then

--down
if el < je and el < 0 then el = (el + 1)
elseif el < je and el >= 0 then el = (el + 0.2)

--up
elseif el > je and el > 0 then el = (el - 1)
elseif el > je and el <= 0 then el = (el - 0.2) end
end

if get(set_real_fuel_meter)==1 then
	set (ar, alr)
	set (al, alr * -1)
	set (ed, el + trim)
	set (ed2, el + trim)
end
--tlast = tnow
end
