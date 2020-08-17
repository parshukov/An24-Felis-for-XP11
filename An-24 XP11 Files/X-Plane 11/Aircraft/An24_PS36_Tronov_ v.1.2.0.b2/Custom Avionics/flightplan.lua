size = {710, 507}

defineProperty("bg", loadImage("flightplan.dds", 5, 3, size[1], size[2]))
defineProperty("stroked1", loadImage("flightplan.dds", 733, 85, 291, 13))
defineProperty("stroked2", loadImage("flightplan.dds", 733, 98, 291, 13))
defineProperty("stroked3", loadImage("flightplan.dds", 733, 111, 291, 13))
defineProperty("deselected", loadImage("flightplan.dds", 756, 473, 22, 22))
defineProperty("APselected", loadImage("flightplan.dds", 135, 473, 22, 22))
defineProperty("white", loadImage("flightplan.dds", 20, 15, 5, 5))

defineProperty("fplan_subpanel", globalPropertyi("sim/custom/xap/An24_panels/fplan_subpanel"))

defineProperty("GPS_name", globalPropertys("sim/cockpit2/radios/indicators/gps_nav_id"))
defineProperty("GPS_dist", globalPropertys("sim/cockpit2/radios/indicators/gps_dme_distance_nm"))

defineProperty("DME_dist", globalPropertyf("sim/cockpit2/radios/indicators/dme_dme_distance_nm"))
defineProperty("DME_freq", globalPropertyi("sim/cockpit2/radios/actuators/dme_frequency_hz"))
defineProperty("DME_DME", globalPropertyi("sim/cockpit2/radios/indicators/dme_has_dme"))

defineProperty("nav1_freq", globalPropertyi("sim/cockpit2/radios/actuators/nav1_frequency_hz"))
defineProperty("nav1_course", globalPropertyf("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot"))
defineProperty("nav1_flag", globalPropertyf("sim/cockpit2/radios/indicators/nav1_flag_from_to_pilot"))
defineProperty("nav2_flag", globalPropertyf("sim/cockpit2/radios/indicators/nav2_flag_from_to_pilot"))
defineProperty("nav1_DME", globalPropertyf("sim/cockpit2/radios/indicators/nav1_has_dme"))
defineProperty("nav2_DME", globalPropertyf("sim/cockpit2/radios/indicators/nav2_has_dme"))
defineProperty("nav1_bear", globalPropertyi("sim/cockpit2/radios/indicators/nav1_bearing_deg_mag"))
defineProperty("nav2_bear", globalPropertyi("sim/cockpit2/radios/indicators/nav2_bearing_deg_mag"))

defineProperty("adf1_bear", globalPropertyi("sim/cockpit2/radios/indicators/adf1_bearing_deg_mag"))
defineProperty("adf2_bear", globalPropertyi("sim/cockpit2/radios/indicators/adf2_bearing_deg_mag"))
defineProperty("adf1_meter", globalPropertyf("sim/custom/xap/An24_ark/ark1_signal"))
defineProperty("adf2_meter", globalPropertyf("sim/custom/xap/An24_ark/ark2_signal"))
defineProperty("ark1_mode", globalPropertyi("sim/custom/xap/An24_ark/ark1_mode"))
defineProperty("ark2_mode", globalPropertyi("sim/custom/xap/An24_ark/ark2_mode"))
defineProperty("ap_curse", globalPropertyf("sim/custom/xap/An24_ap/curse_zk")) -- curse for autopilot
defineProperty("gyro_curse", globalPropertyf("sim/custom/xap/An24_gauges/GPK_curse"))  -- gyro curse from GIK
defineProperty("deg1", globalPropertyf("sim/flightmodel/position/psi"))
defineProperty("deg2", globalPropertyf("sim/flightmodel/position/hpath"))
defineProperty("GPS_course", globalPropertyf("sim/cockpit2/radios/indicators/gps_relative_bearing_deg"))

