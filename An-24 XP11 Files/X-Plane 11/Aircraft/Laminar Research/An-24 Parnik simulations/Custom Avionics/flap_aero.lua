defineProperty("cl", globalPropertyf("sim/aircraft/controls/acf_flap_cl"))
defineProperty("cd", globalPropertyf("sim/aircraft/controls/acf_flap_cd"))
defineProperty("cm", globalPropertyf("sim/aircraft/controls/acf_flap_cm"))
defineProperty("flap", globalPropertyf("sim/cockpit2/controls/flap_ratio"))


function update()
flapratio = get(flap)
flapcl = 0.5 * flapratio
flapcd = 0.005 * flapratio
flapcm = -0.4 * flapratio
set(cl , flapcl)
set(cd , flapcd)
set(cm , flapcm)
end