defineProperty("DME_sw", globalPropertyi("sim/custom/xap/An24_gauges/dme_on"))  -- power switcher
defineProperty("curs_mp1_sw", globalPropertyi("sim/custom/xap/An24_gauges/curs_mp1_sw")) 
defineProperty("curs_mp2_sw", globalPropertyi("sim/custom/xap/An24_gauges/curs_mp2_sw")) 
defineProperty("ark_vor", globalPropertyf("sim/custom/xap/An24_gauges/ark_vor")) -- switcher ARK/VOR
defineProperty("alt3", globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_copilot"))
defineProperty("ap_kv", globalPropertyi("sim/custom/xap/An24_ap/ap_kv"))  -- button for altitude hold


defineProperty("adf1_freq", globalPropertyi("sim/custom/xap/An24_ark/ark1_need_freq"))
defineProperty("nav2_freq", globalPropertyi("sim/cockpit2/radios/actuators/nav2_frequency_hz"))
defineProperty("nav2_course", globalPropertyf("sim/cockpit2/radios/actuators/nav2_obs_deg_mag_pilot"))
defineProperty("adf2_freq", globalPropertyi("sim/custom/xap/An24_ark/ark2_need_freq"))
defineProperty("nav_select", globalPropertyi("sim/custom/xap/An24_gauges/nav_select"))

defineProperty("datedays", globalPropertyi("sim/time/local_date_days"))


defineProperty("GPS_visible", globalPropertyi("sim/custom/xap/An24_set/hide_GPS"))
defineProperty("Garmin_visible", globalPropertyi("sim/custom/xap/An24_set/hide_Garmin"))
defineProperty("dst1", globalPropertyf("sim/custom/xap/An24_nas1/N_needle"))
defineProperty("dst2", globalPropertyf("sim/custom/xap/An24_nas1/E_needle"))
defineProperty("counter", globalPropertyf("sim/custom/xap/An24_nas1/counter"))
defineProperty("mode1", globalPropertyf("sim/custom/xap/An24_nas1/mode1"))
defineProperty("mode2", globalPropertyf("sim/custom/xap/An24_nas1/mode2"))
defineProperty("map_angle", globalPropertyf("sim/custom/xap/An24_nas1/map_angle"))
defineProperty("water", globalPropertyf("sim/custom/xap/An24_nas1/water"))
defineProperty("DISS", globalPropertyf("sim/custom/xap/An24_nas1/DISS"))
defineProperty("winddelta", globalPropertyf("sim/custom/xap/An24_nas1/windangle"))
defineProperty("windspeed", globalPropertyf("sim/custom/xap/An24_nas1/windspeed"))
defineProperty("rls_power_cc", globalPropertyf("sim/custom/xap/An24_rls/rls_power_cc"))

defineProperty("act_winddelta", globalPropertyf("sim/weather/wind_direction_degt"))
defineProperty("act_windspeed", globalPropertyf("sim/weather/wind_speed_kt"))

defineProperty("lattest", globalPropertyf("sim/flightmodel/position/latitude"))
defineProperty("lontest", globalPropertyf("sim/flightmodel/position/longitude"))

defineProperty("agl", globalPropertyf("sim/flightmodel/position/y_agl"))

--defineProperty("magpsi", globalPropertyf("sim/flightmodel/position/magpsi"))

clearcomm = findCommand("sim/FMS/clear")
aptcomm = findCommand("sim/FMS/type_apt")
vorcomm = findCommand("sim/FMS/type_vor")
ndbcomm = findCommand("sim/FMS/type_ndb")
fixcomm = findCommand("sim/FMS/type_fix")

acomm = findCommand("sim/FMS/key_A")
bcomm = findCommand("sim/FMS/key_B")
ccomm = findCommand("sim/FMS/key_C")
dcomm = findCommand("sim/FMS/key_D")
ecomm = findCommand("sim/FMS/key_E")
fcomm = findCommand("sim/FMS/key_F")
gcomm = findCommand("sim/FMS/key_G")
hcomm = findCommand("sim/FMS/key_H")
icomm = findCommand("sim/FMS/key_I")
jcomm = findCommand("sim/FMS/key_J")
kcomm = findCommand("sim/FMS/key_K")
lcomm = findCommand("sim/FMS/key_L")
mcomm = findCommand("sim/FMS/key_M")
ncomm = findCommand("sim/FMS/key_N")
ocomm = findCommand("sim/FMS/key_O")
pcomm = findCommand("sim/FMS/key_P")
qcomm = findCommand("sim/FMS/key_Q")
rcomm = findCommand("sim/FMS/key_R")
scomm = findCommand("sim/FMS/key_S")
tcomm = findCommand("sim/FMS/key_T")
ucomm = findCommand("sim/FMS/key_U")
vcomm = findCommand("sim/FMS/key_V")
wcomm = findCommand("sim/FMS/key_W")
xcomm = findCommand("sim/FMS/key_X")
ycomm = findCommand("sim/FMS/key_Y")
zcomm = findCommand("sim/FMS/key_Z")
n0comm = findCommand("sim/FMS/key_0")
n1comm = findCommand("sim/FMS/key_1")
n2comm = findCommand("sim/FMS/key_2")
n3comm = findCommand("sim/FMS/key_3")
n4comm = findCommand("sim/FMS/key_4")
n5comm = findCommand("sim/FMS/key_5")
n6comm = findCommand("sim/FMS/key_6")
n7comm = findCommand("sim/FMS/key_7")
n8comm = findCommand("sim/FMS/key_8")
n9comm = findCommand("sim/FMS/key_9")



local font = loadFont('flightplan.fnt')
local font2 = loadFont('handwriting.fnt')

local handle_nas = 1
local handle_fplan = 1
local handle_radio = 1
local handle_gps = 1

local wait = 0
local page = 0


local handle_ap = 2


local active = 1
local active2 = 0
local active3 = 0
local notes1 = ""
local nextfreq2 = 0
local pagetext = ""

local totaldist = 0
local totaldist2 = 0
local setkppm = 0
local setdme = 0
local setradio = 0
local setadf1 = 0
local setadf2 = 0

local num = 0
local days = get(datedays) + 1
local datetext = ""
local disttext = ""
local table1 = {}
local month = 1




local writemode = 1

local line1 = ""
local line2 = ""
local line3 = ""
local line4 = ""
local line5 = ""
local line6 = ""
local line7 = ""
local line8 = ""
local line9 = ""
local line10 = ""
local line11 = ""
local line12 = ""
local line13 = ""
local line14 = ""
local line15 = ""
local input = ""
local notLoaded = false
local diff2 = 0
local slip = 0
local alt2 = 0

local currtype = 99
local currcourse = 0
local currdist = 0
local prev = 0
local nasdist = 0
local nasN = 0
local nasE = 0

local diff = 0
local modes = "VFR"

local DME_possible1 = 0
local DME_possible2 = 0


local prevtype = 0
local prevdist = 0
local prevcourse = 0

local nexttype = 0
local nextdist = 0
local nextcourse = 0
local prevfreq = 0
local nextfreq = 0
local currident = 0
local somecourse = 0

local magtable = {}
magtable[1] = { -152.3,-147.3,-142.3,-137.3,-132.3,-127.3,-122.3,-117.3,-112.3,-107.3,-102.3, -97.3, -92.3, -87.3, -82.3, -77.3, -72.3, -67.3, -62.3, -57.3, -52.3, -47.3, -42.3, -37.3, -32.3, -27.3, -22.3, -17.3, -12.3,  -7.3,  -2.3,   2.7,   7.7,  12.7,  17.7,  22.7,  27.7,  32.7,  37.7,  42.7,  47.7,  52.7,  57.7,  62.7,  67.7,  72.7,  77.7,  82.7,  87.7,  92.7,  97.7, 102.7, 107.7, 112.7, 117.7, 122.7, 127.7, 132.7, 137.7, 142.7, 147.7, 152.7, 157.7, 162.7, 167.7, 172.7, 177.7,-177.3,-172.3,-167.3,-162.3,-157.3,-152.3}
magtable[2] = { -145.1,-139.4,-133.7,-128.2,-122.7,-117.3,-112.0,-106.8,-101.7, -96.6, -91.7, -86.8, -82.0, -77.3, -72.6, -68.0, -63.5, -59.0, -54.5, -50.1, -45.7, -41.3, -37.0, -32.6, -28.3, -24.0, -19.7, -15.5, -11.2,  -6.9,  -2.6,   1.7,   6.0,  10.3,  14.7,  19.0,  23.4,  27.9,  32.3,  36.8,  41.4,  45.9,  50.6,  55.2,  59.9,  64.7,  69.5,  74.3,  79.3,  84.2,  89.3,  94.4,  99.6, 104.8, 110.1, 115.5, 121.0, 126.5, 132.1, 137.8, 143.6, 149.4, 155.3, 161.2, 167.2, 173.2, 179.2,-174.8,-168.8,-162.8,-156.8,-151.0,-145.1}
magtable[3] = { -133.0,-126.4,-120.2,-114.3,-108.7,-103.3, -98.2, -93.3, -88.6, -84.0, -79.6, -75.3, -71.1, -67.0, -62.9, -58.9, -55.0, -51.1, -47.2, -43.4, -39.6, -35.8, -32.0, -28.2, -24.5, -20.8, -17.1, -13.3,  -9.6,  -5.9,  -2.2,   1.6,   5.4,   9.2,  13.1,  17.0,  20.9,  24.9,  29.0,  33.1,  37.2,  41.5,  45.8,  50.1,  54.5,  59.0,  63.6,  68.2,  72.9,  77.7,  82.5,  87.5,  92.5,  97.7, 103.0, 108.5, 114.1, 120.0, 126.0, 132.3, 138.8, 145.6, 152.6, 159.8, 167.3, 174.9,-177.3,-169.6,-161.9,-154.3,-146.9,-139.8,-133.0}
magtable[4] = { -112.7,-106.2,-100.4, -95.2, -90.4, -86.0, -81.9, -78.1, -74.4, -70.9, -67.5, -64.1, -60.8, -57.5, -54.2, -50.9, -47.6, -44.3, -41.0, -37.6, -34.3, -30.9, -27.5, -24.2, -20.8, -17.5, -14.2, -10.9,  -7.6,  -4.4,  -1.1,   2.2,   5.6,   9.0,  12.4,  15.9,  19.5,  23.1,  26.9,  30.7,  34.6,  38.6,  42.7,  46.8,  51.0,  55.2,  59.5,  63.9,  68.3,  72.7,  77.2,  81.8,  86.5,  91.4,  96.3, 101.5, 106.9, 112.6, 118.6, 125.2, 132.3, 140.1, 148.6, 158.1, 168.3, 179.2,-169.4,-158.1,-147.3,-137.2,-128.1,-119.9,-112.7}
magtable[5] = {  -85.1, -80.9, -77.2, -73.9, -71.0, -68.4, -65.9, -63.5, -61.2, -59.0, -56.7, -54.4, -52.0, -49.6, -47.1, -44.5, -41.7, -38.9, -36.0, -33.0, -29.9, -26.8, -23.7, -20.6, -17.4, -14.3, -11.3,  -8.2,  -5.3,  -2.3,   0.6,   3.5,   6.4,   9.4,  12.5,  15.6,  18.8,  22.2,  25.7,  29.3,  33.0,  36.8,  40.7,  44.6,  48.6,  52.7,  56.7,  60.7,  64.8,  68.9,  72.9,  77.0,  81.1,  85.2,  89.5,  93.8,  98.4, 103.3, 108.6, 114.5, 121.3, 129.6, 140.0, 153.6, 171.5,-167.2,-145.7,-127.8,-114.2,-104.1, -96.3, -90.2, -85.1}
magtable[6] = {  -60.7, -59.0, -57.4, -56.0, -54.7, -53.5, -52.4, -51.2, -50.1, -49.0, -47.7, -46.4, -44.9, -43.3, -41.4, -39.4, -37.2, -34.8, -32.2, -29.4, -26.5, -23.5, -20.4, -17.3, -14.2, -11.1,  -8.2,  -5.3,  -2.5,   0.2,   2.8,   5.4,   7.9,  10.5,  13.1,  15.9,  18.8,  21.9,  25.1,  28.5,  32.0,  35.6,  39.4,  43.2,  47.0,  50.8,  54.6,  58.3,  62.0,  65.5,  69.0,  72.4,  75.7,  78.9,  82.0,  85.0,  88.0,  91.0,  93.9,  96.9, 100.0, 103.5, 108.2, 118.5,-122.6, -82.2, -75.6, -71.8, -69.0, -66.6, -64.4, -62.5, -60.7}
magtable[7] = {  -44.9, -44.4, -43.9, -43.4, -42.9, -42.5, -42.1, -41.7, -41.3, -40.9, -40.5, -39.9, -39.1, -38.1, -36.9, -35.4, -33.6, -31.6, -29.2, -26.6, -23.8, -20.7, -17.6, -14.3, -11.1,  -7.9,  -4.9,  -2.0,   0.8,   3.3,   5.6,   7.9,  10.0,  12.2,  14.4,  16.7,  19.2,  21.9,  24.9,  28.0,  31.3,  34.8,  38.4,  42.1,  45.7,  49.3,  52.7,  56.1,  59.3,  62.2,  65.0,  67.6,  69.8,  71.8,  73.5,  74.7,  75.3,  75.1,  73.8,  70.6,  64.2,  52.1,  30.7,   3.1, -18.6, -31.3, -38.1, -41.9, -43.9, -44.9, -45.2, -45.2, -44.9}
magtable[8] = {  -35.4, -35.3, -35.2, -35.0, -34.8, -34.6, -34.5, -34.5, -34.5, -34.5, -34.5, -34.4, -34.1, -33.7, -32.9, -31.9, -30.5, -28.8, -26.7, -24.3, -21.5, -18.3, -15.0, -11.5,  -8.0,  -4.6,  -1.3,   1.7,   4.5,   6.9,   9.1,  11.0,  12.8,  14.5,  16.2,  18.0,  20.1,  22.3,  24.9,  27.7,  30.8,  34.1,  37.5,  41.0,  44.4,  47.7,  50.8,  53.7,  56.4,  58.7,  60.7,  62.3,  63.5,  64.1,  64.0,  63.1,  61.0,  57.5,  52.0,  44.0,  33.1,  20.1,   6.7,  -5.3, -14.7, -21.6, -26.5, -29.9, -32.2, -33.8, -34.7, -35.2, -35.4}
magtable[9] = {  -29.2, -29.3, -29.3, -29.2, -29.1, -29.0, -29.0, -29.1, -29.2, -29.4, -29.6, -29.7, -29.8, -29.6, -29.3, -28.6, -27.7, -26.3, -24.4, -22.1, -19.3, -16.1, -12.5,  -8.8,  -4.9,  -1.1,   2.4,   5.7,   8.5,  11.0,  13.0,  14.7,  16.1,  17.3,  18.5,  19.8,  21.3,  23.0,  25.0,  27.4,  30.1,  33.1,  36.3,  39.6,  42.8,  45.8,  48.6,  51.0,  53.1,  54.7,  55.9,  56.5,  56.4,  55.7,  53.9,  51.1,  47.0,  41.3,  34.2,  25.8,  16.8,   8.0,  -0.1,  -7.0, -12.7, -17.2, -20.8, -23.6, -25.7, -27.2, -28.3, -28.9, -29.2}
magtable[10] = {  -24.9, -25.1, -25.1, -25.0, -24.9, -24.8, -24.8, -24.9, -25.1, -25.3, -25.5, -25.7, -25.8, -25.9, -25.8, -25.4, -24.7, -23.6, -22.0, -19.8, -17.1, -13.8, -10.0,  -6.0,  -1.8,   2.4,   6.2,   9.7,  12.7,  15.1,  17.0,  18.4,  19.5,  20.4,  21.2,  21.9,  22.7,  23.7,  25.1,  26.9,  29.1,  31.7,  34.6,  37.6,  40.6,  43.3,  45.7,  47.6,  49.1,  50.0,  50.4,  50.0,  48.9,  46.9,  43.9,  39.9,  34.7,  28.6,  21.9,  15.1,   8.6,   2.6,  -2.7,  -7.2, -11.2, -14.5, -17.3, -19.6, -21.4, -22.8, -23.8, -24.5, -24.9}
magtable[11] = {  -21.6, -21.8, -21.8, -21.8, -21.7, -21.6, -21.6, -21.7, -21.8, -21.9, -22.1, -22.2, -22.4, -22.4, -22.4, -22.2, -21.7, -20.8, -19.4, -17.4, -14.7, -11.3,  -7.4,  -3.1,   1.3,   5.7,   9.8,  13.4,  16.3,  18.7,  20.4,  21.7,  22.6,  23.2,  23.6,  23.8,  24.0,  24.3,  24.9,  25.8,  27.4,  29.5,  32.0,  34.7,  37.4,  39.8,  41.8,  43.3,  44.3,  44.6,  44.2,  43.1,  41.1,  38.3,  34.6,  30.1,  24.9,  19.4,  13.9,   8.7,   4.0,  -0.1,  -3.8,  -7.0,  -9.9, -12.4, -14.7, -16.6, -18.2, -19.5, -20.5, -21.2, -21.6}
magtable[12] = {  -18.9, -19.1, -19.1, -19.1, -19.0, -19.0, -19.0, -19.0, -19.1, -19.2, -19.2, -19.3, -19.3, -19.3, -19.3, -19.2, -18.8, -18.0, -16.7, -14.8, -12.2,  -8.8,  -4.8,  -0.4,   4.2,   8.7,  12.9,  16.4,  19.3,  21.5,  23.0,  24.1,  24.7,  25.1,  25.2,  25.0,  24.7,  24.2,  23.9,  23.9,  24.5,  25.8,  27.8,  30.2,  32.7,  35.0,  36.8,  38.0,  38.5,  38.4,  37.5,  35.9,  33.5,  30.3,  26.5,  22.1,  17.4,  12.8,   8.5,   4.7,   1.3,  -1.6,  -4.2,  -6.6,  -8.8, -10.8, -12.7, -14.3, -15.8, -17.0, -17.9, -18.5, -18.9}
magtable[13] = {  -16.7, -16.8, -16.8, -16.8, -16.7, -16.8, -16.8, -16.9, -16.9, -16.9, -16.9, -16.8, -16.8, -16.7, -16.6, -16.5, -16.1, -15.4, -14.2, -12.3,  -9.7,  -6.3,  -2.3,   2.1,   6.8,  11.2,  15.2,  18.6,  21.3,  23.2,  24.5,  25.3,  25.7,  25.8,  25.5,  25.0,  24.1,  23.0,  21.8,  20.8,  20.4,  20.8,  22.2,  24.2,  26.5,  28.7,  30.4,  31.6,  32.0,  31.6,  30.6,  28.8,  26.3,  23.2,  19.7,  15.8,  11.9,   8.2,   4.9,   2.1,  -0.3,  -2.4,  -4.3,  -6.1,  -7.8,  -9.5, -11.1, -12.5, -13.8, -14.9, -15.7, -16.3, -16.7}
magtable[14] = {  -14.8, -14.9, -14.9, -14.8, -14.8, -14.8, -14.9, -15.0, -15.0, -15.0, -14.9, -14.8, -14.6, -14.5, -14.4, -14.2, -13.8, -13.1, -11.9, -10.0,  -7.4,  -4.1,  -0.1,   4.3,   8.8,  13.1,  16.9,  20.1,  22.4,  24.1,  25.1,  25.6,  25.6,  25.2,  24.6,  23.6,  22.2,  20.6,  18.7,  16.9,  15.6,  15.1,  15.7,  17.3,  19.4,  21.5,  23.4,  24.6,  25.1,  24.9,  23.9,  22.3,  20.1,  17.4,  14.3,  11.1,   7.9,   5.0,   2.5,   0.5,  -1.3,  -2.8,  -4.2,  -5.6,  -7.0,  -8.4,  -9.8, -11.1, -12.3, -13.2, -14.0, -14.5, -14.8}
magtable[15] = {  -13.3, -13.3, -13.2, -13.1, -13.0, -13.1, -13.2, -13.3, -13.4, -13.4, -13.3, -13.1, -12.9, -12.7, -12.6, -12.4, -12.0, -11.2, -10.0,  -8.1,  -5.4,  -2.1,   1.9,   6.2,  10.5,  14.5,  18.0,  20.9,  22.9,  24.2,  24.9,  24.9,  24.5,  23.7,  22.5,  21.0,  19.3,  17.3,  15.1,  12.9,  11.1,  10.0,   9.9,  10.9,  12.7,  14.7,  16.6,  18.0,  18.8,  18.8,  18.1,  16.8,  15.0,  12.7,  10.2,   7.6,   5.1,   2.8,   1.0,  -0.5,  -1.8,  -2.9,  -3.9,  -5.1,  -6.3,  -7.6,  -8.9, -10.0, -11.1, -11.9, -12.6, -13.0, -13.3}
magtable[16] = {  -12.1, -12.0, -11.8, -11.7, -11.6, -11.6, -11.7, -11.9, -12.0, -12.0, -11.9, -11.7, -11.5, -11.4, -11.2, -11.0, -10.6,  -9.8,  -8.4,  -6.4,  -3.7,  -0.4,   3.5,   7.6,  11.7,  15.5,  18.7,  21.1,  22.9,  23.8,  24.0,  23.6,  22.7,  21.4,  19.7,  17.9,  15.9,  13.9,  11.7,   9.5,   7.5,   6.2,   5.6,   6.1,   7.4,   9.2,  11.0,  12.5,  13.4,  13.7,  13.3,  12.4,  11.0,   9.2,   7.2,   5.1,   3.1,   1.4,   0.0,  -1.0,  -1.9,  -2.7,  -3.6,  -4.6,  -5.7,  -6.9,  -8.0,  -9.2, -10.1, -11.0, -11.6, -11.9, -12.1}
magtable[17] = {  -11.2, -11.1, -10.8, -10.5, -10.4, -10.4, -10.5, -10.7, -10.8, -10.8, -10.7, -10.6, -10.4, -10.3, -10.2, -10.0,  -9.5,  -8.6,  -7.2,  -5.1,  -2.3,   1.0,   4.8,   8.8,  12.7,  16.1,  19.0,  21.1,  22.4,  22.9,  22.8,  21.9,  20.5,  18.7,  16.7,  14.7,  12.7,  10.7,   8.7,   6.8,   5.0,   3.6,   2.8,   2.9,   3.8,   5.2,   6.9,   8.3,   9.3,   9.8,   9.7,   9.0,   8.0,   6.6,   5.0,   3.4,   1.9,   0.6,  -0.4,  -1.2,  -1.8,  -2.5,  -3.2,  -4.1,  -5.1,  -6.2,  -7.3,  -8.4,  -9.4, -10.2, -10.8, -11.1, -11.2}
magtable[18] = {  -10.6, -10.4, -10.1,  -9.7,  -9.5,  -9.5,  -9.6,  -9.8,  -9.9,  -9.9,  -9.9,  -9.8,  -9.7,  -9.6,  -9.5,  -9.3,  -8.7,  -7.7,  -6.2,  -4.0,  -1.1,   2.2,   5.9,   9.7,  13.3,  16.5,  19.0,  20.7,  21.6,  21.8,  21.2,  20.0,  18.2,  16.1,  13.9,  11.7,   9.8,   8.0,   6.4,   4.7,   3.2,   1.9,   1.1,   0.9,   1.5,   2.6,   4.0,   5.3,   6.3,   6.9,   7.0,   6.6,   5.8,   4.7,   3.5,   2.2,   1.1,   0.1,  -0.6,  -1.1,  -1.5,  -2.0,  -2.6,  -3.4,  -4.4,  -5.5,  -6.7,  -7.8,  -8.8,  -9.6, -10.2, -10.5, -10.6}
magtable[19] = {  -10.2, -10.0,  -9.6,  -9.3,  -9.0,  -8.9,  -9.0,  -9.2,  -9.3,  -9.4,  -9.4,  -9.3,  -9.3,  -9.2,  -9.1,  -8.8,  -8.1,  -7.0,  -5.3,  -3.0,  -0.1,   3.3,   6.9,  10.5,  13.8,  16.6,  18.8,  20.1,  20.7,  20.5,  19.6,  18.0,  16.0,  13.7,  11.4,   9.3,   7.5,   5.9,   4.5,   3.2,   1.9,   0.8,   0.0,  -0.3,   0.0,   0.9,   2.0,   3.2,   4.2,   4.8,   5.0,   4.8,   4.2,   3.4,   2.4,   1.5,   0.6,   0.0,  -0.5,  -0.8,  -1.1,  -1.4,  -1.9,  -2.7,  -3.6,  -4.7,  -5.9,  -7.1,  -8.1,  -9.0,  -9.7, -10.1, -10.2}
magtable[20] = {  -10.0,  -9.8,  -9.5,  -9.1,  -8.8,  -8.7,  -8.8,  -8.9,  -9.1,  -9.2,  -9.3,  -9.2,  -9.2,  -9.1,  -8.9,  -8.4,  -7.6,  -6.3,  -4.5,  -2.0,   0.9,   4.3,   7.8,  11.2,  14.2,  16.7,  18.4,  19.4,  19.6,  19.1,  17.9,  16.2,  14.0,  11.7,   9.4,   7.3,   5.6,   4.3,   3.1,   2.0,   0.9,   0.0,  -0.7,  -1.0,  -0.8,  -0.2,   0.8,   1.8,   2.7,   3.3,   3.6,   3.5,   3.1,   2.4,   1.7,   1.0,   0.4,   0.0,  -0.2,  -0.3,  -0.4,  -0.6,  -1.1,  -1.7,  -2.7,  -3.8,  -5.0,  -6.2,  -7.4,  -8.5,  -9.3,  -9.8, -10.0}
magtable[21] = {   -9.8,  -9.7,  -9.5,  -9.2,  -8.9,  -8.8,  -8.9,  -9.1,  -9.3,  -9.5,  -9.5,  -9.5,  -9.4,  -9.2,  -8.9,  -8.3,  -7.3,  -5.8,  -3.7,  -1.1,   1.9,   5.2,   8.6,  11.8,  14.6,  16.7,  18.1,  18.7,  18.6,  17.8,  16.4,  14.5,  12.3,  10.0,   7.8,   5.9,   4.3,   3.0,   2.0,   1.1,   0.2,  -0.6,  -1.2,  -1.5,  -1.4,  -0.9,  -0.1,   0.8,   1.6,   2.2,   2.5,   2.5,   2.2,   1.7,   1.2,   0.7,   0.4,   0.2,   0.2,   0.3,   0.3,   0.3,   0.0,  -0.6,  -1.5,  -2.6,  -3.8,  -5.2,  -6.5,  -7.8,  -8.8,  -9.5,  -9.8}
magtable[22] = {   -9.5,  -9.7,  -9.7,  -9.5,  -9.3,  -9.3,  -9.5,  -9.7,  -9.9, -10.1, -10.1, -10.1, -10.0,  -9.7,  -9.2,  -8.3,  -7.1,  -5.3,  -3.0,  -0.2,   2.9,   6.2,   9.5,  12.5,  14.9,  16.7,  17.7,  18.0,  17.6,  16.6,  15.0,  13.1,  11.0,   8.8,   6.6,   4.8,   3.3,   2.1,   1.2,   0.4,  -0.3,  -1.0,  -1.5,  -1.8,  -1.8,  -1.4,  -0.8,   0.0,   0.7,   1.3,   1.6,   1.7,   1.5,   1.2,   0.8,   0.6,   0.4,   0.5,   0.7,   0.9,   1.2,   1.3,   1.1,   0.7,  -0.1,  -1.2,  -2.5,  -3.9,  -5.4,  -6.8,  -8.1,  -9.0,  -9.5}
magtable[23] = {   -9.2,  -9.7,  -9.9,  -9.9, -10.0, -10.1, -10.3, -10.6, -10.9, -11.0, -11.1, -11.0, -10.8, -10.3,  -9.6,  -8.5,  -7.0,  -4.9,  -2.4,   0.6,   3.9,   7.2,  10.4,  13.2,  15.3,  16.8,  17.4,  17.4,  16.8,  15.6,  14.0,  12.1,  10.0,   7.8,   5.8,   4.0,   2.6,   1.5,   0.6,  -0.2,  -0.8,  -1.4,  -1.9,  -2.1,  -2.2,  -1.9,  -1.4,  -0.7,  -0.1,   0.4,   0.8,   0.9,   0.8,   0.6,   0.5,   0.4,   0.5,   0.8,   1.2,   1.7,   2.1,   2.4,   2.4,   2.1,   1.4,   0.4,  -0.9,  -2.4,  -4.0,  -5.7,  -7.1,  -8.3,  -9.2}
magtable[24] = {   -8.6,  -9.5, -10.1, -10.4, -10.8, -11.1, -11.4, -11.8, -12.1, -12.3, -12.3, -12.2, -11.8, -11.2, -10.3,  -8.9,  -7.0,  -4.7,  -1.8,   1.5,   4.9,   8.3,  11.4,  14.0,  15.9,  17.0,  17.4,  17.1,  16.2,  14.9,  13.2,  11.3,   9.3,   7.2,   5.3,   3.6,   2.1,   1.0,   0.1,  -0.6,  -1.2,  -1.8,  -2.2,  -2.5,  -2.5,  -2.3,  -1.9,  -1.4,  -0.9,  -0.5,  -0.1,   0.0,   0.0,   0.0,   0.0,   0.2,   0.5,   1.1,   1.7,   2.5,   3.2,   3.7,   3.9,   3.7,   3.1,   2.2,   0.9,  -0.7,  -2.5,  -4.3,  -6.0,  -7.5,  -8.6}
magtable[25] = {   -8.0,  -9.2, -10.2, -11.0, -11.6, -12.2, -12.7, -13.1, -13.5, -13.7, -13.7, -13.5, -13.0, -12.2, -11.1,  -9.4,  -7.2,  -4.5,  -1.2,   2.3,   6.0,   9.5,  12.5,  15.0,  16.6,  17.5,  17.6,  17.1,  16.0,  14.6,  12.8,  10.9,   8.9,   6.9,   5.0,   3.3,   1.9,   0.7,  -0.2,  -1.0,  -1.6,  -2.1,  -2.6,  -2.9,  -3.0,  -2.9,  -2.6,  -2.3,  -1.9,  -1.5,  -1.2,  -1.0,  -0.9,  -0.7,  -0.5,  -0.1,   0.6,   1.4,   2.3,   3.4,   4.3,   5.0,   5.4,   5.4,   4.9,   4.0,   2.7,   1.0,  -0.8,  -2.8,  -4.7,  -6.5,  -8.0}
magtable[26] = {   -7.2,  -8.9, -10.3, -11.4, -12.4, -13.3, -14.0, -14.6, -15.0, -15.2, -15.2, -15.0, -14.4, -13.4, -12.0, -10.0,  -7.4,  -4.3,  -0.6,   3.3,   7.2,  10.8,  13.9,  16.2,  17.6,  18.3,  18.2,  17.5,  16.3,  14.7,  12.9,  11.0,   9.0,   7.0,   5.1,   3.4,   1.8,   0.6,  -0.5,  -1.3,  -2.0,  -2.6,  -3.0,  -3.4,  -3.6,  -3.6,  -3.5,  -3.3,  -3.1,  -2.8,  -2.6,  -2.3,  -2.0,  -1.7,  -1.1,  -0.4,   0.5,   1.7,   3.0,   4.3,   5.5,   6.4,   7.0,   7.1,   6.7,   5.8,   4.5,   2.8,   0.9,  -1.2,  -3.4,  -5.4,  -7.2}
magtable[27] = {   -6.5,  -8.5, -10.3, -11.9, -13.3, -14.4, -15.4, -16.1, -16.6, -16.9, -16.9, -16.6, -15.9, -14.7, -13.0, -10.7,  -7.7,  -4.0,   0.1,   4.4,   8.7,  12.5,  15.6,  17.8,  19.1,  19.5,  19.2,  18.3,  17.0,  15.3,  13.4,  11.4,   9.4,   7.4,   5.4,   3.6,   2.0,   0.6,  -0.6,  -1.6,  -2.4,  -3.1,  -3.6,  -4.1,  -4.4,  -4.6,  -4.7,  -4.7,  -4.6,  -4.5,  -4.2,  -3.9,  -3.5,  -2.9,  -2.0,  -0.9,   0.4,   2.0,   3.6,   5.3,   6.8,   7.9,   8.6,   8.8,   8.4,   7.6,   6.2,   4.5,   2.4,   0.2,  -2.1,  -4.4,  -6.5}
magtable[28] = {   -6.0,  -8.3, -10.5, -12.4, -14.1, -15.6, -16.8, -17.8, -18.4, -18.8, -18.8, -18.4, -17.6, -16.2, -14.2, -11.4,  -7.9,  -3.7,   1.1,   6.0,  10.6,  14.6,  17.8,  19.9,  21.0,  21.3,  20.8,  19.8,  18.3,  16.5,  14.5,  12.4,  10.3,   8.2,   6.1,   4.2,   2.4,   0.8,  -0.5,  -1.7,  -2.7,  -3.6,  -4.4,  -5.0,  -5.6,  -6.0,  -6.3,  -6.5,  -6.6,  -6.5,  -6.3,  -5.9,  -5.3,  -4.4,  -3.1,  -1.6,   0.2,   2.2,   4.3,   6.3,   8.1,   9.4,  10.3,  10.5,  10.1,   9.2,   7.8,   6.0,   3.9,   1.5,  -1.0,  -3.5,  -6.0}
magtable[29] = {   -5.6,  -8.2, -10.7, -13.0, -15.1, -16.9, -18.4, -19.6, -20.4, -20.9, -21.0, -20.6, -19.6, -18.0, -15.6, -12.3,  -8.1,  -3.0,   2.5,   8.2,  13.3,  17.6,  20.7,  22.7,  23.7,  23.7,  23.1,  21.9,  20.2,  18.3,  16.2,  13.9,  11.7,   9.4,   7.2,   5.1,   3.1,   1.3,  -0.3,  -1.8,  -3.1,  -4.3,  -5.3,  -6.3,  -7.1,  -7.8,  -8.4,  -8.8,  -9.1,  -9.1,  -8.9,  -8.4,  -7.5,  -6.3,  -4.6,  -2.5,  -0.2,   2.4,   5.0,   7.4,   9.5,  11.0,  11.9,  12.2,  11.8,  10.8,   9.3,   7.4,   5.1,   2.6,  -0.1,  -2.8,  -5.6}
magtable[30] = {   -5.4,  -8.3, -11.1, -13.7, -16.2, -18.3, -20.2, -21.7, -22.8, -23.5, -23.7, -23.3, -22.3, -20.4, -17.5, -13.4,  -8.2,  -1.9,   4.9,  11.5,  17.2,  21.7,  24.8,  26.6,  27.3,  27.1,  26.2,  24.7,  22.9,  20.7,  18.4,  16.0,  13.6,  11.1,   8.7,   6.3,   4.1,   2.0,   0.0,  -1.8,  -3.5,  -5.1,  -6.5,  -7.8,  -9.0, -10.1, -11.0, -11.7, -12.2, -12.3, -12.1, -11.5, -10.3,  -8.7,  -6.5,  -3.8,  -0.8,   2.4,   5.6,   8.5,  10.9,  12.6,  13.5,  13.8,  13.3,  12.3,  10.6,   8.6,   6.2,   3.5,   0.6,  -2.4,  -5.4}
magtable[31] = {   -5.3,  -8.6, -11.7, -14.7, -17.4, -20.0, -22.2, -24.1, -25.6, -26.6, -27.1, -26.9, -25.8, -23.6, -20.1, -14.9,  -8.1,   0.1,   8.8,  16.8,  23.2,  27.8,  30.6,  32.0,  32.2,  31.6,  30.2,  28.5,  26.3,  23.9,  21.3,  18.7,  16.0,  13.2,  10.5,   7.9,   5.3,   2.8,   0.4,  -1.9,  -4.0,  -6.0,  -7.9,  -9.7, -11.4, -12.8, -14.1, -15.1, -15.8, -16.2, -16.0, -15.3, -14.0, -11.9,  -9.2,  -5.8,  -2.0,   2.1,   6.0,   9.4,  12.2,  14.1,  15.1,  15.3,  14.8,  13.6,  11.8,   9.6,   7.0,   4.1,   1.1,  -2.1,  -5.3}
magtable[32] = {   -5.6,  -9.0, -12.5, -15.8, -18.9, -21.9, -24.6, -26.9, -28.9, -30.4, -31.3, -31.4, -30.5, -28.1, -23.8, -17.0,  -7.4,   4.3,  16.0,  25.6,  32.4,  36.5,  38.6,  39.1,  38.6,  37.3,  35.4,  33.1,  30.5,  27.7,  24.8,  21.8,  18.7,  15.7,  12.6,   9.6,   6.6,   3.7,   0.8,  -1.9,  -4.6,  -7.1,  -9.5, -11.8, -14.0, -15.9, -17.6, -19.0, -20.1, -20.7, -20.7, -20.1, -18.7, -16.3, -13.0,  -8.9,  -4.1,   1.0,   5.8,  10.0,  13.2,  15.4,  16.5,  16.6,  16.0,  14.6,  12.7,  10.3,   7.6,   4.5,   1.3,  -2.1,  -5.6}
magtable[33] = {   -6.2,  -9.9, -13.6, -17.2, -20.8, -24.2, -27.3, -30.3, -32.9, -35.0, -36.6, -37.4, -36.9, -34.6, -29.4, -19.6,  -4.0,  14.8,  30.7,  40.8,  46.2,  48.5,  48.9,  48.0,  46.3,  44.1,  41.4,  38.5,  35.3,  32.0,  28.7,  25.2,  21.7,  18.3,  14.8,  11.3,   7.9,   4.5,   1.2,  -2.0,  -5.2,  -8.3, -11.2, -14.0, -16.7, -19.1, -21.3, -23.2, -24.8, -25.8, -26.2, -25.9, -24.7, -22.4, -18.8, -14.0,  -8.1,  -1.8,   4.2,   9.4,  13.3,  15.8,  17.1,  17.3,  16.6,  15.1,  13.0,  10.5,   7.6,   4.4,   1.0,  -2.5,  -6.2}
magtable[34] = {   -7.7, -11.6, -15.6, -19.5, -23.4, -27.2, -30.9, -34.5, -37.8, -40.9, -43.4, -45.3, -46.0, -44.4, -38.2, -20.6,  15.3,  46.0,  59.0,  63.3,  64.0,  62.8,  60.7,  58.0,  54.8,  51.5,  47.9,  44.2,  40.4,  36.5,  32.6,  28.7,  24.8,  20.9,  16.9,  13.0,   9.2,   5.4,   1.6,  -2.1,  -5.7,  -9.3, -12.7, -16.0, -19.2, -22.1, -24.9, -27.4, -29.5, -31.2, -32.3, -32.7, -32.2, -30.6, -27.5, -22.7, -16.4,  -8.9,  -1.4,   5.3,  10.4,  13.8,  15.6,  16.0,  15.4,  14.0,  12.0,   9.4,   6.5,   3.2,  -0.3,  -3.9,  -7.7}
magtable[35] = {  -12.4, -16.4, -20.5, -24.7, -29.0, -33.3, -37.7, -42.2, -46.6, -51.1, -55.7, -60.4, -65.2, -70.5, -79.4, 110.4, 100.9,  95.5,  90.7,  86.0,  81.4,  76.9,  72.4,  67.9,  63.4,  58.9,  54.5,  50.0,  45.6,  41.1,  36.7,  32.3,  28.0,  23.6,  19.3,  15.0,  10.8,   6.6,   2.5,  -1.6,  -5.6,  -9.6, -13.4, -17.2, -20.8, -24.3, -27.6, -30.7, -33.5, -36.0, -38.1, -39.6, -40.5, -40.4, -39.2, -36.5, -32.1, -25.8, -18.1, -10.1,  -3.0,   2.5,   6.0,   7.9,   8.4,   7.7,   6.3,   4.1,   1.5,  -1.6,  -5.0,  -8.6, -12.4}
magtable[36] = {  -40.7, -44.8, -49.5, -54.9, -61.1, -68.2, -76.7, -87.0, -99.9,-116.4,-137.1,-160.2, 177.9, 159.6, 145.2, 133.7, 124.0, 115.7, 108.3, 101.5,  95.1,  89.1,  83.4,  77.9,  72.5,  67.2,  62.1,  57.0,  52.0,  47.1,  42.2,  37.4,  32.7,  28.0,  23.3,  18.7,  14.2,   9.6,   5.2,   0.8,  -3.6,  -7.9, -12.1, -16.2, -20.3, -24.3, -28.1, -31.8, -35.4, -38.8, -42.0, -45.0, -47.6, -49.9, -51.8, -53.2, -53.9, -53.9, -53.1, -51.4, -48.8, -45.5, -41.8, -38.1, -34.8, -32.4, -30.9, -30.4, -30.9, -32.3, -34.4, -37.2, -40.7}
magtable[37] = { -152.0,-157.0,-162.0,-167.0,-172.0,-177.0, 178.0, 173.0, 168.0, 163.0, 158.0, 153.0, 148.0, 143.0, 138.0, 133.0, 128.0, 123.0, 118.0, 113.0, 108.0, 103.0,  98.0,  93.0,  88.0,  83.0,  78.0,  73.0,  68.0,  63.0,  58.0,  53.0,  48.0,  43.0,  38.0,  33.0,  28.0,  23.0,  18.0,  13.0,   8.0,   3.0,  -2.0,  -7.0, -12.0, -17.0, -22.0, -27.0, -32.0, -37.0, -42.0, -47.0, -52.0, -57.0, -62.0, -67.0, -72.0, -77.0, -82.0, -87.0, -92.0, -97.0,-102.0,-107.0,-112.0,-117.0,-122.0,-127.0,-132.0,-137.0,-142.0,-147.0,-152.0}



-- handle keyboad input
function onKeyDown(comp, char, key)
--input flightplan name
if char == 8 then
local g = string.find(input, ' NOT FOUND')
if g then
input = string.sub(input, 1, g)
end
input = string.sub(input, 1, -2)
elseif char == 13 then
notLoaded = true
else 
input = string.format("%s%s",input, string.char(char))
end
 --print('key down', char, key)
 return true
end

-- handle keyboad input
function onKeyUp(comp, char, key)
return true
end


function readplan()
local filename = string.format("%s%s%s","Output/FMS plans/", input, ".fms")
active = 1
table1 = {}
currtype = 99
totaldist = 0
local lat2 = 0
local lon2 = 0
num = 0
local dist = 0
local course1 = 0
local course2 = 0
local types = 0
local ident = 0
local freq = ""
local alt = 0
local lat1 = 0
local lon1 = 0
local course = 0
local file = io.open(filename, "r")
local lat = 0
local lon = 0
local SE = 0
local length = 0
local diff = 0
local tableline = ""
local nas_c = 0
local nas_b = 0
local start = 0
--local has_DME = 0
days = get(datedays) + 1
month = 1
local a = 0
local b = 0
local magvar = 0

-- if file exist - read it and fill the variables with new values
if file then
while true do
	local line = file:read("*line")
	if line == nil then break end
	a = string.find(line, '%d')
	if a ~= nil then
		types = tonumber(string.sub(line, a, a+1))
		a = string.find(line, '[%a%d]', a+2)

		if a ~= nil and types ~= 0 then
		b = string.find(line, " ", a+1)
		if b ~= nil then

			ident = string.sub(line, a, b-1)

				a = string.find(line, '%d', b)
							if a ~= nil then
				b = string.find(line, " ", a+1)
				alt = tonumber(string.sub(line, a, b-1))
				a = string.find(line, '%d', b)
				if string.sub(line, a-1, a-1) == "-" then
				a = a-1
				end
				b = string.find(line, " ", a+1)
				lat1 = tonumber(string.sub(line, a, b-1)) * math.pi / 180 

				a = string.find(line, '%d', b)
				if string.sub(line, a-1, a-1) == "-" then
				a = a-1
				end
				lon1 = tonumber(string.sub(line, a, -1)) * math.pi / -180 
				--all data has been read, now we calculate a bit
				num = num + 1
				if lat2 ~= 0 then
--magnetic variation!
local lo_lat = math.floor(lat2 * 180 / math.pi / 5) * 5
local lo_lon = math.floor(lon2 * -180 / math.pi / 5) * 5


local lat_index = ( lo_lat + 90 ) / 5 + 1
local lon_index = ( lo_lon + 180 ) / 5 + 1

		  
local var1 = magtable[lat_index  ][lon_index  ]
local var2 = magtable[lat_index+1][lon_index  ]
local var3 = magtable[lat_index  ][lon_index+1]
local var4 = magtable[lat_index+1][lon_index+1]

local var12 = ((lat2 * 180 / math.pi - lo_lat)*(var2-var1))/(lo_lat + 5 - lo_lat) + var1
local var34 = ((lat2 * 180 / math.pi - lo_lat)*(var4-var3))/(lo_lat + 5 - lo_lat) + var3
magvar = ((lon2 * -180 / math.pi - lo_lon)*(var34-var12))/(lo_lon + 5 - lo_lon) + var12
--print(var1, var2, var3, var4, lo_lat, lo_lon, magvar)


				dist = (2 * math.asin(math.sqrt((math.sin((lat1 - lat2) / 2)) ^ 2 + math.cos(lat1) * math.cos(lat2) * (math.sin((lon1 - lon2) / 2)) ^ 2)))
				course1 = math.mod(math.atan2(math.sin(lon2 - lon1) * math.cos(lat1), math.cos(lat2) * math.sin(lat1) - math.sin(lat2) * math.cos(lat1) * math.cos(lon2 - lon1)), 2 * math.pi)

if course1 < 0 then
course1 = course1 + 2 * math.pi
end
				diff = (course1 - course2) * 180 / math.pi
				
				
				
				
				end
				totaldist = totaldist + dist * 10.8 / math.pi * 1852

				dist = string.format("%." .. (1 or 0) .. "f", dist * 10.8 / math.pi * 1852)
							--this function gives the string always the same length!
	length = string.len(dist)
	while length < 5 do
		dist = string.format("%s%s", " ", dist)
		length = length + 1
end
	
	
while length < 9 do
		dist = string.format("%s%s",dist, " ")
		length = length + 1
end
course = course1 * 180 / math.pi + magvar
if course > 360 then 
course = course -360 
elseif course < 0 then
course = course + 360
end
course = string.format("%." .. (0 or 0) .. "f", course)
		course = string.format("%03s",course)
			length = string.len(course)
while length < 7 do
		course = string.format("%s%s",course, " ")
		length = length + 1
end
	
lat = lat1 * 180 / math.pi

if string.find(lat, "-") == 1 then
SE = 1
lat = string.sub(lat, 2)
else SE = 0
end
lat = string.format ("%02d*%02d`%02d", math.floor(lat), (lat - math.floor(lat)) * 60, (((lat - math.floor(lat)) * 60) - math.floor(((lat - math.floor(lat)) * 60)))*60)
if SE == 1 then
lat = string.format ("%s%s", "S", lat)
else
lat = string.format ("%s%s", "N", lat)
end
	length = string.len(lat)
while length < 11 do
		lat = string.format("%s%s",lat, " ")
		length = length + 1
end
lon = lon1 * 180 / math.pi
if string.find(lon, "-") == 1 then
SE = 1
lon = string.sub(lon, 2)
else SE = 0
end
lon = string.format ("%03d*%02d`%02d", math.floor(lon), (lon - math.floor(lon)) * 60, (((lon - math.floor(lon)) * 60) - math.floor(((lon - math.floor(lon)) * 60)))*60)
if SE == 1 then
lon = string.format ("%s%s", "E", lon)
else
lon = string.format ("%s%s", "W", lon)
end
	
if diff > 180 then
diff = diff - 360
elseif diff  < -180 then
diff = diff + 360
end
if diff > 165 or diff < -165 then
start = 0
nas_c = 0
nas_b = 0
else
				--calculate NAS (Bank:15, TAS:450)

start = ( (125) ^ 2 / ( 9.81 * math.tan ( math.pi / 12 ) ) ) * math.tan ( math.abs(diff) * math.pi / 180 / 2) 
nas_c = -start * math.cos (math.abs(diff) * math.pi / 180)
nas_b = -start * math.sin(-diff * math.pi / 180)
--print(diff, start, nas_c, nas_b)
				end
				--for a VOR or NDB, we need to frequency
				freq = ""
				if types == 2 or types == 3 then

---				local file = io.open("Resources/default data/earth_nav.dat", "r")
---             local file = io.open("/mnt/home/oleg_tr/AN-24_X-Plane 10/Resources/default data/earth_nav.dat", "r")
                local file = io.open("Resources/default data/earth_nav_10.dat", "r")


if file then

while true do
	local line2 = file:read("*line")

	if line2 == nil then break end
	local c = 0
c = string.find(line2, ident)
		if c == 54 then
			if tonumber(string.sub(line2, 1, 1)) == types then
				local lat3 = tonumber(string.sub(line2, 3, 14)) * math.pi / 180 
				local lon3 = tonumber(string.sub(line2, 16, 28)) * math.pi / -180 
				local dist3 = (2 * math.asin(math.sqrt((math.sin((lat1 - lat3) / 2)) ^ 2 + math.cos(lat1) * math.cos(lat3) * (math.sin((lon1 - lon3) / 2)) ^ 2)))
				dist3 = dist3 * 10.8 / math.pi * 1852
					--		print(line2, dist3)

				if dist3 < 10 then
								freq = string.sub(line2, 37, 41)
								if types == 3 then
								freq = string.format("%s.%s", string.sub(freq, 1, 3), string.sub(freq, 4, 5))
--								local d = 0
--								d = string.find(line2, "DME")
--if d ~= nil then 
--has_DME = 1 
--else
--								d = string.find(line2, "VORTAC")
--end
--if d ~= nil then has_DME = 1 end
end
end
end
end

	--			a = string.find(line, '%d', b)
end
file:close()
else print ("Can't read nav.dat!")
end

				end
				if ( types == 2 or types == 3 ) and freq == "" then
				types = 11
				end
				
							length = string.len(freq)
while length < 10 do
		freq = string.format("%s%s",freq, " ")
		length = length + 1
end
			length = string.len(ident)
while length < 6 do
		ident = string.format("%s%s",ident, " ")
		length = length + 1
end
				tableline = { types, ident, freq, course, dist, lat, lon, start, nas_c, nas_b}
--				print( types, ident, freq, course, dist, lat, lon, start, nas_c, nas_b)
				table.insert(table1,tableline)
				if alt > alt2 then
				alt2 = alt
				end
				lat2 = lat1
				lon2 = lon1
				course2 = course1
				end
			end
		end
	end
end


local monthdays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

while days > monthdays[month] do
days = days - monthdays[month]
month = month + 1
end
datetext = string.format("%s.%s", days, month)
totaldist2 = totaldist
local ETE = string.format("%01d:%02d",  math.floor(totaldist / 450), ((totaldist / 450) - math.floor(totaldist / 450)) * 60)
disttext = string.format("%." .. (1 or 0) .. "f", totaldist)
	length = string.len(disttext)
while length < 7 do
		disttext = string.format("%s%s", " ", disttext)
		length = length + 1
end
disttext = string.format("%s           %s", disttext, ETE)
file:close()
else print ("flightplan couldn't be read")
input = string.format("%s %s",input, "NOT FOUND")
disttext = ""
datetext = ""
pagetext = ""
end
page = 0
display()
end


function display()
--this displays all the waypoints!
line1 = ""
line2 = ""
line3 = ""
line4 = ""
line5 = ""
line6 = ""
line7 = ""
line8 = ""
line9 = ""
line10 = ""
line11 = ""
line12 = ""
line13 = ""
line14 = ""
line15 = ""
if num >= page * 15 + 1 then
tableline = table1[page * 15 + 1]
line1 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 2 then
tableline = table1[page * 15 + 2]
line2 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 3 then
tableline = table1[page * 15 + 3]
line3 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 4 then
tableline = table1[page * 15 + 4]
line4 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 5 then
tableline = table1[page * 15 + 5]
line5 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 6 then
tableline = table1[page * 15 + 6]
line6 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 7 then
tableline = table1[page * 15 + 7]
line7 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 8 then
tableline = table1[page * 15 + 8]
line8 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 9 then
tableline = table1[page * 15 + 9]
line9 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 10 then
tableline = table1[page * 15 + 10]
line10 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 11 then
tableline = table1[page * 15 + 11]
line11 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 12 then
tableline = table1[page * 15 + 12]
line12 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 13 then
tableline = table1[page * 15 + 13]
line13 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 14 then
tableline = table1[page * 15 + 14]
line14 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num >= page * 15 + 15 then
tableline = table1[page * 15 + 15]
line15 = string.format("%s %s %s %s %s %s", tableline[2], tableline[3], tableline[4], tableline[5], tableline[6], tableline[7])
end
if num > 0 then
pagetext = string.format("%d~  ~%d", page + 1, math.floor((num - 1) / 15) + 1)
end
end

--###############################################################################################


function update()
if notLoaded then
notLoaded = false
	readplan()
end

--information for Boris
--################################ CONSTRUCTION AHEAD
if active2 ~= active then


local currline = table1[active]
if currline ~= nil then
if active2 == active + 1 then
totaldist2 = totaldist2 + currdist
end
currtype = tonumber(currline[1])
currcourse = tonumber(currline[4])
currdist = tonumber(currline[5])
prev = 0
local nasline = table1[active + 1]
nasdist = 0
nasN = 0
nasE = 0
nasN = currline[9]
nasE = currline[10]
somecourse = "000"
if active2 == active - 1 then
totaldist2 = totaldist2 - currdist
end
if nasline ~= nil then
nasdist = nasline[8]
somecourse = string.sub(nasline[4], 1, 3)
end

if handle_nas == 1 and get(agl) > 20 then

if wait == 0 and active2 ~= 1 then
set(dst1, nasN / 1000)
set(dst2, nasE / 1000)
--print("I'm setting", nasE, nasN)
--if wait is ~= 0, then we either overflew a station or we switched to the next waypoint manually
else
set(dst1, 0)
set(dst2, 0)
end
end


--we calculate the optimal radio settings!

DME_possible1 = 1
DME_possible2 = 1

--local way_dist = 0

local prevactive = active - 1
local prevline = 0
prevtype = 0
prevdist = currdist
prevcourse = 0

local nextactive = active
local nextline = 0
nexttype = 0
nextdist = 0
nextcourse = 0


--find the previous VOR or NDB on our route
while true do
prevline = table1[prevactive]
if prevline == nil then break end
prevtype = tonumber(prevline[1])
if prevtype == 2 or prevtype == 3 then break end
prevdist = prevdist + tonumber(prevline[5])
prevcourse = tonumber(prevline[4])
diff = prevcourse - currcourse
if diff < -180 then 
diff = diff + 360 
elseif diff > 180 then 
diff = diff - 360 
end
if diff > 1 or diff < -1 then
DME_possible1 = 0
end
prevactive = prevactive - 1
end



--find the next VOR or NDB on our route

while true do
nextline = table1[nextactive]
if nextline == nil then break end
nexttype = tonumber(nextline[1])
if nexttype == 2 or nexttype == 3 then break end
nextactive = nextactive + 1
end
--if nexttype == 2 or nexttype == 3 then
if nexttype == 3 then

local searchback = nextactive
--for i,v in ipairs(nextline) do print(i,v) end

--Let's see if we can use the next VOR do determine our position
while searchback ~= active do
local searchline = table1[searchback]
nextdist = nextdist + tonumber(searchline[5])
nextcourse = tonumber(searchline[4])
diff = nextcourse - currcourse
if diff < -180 then 
diff = diff + 360 
elseif diff > 180 then 
diff = diff - 360 
end
if ( diff > 1 or diff < -1 ) and searchback ~= nextactive then
DME_possible2 = 0
end
searchback = searchback - 1
end
end


if prevtype ~= 3 then
DME_possible1 = 0
end

if nexttype ~= 3 then
DME_possible2 = 0
end

--the freq for the radios
prevfreq = 0

if prevtype == 2 or prevtype == 3 then
prevfreq = tonumber(prevline[3])
end

nextfreq = 0

if nexttype == 2 or nexttype == 3 then
nextfreq = tonumber(nextline[3])
nextcourse = tonumber(nextline[4])
end

currident = currline[2]
local z = string.find(currident, " ")
currident = string.sub(currident, 1, z-1)


searchline = table1[prevactive + 1]
if searchline ~= nil then
prevcourse = tonumber(searchline[4])
end


active2 = active
else
currtype = 99
end
end
--################################
if currtype ~= 99 then
--Boris handles the flighplan
if handle_fplan == 1 then
modes = "VFR"

--print(DME_possible, get(DME_receive), get(DME_freq), DME_frequency)
--first waypoint is an airport?
if currtype == 1 and active == 1 and get(agl) > 20 then
active = active + 1
--print("3", nasdist)

--back on the ground?
elseif currtype == 1 and active ~= 1 and get(agl) < 20 then
active = active + 1
--print("4", currtype)

--*****If we got GPS, we use that
elseif ( get(GPS_visible) == 0 or get(Garmin_visible) == 0 ) and currtype ~= 1 and get(GPS_name) == currident then

modes = "GPS"
diff = get(GPS_dist) * 1.852 - nasdist / 1000
if diff2 == 0 then
diff2 = diff
end
if ( diff > diff2 and diff < 10 ) or diff < 0 then
active = active + 1
diff = 0
--print("5", get(GPS_name), currident)
end

--*****No GPS? Then we use the DME, first case: DME of the next waypoint
elseif DME_possible2 == 1 and get(DME_DME) == 1 and get(DME_freq) == nextfreq * 100 and currtype ~= 1 and wait == 0 then
modes = "DME"
--diff = get(DME_dist) * 1.852 + nasdist / 1000 + get(agl) / 1000 - way_dist
diff = math.sqrt((get(DME_dist) * 1.852) ^ 2 - ( get(agl) / 1000 ) ^ 2 ) - nasdist / 1000 - nextdist  
if diff2 == 0 then
diff2 = diff
end

if ( diff > diff2 and diff < 10 ) or diff < 0 then
active = active + 1
--print("1.0", nasdist, nextdist, diff, diff2)
--wait = 100
diff = 0
end
--*****Second DME case: DME of the previous waypoint
elseif DME_possible1 == 1 and get(DME_DME) == 1 and get(DME_freq) == prevfreq * 100 and currtype ~= 1 and wait == 0 then
modes = "DME"
--diff = get(DME_dist) * 1.852 + nasdist / 1000 + get(agl) / 1000 - way_dist
diff = prevdist - nasdist / 1000 - math.sqrt((get(DME_dist) * 1.852) ^ 2 - ( get(agl) / 1000 ) ^ 2 )
if diff2 == 0 then
diff2 = diff
end

if ( diff > diff2 and diff < 10 ) or diff < 0 then
active = active + 1
--print("1.1", nasdist, prevdist, diff, diff2)
--wait = 100
diff = 0
end
--*****No DME? But we can still use the needles to see if we overfly a VOR or NDB
elseif currtype == 3 and get(nav1_freq) == nextfreq * 100 and get(nav1_flag) ~= 0 then
modes = "VOR"
local x = currcourse - get(nav1_bear)
if x < -180 then x = x + 360 end
if x < -90 or x > 90 then
active = active + 1
wait = 100
--print("99", nasdist)
end
elseif currtype == 3 and get(nav2_freq) == nextfreq * 100 and get(nav2_flag) ~= 0 then
modes = "VOR"
local x = currcourse - get(nav2_bear)
if x < -180 then x = x + 360 end
if x < -90 or x > 90 then
active = active + 1
wait = 100
--print("99", nasdist)
end
elseif currtype == 2 and get(adf1_freq) == nextfreq and get(adf1_meter) > 0.5 and wait == 0 then
modes = "NDB"
local x = currcourse - get(adf1_bear)
if x < -180 then x = x + 360 end
if x < -90 or x > 90 then
active = active + 1
wait = 100
--print("99", nasdist)
end
elseif currtype == 2 and get(adf2_freq) == nextfreq and get(adf2_meter) > 0.5 and wait == 0 then
modes = "NDB"
local x = currcourse - get(adf2_bear)
if x < -180 then x = x + 360 end
if x < -90 or x > 90 then
active = active + 1
wait = 100
--print("99", nasdist)
end
--***** Nothing? The last rescue is the NAS-1
elseif get(counter) == 1 and currtype ~= 1 then
modes = "NAS-1"

diff = currdist - nasdist / 1000 - get(dst1)

if diff < 0 then
active = active + 1
--print("2",get(dst1), nasdist)
--wait = 100
diff = 0
end
end
--Boris' notes
notes1 = ""
if get(agl) > 20 then

if modes == "VOR" or modes == "NDB" then
if get(counter) == 1 then
diff = currdist - nasdist / 1000 - get(dst1)
local dist2 = string.format("%." .. (1 or 0) .. "f", totaldist2 + diff)
local dist = string.format("%." .. (1 or 0) .. "f", diff)
local ETA = string.format("%01d:%02d",  math.floor((totaldist2 + diff) / 450), (((totaldist2 + diff) / 450) - math.floor((totaldist2 + diff) / 450)) * 60)
notes1 = string.format("Turn to %s in ca. %s km (%s), DTG: %s km, ETA: %s H", somecourse, dist, modes, dist2, ETA)
else
notes1 = string.format("Turn to %s after overflying the station(%s)", somecourse, modes)
end
elseif currtype == 1 then
notes1 = ""
elseif modes == "VFR" then
notes1 = "I'm lost, fly visually (VFR)"
else
local dist2 = string.format("%." .. (1 or 0) .. "f", totaldist2 + diff)
local dist = string.format("%." .. (1 or 0) .. "f", diff)
local ETA = string.format("%01d:%02d",  math.floor((totaldist2 + diff) / 450), (((totaldist2 + diff) / 450) - math.floor((totaldist2 + diff) / 450)) * 60)
notes1 = string.format("Turn to %s in %s km (%s), DTG: %s km, ETA: %s H", somecourse, dist, modes, dist2, ETA)
end
end
diff2 = diff
end
--debugtext = string.format("prev:%d next:%d DME:%d diff:%d DME_pos1:%d DME_pos2:%d", prevdist, nextdist, get(DME_dist) * 1.852, diff, DME_possible1, DME_possible2)


--print(get(dst1))
--print(debugtext)

--Boris handles the GPS
if handle_gps == 1 and get(GPS_name) ~= currident and get(agl) > 20 then
commandOnce(clearcomm)
if currtype == 1 then
commandOnce(aptcomm)
elseif currtype == 2 then
commandOnce(ndbcomm)
elseif currtype == 3 then
commandOnce(vorcomm)
elseif currtype == 11 then
commandOnce(fixcomm)
end
local q = 0
local length = string.len(currident)
while q < length do
q = q + 1
local letter = string.sub(currident, q, q)
if letter == "A" then
commandOnce(acomm)
elseif letter == "B" then
commandOnce(bcomm)
elseif letter == "B" then
commandOnce(bcomm)
elseif letter == "C" then
commandOnce(ccomm)
elseif letter == "D" then
commandOnce(dcomm)
elseif letter == "E" then
commandOnce(ecomm)
elseif letter == "F" then
commandOnce(fcomm)
elseif letter == "G" then
commandOnce(gcomm)
elseif letter == "H" then
commandOnce(hcomm)
elseif letter == "I" then
commandOnce(icomm)
elseif letter == "J" then
commandOnce(jcomm)
elseif letter == "K" then
commandOnce(kcomm)
elseif letter == "L" then
commandOnce(lcomm)
elseif letter == "M" then
commandOnce(mcomm)
elseif letter == "N" then
commandOnce(ncomm)
elseif letter == "O" then
commandOnce(ocomm)
elseif letter == "P" then
commandOnce(pcomm)
elseif letter == "Q" then
commandOnce(qcomm)
elseif letter == "R" then
commandOnce(rcomm)
elseif letter == "S" then
commandOnce(scomm)
elseif letter == "T" then
commandOnce(tcomm)
elseif letter == "U" then
commandOnce(ucomm)
elseif letter == "V" then
commandOnce(vcomm)
elseif letter == "W" then
commandOnce(wcomm)
elseif letter == "X" then
commandOnce(xcomm)
elseif letter == "Y" then
commandOnce(ycomm)
elseif letter == "Z" then
commandOnce(zcomm)
elseif letter == "0" then
commandOnce(n0comm)
elseif letter == "1" then
commandOnce(n1comm)
elseif letter == "2" then
commandOnce(n2comm)
elseif letter == "3" then
commandOnce(n3comm)
elseif letter == "4" then
commandOnce(n4comm)
elseif letter == "5" then
commandOnce(n5comm)
elseif letter == "6" then
commandOnce(n6comm)
elseif letter == "7" then
commandOnce(n7comm)
elseif letter == "8" then
commandOnce(n8comm)
elseif letter == "9" then
commandOnce(n9comm)
end
end
end

--Boris handles the radios 
if handle_radio == 1 and get(agl) > 20 then
if nextfreq ~= nextfreq2 then
nextfreq2 = nextfreq
setradio = 1
end

if setradio == 1 then
if prevtype == 2 then
set(adf2_freq, prevfreq)
set(ark2_mode, 1)
setadf2 = 0
elseif prevtype == 3 then
set(nav2_freq, prevfreq * 100)
set(nav2_course, prevcourse)
set(DME_sw, 1)
set(curs_mp2_sw, 1)
else
end

if nexttype == 2 then
set(adf1_freq, nextfreq)
set(ark1_mode, 1)
set(ark_vor, 0)
setadf1 = 0
elseif nexttype == 3 then
set(nav1_freq, nextfreq * 100)
set(nav1_course, nextcourse)
set(DME_sw, 1)
set(curs_mp1_sw, 1)
set(ark_vor, 1)
end


setdme = 0
setkppm = 0
setradio = 0
wait = 10
end

if wait == 0 then
--comp2 is better than comp1!
if setadf1 == 0 and get(adf1_meter) > 0.5 then
set(ark1_mode, 4)
setadf1 = 1
end
if setadf2 == 0 and get(adf2_meter) > 0.5 then
set(ark2_mode, 4)
setadf2 = 1
end

--set the KPPM to Nav2
if setkppm == 0 then
if get(nav2_flag) ~= 0 and prevtype == 3 then
set(nav_select, 4)
end
setkppm = 1
end

--set the DME to Nav2
if setdme == 0 then
if get(nav2_DME) == 1 and prevtype == 3 then
set(DME_freq, prevfreq * 100)
wait = 10
end
setdme = 1
end


--set the KPPM to Nav1 if available
if get(nav1_flag) ~= 0 and nexttype == 3 and get(nav1_freq) == nextfreq * 100 and setkppm == 1 then
if DME_possible2 == 1 and DME_possible1 == 0 and get(nav2_freq) == prevfreq * 100 then
if get(nav2_flag) == 0 then
setkppm = 2
end
else
setkppm = 2
end
end



if setkppm == 2 then
set(nav_select, 2)
setkppm = 3
end



--set the DME to Nav1 if available
if get(nav1_DME) == 1 and nexttype == 3 and get(nav1_freq) == nextfreq * 100 and setdme == 1 then
if DME_possible2 == 1 and DME_possible1 == 0 and get(DME_freq) == prevfreq * 100 then
if get(nav2_DME) == 0 then
setdme = 2
end
else
setdme = 2
end
end



if setdme == 2 then
set(DME_freq, nextfreq * 100)
wait = 100
setdme = 3
end
end

end

--Boris handles the NAS-1 (should be working)

if handle_nas == 1 and get(agl) > 20 then
set(map_angle, currcourse)
--if you want to correct nas 1, then enter the code here!

if get(rls_power_cc) < 1.5 then
set(DISS, 0)
else
set(DISS, 1)
end

if get(DISS) == 0 then
set(windspeed, get(act_windspeed) * 3.6)
set(winddelta, get(act_winddelta) - get(map_angle))

end

set(counter, 1)
set(mode1, 3)

if get(water) == 1 then
set(mode2, 0)
else
set(mode2, 1)
end

elseif handle_nas == 1 then
set(mode1, 1)

end



if handle_ap == 1 and get(agl) > 20 then
if get(alt3) >= alt2 then
set(ap_kv, 1)
alt2 = 100000
elseif alt2 == 100000 then
set(ap_kv, 0)
alt2 = 100001
end


if get(GPS_visible) == 0 or get(Garmin_visible) == 0 then
local correction = get(deg2) - get(deg1) - get(GPS_course)
while correction < -180 do
correction = correction + 360
end
while correction > 180 do
correction = correction - 360
end
set(ap_curse, correction)
else
local correction = 0
--set(gyro_curse, get(magpsi))

if get(dst2) < - 1.5 then
correction = get(gyro_curse) - currcourse + get(deg2) - get(deg1) - 30 
elseif get(dst2) > 1.5  then
correction = get(gyro_curse) - currcourse + get(deg2) - get(deg1) + 30 
else
correction = get(gyro_curse) - currcourse + get(deg2) - get(deg1) + get(dst2) * 20
end
while correction < -180 do
correction = correction + 360
end
while correction > 180 do
correction = correction - 360
end

set(ap_curse, correction)
end
end
end
--These things are done every frame for sure!
--warning! Never ever enter "apcheat" as a flightplan name or your computer will explode!
if input == "apcheat" then
handle_ap = 0

end
if get(GPS_visible) == 1 and get(Garmin_visible) == 1 then
handle_gps = 0
end


if wait > 0 then
wait = wait - 1
end
end


	
components = {
	texture {
		image = get(bg),
		position = {0, 0, size[1], size[2]},

	},
--stroke
	clickable {
		position = {30, 395, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 1 and active <= page * 15 + 2 and active >= page * 15 + 1
		end,
		onMouseClick = function()
		if active == page * 15 + 2 then active = page * 15 + 1
		else active = page * 15 + 2 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked1),
		position = {30, 395, 650, 20},
		visible = function()
		return active > page * 15 + 1
		end,
		},
	clickable {
		position = {30, 375, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 2 and active <= page * 15 + 3 and active >= page * 15 + 2
		end,
		onMouseClick = function()
		if active == page * 15 + 3 then active = page * 15 + 2
		else active = page * 15 + 3 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked2),
		position = {30, 375, 650, 20},
		visible = function()
		return active > page * 15 + 2
		end,
		},
	clickable {
		position = {30, 355, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 3 and active <= page * 15 + 4 and active >= page * 15 + 3
		end,
		onMouseClick = function()
		if active == page * 15 + 4 then active = page * 15 + 3
		else active = page * 15 + 4 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked3),
		position = {30, 355, 650, 20},
		visible = function()
		return active > page * 15 + 3
		end,
		},
	clickable {
		position = {30, 335, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 4 and active <= page * 15 + 5 and active >= page * 15 + 4
		end,
		onMouseClick = function()
		if active == page * 15 + 5 then active = page * 15 + 4
		else active = page * 15 + 5 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked1),
		position = {30, 335, 650, 20},
		visible = function()
		return active > page * 15 + 4
		end,
		},
		clickable {
		position = {30, 315, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 5 and active <= page * 15 + 6 and active >= page * 15 + 5
		end,
		onMouseClick = function()
		if active == page * 15 + 6 then active = page * 15 + 5
		else active = page * 15 + 6 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked2),
		position = {30, 315, 650, 20},
		visible = function()
		return active > page * 15 + 5
		end,
		},
			clickable {
		position = {30, 295, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 6 and active <= page * 15 + 7 and active >= page * 15 + 6
		end,
		onMouseClick = function()
		if active == page * 15 + 7 then active = page * 15 + 6
		else active = page * 15 + 7 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked3),
		position = {30, 295, 650, 20},
		visible = function()
		return active > page * 15 + 6
		end,
		},
	clickable {
		position = {30, 275, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 7 and active <= page * 15 + 8 and active >= page * 15 + 7
		end,
		onMouseClick = function()
		if active == page * 15 + 8 then active = page * 15 + 7
		else active = page * 15 + 8 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked1),
		position = {30, 275, 650, 20},
		visible = function()
		return active > page * 15 + 7
		end,
		},
	clickable {
		position = {30, 255, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 8 and active <= page * 15 + 9 and active >= page * 15 + 8
		end,
		onMouseClick = function()
		if active == page * 15 + 9 then active = page * 15 + 8
		else active = page * 15 + 9 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked2),
		position = {30, 255, 650, 20},
		visible = function()
		return active > page * 15 + 8
		end,
		},
	clickable {
		position = {30, 235, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 9 and active <= page * 15 + 10 and active >= page * 15 + 9
		end,
		onMouseClick = function()
		if active == page * 15 + 10 then active = page * 15 + 9
		else active = page * 15 + 10 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked3),
		position = {30, 235, 650, 20},
		visible = function()
		return active > page * 15 + 9
		end,
		},
	clickable {
		position = {30, 215, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 10 and active <= page * 15 + 11 and active >= page * 15 + 10
		end,
		onMouseClick = function()
		if active == page * 15 + 11 then active = page * 15 + 10
		else active = page * 15 + 11 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked1),
		position = {30, 215, 650, 20},
		visible = function()
		return active > page * 15 + 10
		end,
		},
	clickable {
		position = {30, 195, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 11 and active <= page * 15 + 12 and active >= page * 15 + 11
		end,
		onMouseClick = function()
		if active == page * 15 + 12 then active = page * 15 + 11
		else active = page * 15 + 12 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked2),
		position = {30, 195, 650, 20},
		visible = function()
		return active > page * 15 + 11
		end,
		},
		clickable {
		position = {30, 175, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 12 and active <= page * 15 + 13 and active >= page * 15 + 12
		end,
		onMouseClick = function()
		if active == page * 15 + 13 then active = page * 15 + 12
		else active = page * 15 + 13 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked3),
		position = {30, 175, 650, 20},
		visible = function()
		return active > page * 15 + 12
		end,
		},
	clickable {
		position = {30, 155, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 13 and active <= page * 15 + 14 and active >= page * 15 + 13
		end,
		onMouseClick = function()
		if active == page * 15 + 14 then active = page * 15 + 13
		else active = page * 15 + 14 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked1),
		position = {30, 155, 650, 20},
		visible = function()
		return active > page * 15 + 13
		end,
		},
		clickable {
		position = {30, 135, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 14 and active <= page * 15 + 15 and active >= page * 15 + 14
		end,
		onMouseClick = function()
		if active == page * 15 + 15 then active = page * 15 + 14
		else active = page * 15 + 15 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked2),
		position = {30, 135, 650, 20},
		visible = function()
		return active > page * 15 + 14
		end,
		},
	clickable {
		position = {30, 115, 70, 20 },
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return num >= page * 15 + 15 and active <= page * 15 + 16 and active >= page * 15 + 15
		end,
		onMouseClick = function()
		if active == page * 15 + 16 then active = page * 15 + 15
		else active = page * 15 + 16 end
		wait = 10
		return true
		end 
	},	

	texture {
		image = get(stroked3),
		position = {30, 115, 650, 20},
		visible = function()
		return active > page * 15 + 15
		end,
		},

		clickable {
		position = {130, 15, 22, 22},
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		onMouseClick = function()
		if handle_fplan == 1 then handle_fplan = 0
		else handle_fplan = 1 end
		return true
		end 
	},	

	texture {
		image = get(deselected),
		position = {130, 15, 22, 22},
		visible = function()
		return handle_fplan == 0
		end,
		},		
	
		clickable {
		position = {241, 15, 22, 22},
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		onMouseClick = function()
		if handle_radio == 1 then handle_radio = 0
		else 
		setradio = 1
		handle_radio = 1 
		end
		return true
		end 
	},	

	texture {
		image = get(deselected),
		position = {241, 15, 22, 22},
		visible = function()
		return handle_radio == 0
		end,
		},	
			clickable {
		position = {332, 15, 22, 22},
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		if handle_nas == 1 then handle_nas = 0
		else handle_nas = 1 end
		return true
		end 
	},	

	texture {
		image = get(deselected),
		position = {332, 15, 22, 22},
		visible = function()
		return handle_nas == 0
		end,
		},	
		
		clickable {
		position = {428, 15, 22, 22},
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return get(GPS_visible) == 0 or get(Garmin_visible) == 0
		end,
		onMouseClick = function()
		if handle_gps == 1 then handle_gps = 0
		else handle_gps = 1 end
		return true
		end 
	},	

	texture {
		image = get(deselected),
		position = {428, 15, 22, 22},
		visible = function()
		return handle_gps == 0
		end,
		},		
				texture {
		image = get(white),
		position = {390, 15, 72, 23},
		visible = function()
		return get(GPS_visible) == 1 and get(Garmin_visible) == 1
		end,
		},	
		
		
				texture {
		image = get(APselected),
		position = {500, 15, 22, 22},
		visible = function()
		return handle_ap ~= 2
		end,
		},	
		
		texture {
		image = get(deselected),
		position = {500, 15, 22, 22},
		visible = function()
		return handle_ap == 0
		end,
		},	

				clickable {
		position = {500, 15, 22, 22},
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return handle_ap ~= 2
		end,
		onMouseClick = function()
		if handle_ap == 1 then handle_ap = 0
		else handle_ap = 1 end
		return true
		end 
	},		

						clickable {
		position = {615, 18, 14, 14},
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		visible = function()
		return page ~= 0
		end,
		onMouseClick = function()
page = page - 1
display()
		return true
		end 
	},	
		texture {
		image = get(white),
		position = {615, 18, 14, 14},
		visible = function()
		return page == 0
		end,
		},	
	
							clickable {
		position = {680, 18, 14, 14},
	
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		visible = function()
		return page < math.floor((num - 1) / 15)
		end,
		onMouseClick = function()
page = page + 1
display()
		return true
		end 
	},		
			texture {
		image = get(white),
		position = {680, 18, 14, 14},
		visible = function()
		return page >= math.floor((num - 1) / 15)
		end,
		},		
		
		texture {
		image = get(stroked3),
		position = {78, 462, 150, 9},
		visible = function()
		return focused["value"]
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
		set(fplan_subpanel, 0 )
		return true
		end
	},	
}


function draw()
drawAll(components)
drawText(font, 30, 400, line1, 1.0, 1.0, 1.0)
drawText(font, 30, 380, line2, 1.0, 1.0, 1.0)
drawText(font, 30, 360, line3, 1.0, 1.0, 1.0)
drawText(font, 30, 340, line4, 1.0, 1.0, 1.0)
drawText(font, 30, 320, line5, 1.0, 1.0, 1.0)
drawText(font, 30, 300, line6, 1.0, 1.0, 1.0)
drawText(font, 30, 280, line7, 1.0, 1.0, 1.0)
drawText(font, 30, 260, line8, 1.0, 1.0, 1.0)
drawText(font, 30, 240, line9, 1.0, 1.0, 1.0)
drawText(font, 30, 220, line10, 1.0, 1.0, 1.0)
drawText(font, 30, 200, line11, 1.0, 1.0, 1.0)
drawText(font, 30, 180, line12, 1.0, 1.0, 1.0)
drawText(font, 30, 160, line13, 1.0, 1.0, 1.0)
drawText(font, 30, 140, line14, 1.0, 1.0, 1.0)
drawText(font, 30, 120, line15, 1.0, 1.0, 1.0)

drawText(font, 78, 471, input, 1.0, 1.0, 1.0)
drawText(font, 597, 471, datetext, 1.0, 1.0, 1.0)
drawText(font, 327, 93, disttext, 1.0, 1.0, 1.0)
drawText(font2, 100, 67, notes1, 1.0, 1.0, 1.0)

drawText(font, 630, 18, pagetext, 1.0, 1.0, 1.0)

end
