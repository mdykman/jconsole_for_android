NB. == CONSTANTS ==
NB. syntax of a line: {<nn>} <value> <unitv> [<units>] <description>
NB.	<value> can be calculated (but use '/' for division, not '%').
NB.	<unitv> are the (elsewhere defined) units attached to <value>.
NB.	<units> are the nominal units, which are DEFINED by this line.
NB.	<description> is what should appear in the ttable.
NB.	-a final '!' in <description> means "persistent hold",
NB.	--but '!' should not appear below:
NB.	--it is added by TABULA to appended lines.
NB.
NB.	mks units (and SI-units) use 'kg' not 'g' as fundamental unit.
NB.	This is built-into uu.ijs in verb: umake, which creates noun: mks
NB.	Noun: mks is a list of the primitive SI units (=fundamental units)
NB.	WARNING: The fundamental unit of mass in SI units is not [g] but [kg].
NB.	This means that scaleunits_cal_ gives [g] and [kg] special treatment.
NB.	The first 11 lines of UUC define fundamental units in terms of themselves.
NB.	They are not "real" definitions: their conversion factor will always be 1. 
NB.	They serve here as appendable lines for the sake of completeness.
NB.
NB.	Temperature scales: '1 F.dgr' and '1 C.dgr' are RANGES, not TEMPERATURES.
NB.	--e.g '1 C.dgr' is equivalent to a rise in temperature of 1 K
NB.	--but '1 degC' is equivalent to a temperature (absol) of 274.16 K
NB.	Temperatures in [degC] [degF] [Celsius] [Centigrade] and [Fahrenheit]
NB.	have their converted values decremented at display-time, to deduct the
NB.	absolute temperature of their zero-points.

cocurrent 'uu'

UUC=: cmx 0 : 0
1 m	[m]	fundamental unit - metre (distance)
1 kg	[kg]	fundamental unit - kilogramme (mass)
1 s	[s]	fundamental unit - second (time)
1 A	[A]	fundamental unit - Ampere (electric current)
1 K	[K]	fundamental unit - Kelvin (temperature)
1 cd	[cd]	fundamental unit - candela (light intensity)
1 mol	[mol]	fundamental unit - mole (amount of matter)
1 rad	[rad]	fundamental unit - radian (angle)
1 eur	[eur]	fundamental unit - euro (currency)
1 /	[/]	fundamental unit - (dimensionless)
1 *	[*]	fundamental unit - (matches any units)
0.001 kg	[g]	gram (based on kg)
0.01 /	[%]	Percentage
1 *	[!]	YES-NO
1 /s	[Hz]	Frequency; hertz
1 Hz	[midi]	"midi" number
1 Hz	[note]	Musical note
1 kg m/s/s	[N]	Force; newtons
1 N/m/m	[Pa]	Pressure; pascals
1 N m	[J]	Energy; joules
1 J/s	[W]	Power; watts
1 A s	[C]	Charge; coulombs
1 J/C	[V]	Potential; volts
1 C/V	[F]	Capacitance; farads
1 V/A	[Ohm]	Resistance; Ohms
1 /Ohm	[S]	Conductance; Siemens
1 V s	[Wb]	Flux; Webers
1 Wb/m/m	[T]	Flux density; Teslas
1 Wb/A	[H]	Inductance; Henrys
1 cd m s	[lm]	Luminous flux; lumens
1 lm/m/m	[lx]	Illumination; lux
1e_6 m	[mu]	micron; micrometre
1e_10 m	[Ang]	Angstrom-unit
1e3 kg	[t]	tonne; metric
1e4 m^2	[ha]	hectares
4840 yd^2	[acre]	acres
0.25 acre	[rd]	roods
1e_3 m^3	[l]	litre
1 m/s	[v.si]	unit velocity
1 m/s^2	[ac.si]	unit acceleration; SI
9.812865328 m/s^2	[grav]	acceleration; gravity
6.67428e_11 N m^2/kg^2	[G]	gravitational constant
299792458 m/s [c]	speed of light in free space
1p1 /	[PI]	pi
2p1 rad	[cyc]	cycle
1 cyc	[circ]	circle
0.5 cyc	[semicirc]	semicircle
0.25 cyc	[rt.angle]	right-angle
1 cyc	[rev]	revolution
1/360 cyc	[deg]	degree of arc
1/60 deg	[amin]	minute of arc
1/60 amin	[asec]	second of arc
1 cyc/s	[r.p.s]	rev per sec
1 cyc/min	[r.p.m]	rev per min
1 cyc/h	[r.p.h]	rev per hour
1.5 eur	[gbp]	UK pounds
0.01 gbp	[p]	UK penny
0.9 eur	[usd]	US dollars
0.01 usd	[cent]	US cent
1.60705 gbp/m^3	[cost.ws]	cost of water+sewerage - Yorkshire Water
0.1659 gbp/kWh	[cost.ned]	cost of npower electricity - day units
0.0331 gbp/kWh	[cost.nen]	cost of npower electricity - night units
0.0258 gbp/kWh	[cost.neh]	cost of npower electricity - heat units
997 kg/m^3	[dens.w]	density of pure water
789 kg/m^3	[dens.alc]	density of alcohol (ethanol)
0.789 /	[sg.alc]	SG of alcohol (ethanol)
1.3e_4 /	[sg.air]	SG of air at surface
22.5 /	[sg.Ir]	SG of iridium
22.4 /	[sg.Os]	SG of osmium
21.4 /	[sg.Pt]	SG of platinum
21.0 /	[sg.Rh]	SG of rhenium
20.4 /	[sg.Np]	SG of neptunium
19.8 /	[sg.Pu]	SG of plutonium
19.3 /	[sg.Au]	SG of gold
19.3 /	[sg.Tg]	SG of tungsten
18.9 /	[sg.U]	SG of uranium
13.53 /	[sg.Hg]	SG of mercury
11.4 /	[sg.Pb]	SG of lead
7.86 /	[sg.Fe]	SG of iron
0.04214 J	[ft.pdl]	foot-poundal
1.356 J	[ft.lbf]	foot-pound
4.184 J	[cal]	gram-calorie
1 kcal	[Cal]	Calorie; diet
4.1855 J	[cal.15]	calories at 15degC
4.1868 J	[cal.IT]	calories I.T
1.055e3 J	[Btu]	British thermal units
1e5 Btu	[therm]	therms
4184 J	[g.TNT]	TNT explosive power (metric)
4.184e9 J	[t.TNT]	TNT explosive power (metric)
1 t.TNT ton/t	[ton.TNT]	TNT explosive power (avdp)
1/2240 ton.TNT	[lb.TNT]	TNT explosive power (avdp)
6e13 J	[Hiroshima]	Hiroshima bomb
1e_7 J	[erg]	erg
3.6 kJ	[Wh]	watt-hour
1.602176565e_19 J	[eV]	electron-volt
1 J/s	[W]	watt
745.7 W	[hp]	horsepower
30 MJ/kg	[ener.alc]	energy density by mass of ethanol
35.2e6 J/l	[J/l]	energy density by volume of gasoline
9.0 kcal/g	[ener.fat]	energy content of fat
0.3 J/cm^2	[av.sunl]	energy; avg sunlight
1e7 kcal	[toe]	energy; tonne of oil equiv
1/1181 toe	[loe]	energy; litre of oil equiv
159 loe	[boe]	energy; barrel of oil equiv
1e_5 N	[dyn]	dyne
0.138255 N	[pdl]	poundal
4.44822 N	[lbf]	pound-force
9.96402e3 N	[tonf]	ton-force
9.80665e_3 N	[gf]	gram-force
373.16 K	[boil.w]	Water boils; Kelvin
273.16 K	[frez.w]	Water freezes; Kelvin
5/9 K	[F.dgr]	temperature range
5/9 K	[degF]	temperature
5/9 K	[Fahrenheit] temperature
1 K	[C.dgr]	temperature range
1 K	[degC]	temperature
1 K	[Celsius]	temperature
1 K	[Centigrade]	temperature
1 kcal/kg/K [sht.w]	Specific heat of water
0.0254 m	[in]	inch
12 in	[ft]	feet
36 in	[yd]	yard
22 yd	[ch]	chain
220 yd	[fu]	furlong
1760 yd	[mi]	mile
1852 m	[naut]	nautical mile
9.454e15 m	[li.yr]	light year
3.26 li.yr	[parsec]	parsec
149.6e6 km	[au]	astronomical unit
0.0002778 m/s	[m/h]	metre-per-hour
0.4470 m/s	[mi/h]	mile/hour
0.4470 m/s	[mph]	mile per hour
0.3048 m/s	[ft/sec]	feet/sec
0.3048 m/s	[fps]	feet per sec
0.5148 m/s	[knot]	knot
28.3495 g	[oz]	ounce; avdp
31.1035 g	[oz.troy]	ounce; troy
1/480 oz.troy [gr.troy]	grain; troy
16 oz	[lb]	pound; avdp
14 lb	[st]	stone; avdp
112 lb	[cwt]	hundredweight; avdp
2240 lb	[ton]	ton; avdp
1.01605e3 kg [ton]	ton; avdp
14.5939 kg	[slug]	slug
1 t	[dwt]	deadweight-ton
1 ton	[t.long]	long-tonne
1 t	[ton.m]	metric ton
60 lb	[bu.wheat]	bushel; wheat; USA
48 lb	[bu.barley]	bushel; barley; USA
32 lb	[bu.oats]	bushel; oats; USA
56 lb	[bu.rye]	bushel; rye; USA
3400 kg	[elephant]	standard African elephant
1.660430e_27 kg	[a.u]	atomic unit of mass
1e5 Pa	[bar]	atmospheric pressure; bars
1.0133e5 Pa [atm]	atmosphere
133.3e3 Pa	[torr]	gas pressure
1 torr	[mm.Hg]	gas pressure; mm of mercury
6.895e3 Pa	[psi]	pound per square inch
107.3e3 Pa	[tsf]	ton per square foot
1e_3 /	[ppt]	part per thousand
1e_6 /	[ppm]	part per million
1e_9 /	[ppb]	part per billion; USA
1e3 /	[thou]	thousand
1 s	[sec]	second
60 s	[min]	minute
3600 s	[h]	hour
24*3600 s	[d]	day
30.4375 d	[mo]	average month
28 d	[lun.mo]	lunar month
29.5 d	[lun]	lunation
28 d	[mo.feb]	28-day month
29 d	[mo.leap]	29-day month
30 d	[mo.nov]	30-day month
31 d	[mo.dec]	31-day month
365.25 d	[yr]	year
1 yr	[y]	year
1 yr	[a]	year ; annus
1 yr	[Jul.yr]	Julian year
365.2564 d	[sider.yr]	sidereal year
365 d	[common.yr]	common year
366 d	[leap.yr]	leap year
10 yr	[decade]	decade
100 yr	[century]	century
1 ft^3	[cu.ft]	cubic foot
1 mi^3	[cu.mi]	cubic mile
2.832e10 m^3	[Tcf]	trillion cubic feet; USA
4.5461e_3 m^3	[gal.Imp]	gallon; Imperial
1 gal.Imp	[gal]		gallon; Imperial
1/8 gal.Imp	[pt.Imp]	pint; Imperial
1/20 pt.Imp	[fl.oz.Imp]	fluid oz; Imperial
3.7854e_3 m^3	[gal.USA]	gallon; USA
1/8 gal.USA	[pt.USA]	fluid pint; USA
1/16 pt.USA	[fl.oz.USA]	fluid ounce; USA
7 ml	[dess.spoon]	dessert spoon
25 ml	[shot.glass]	shot glass
2 gal.Imp	[bucket]	bucketful
0.159 m^3	[barrel.oil]	barrel; petroleum
1181 l	[oil.t]		vol of tonne of petroleum
2.241e_2 m^3/mol	[molv.0]	molar volume at 0 degC
2.447e_2 m^3/mol	[molv.25]	molar volume at 25 degC
6.022e23 /mol	[Avogadro]	Avogadro constant
0.5 pt.USA		[cup.USA]	cup; USA
1/16 cup.USA	[tbl.USA]	tablespoon; USA
1/3 tbl.USA	[tsp.USA]	teaspoon; USA
1/2 tsp.USA	[barsp.USA]	barspoon; USA
1/2 pt.Imp		[cup.BS]	British Standard Cup
1/4 pt.Imp		[cup.UK]	teacupful; UK
1/2 fl.oz.Imp	[tbl.UK]	tablespoon; UK
1/2 tbl.UK		[dsp.UK]	dessertspoon; UK
1/4 tbl.UK		[tsp.UK]	teaspoon;UK
6378163 m	[eq.r]	equatorial radius of earth
6356177 m	[polar.r]	polar radius of earth
40074000 m	[eq.c]	equatorial circumference of earth
39942000 m	[polar.c]	polar circumference of earth
800 m	[h.cont]	mean elevation of continents
3800 m	[h.ocean]	mean depth of oceans
97 %	[pc.w]	% of liquid water in oceans
510.1e6 km^2	[ea.area]	total earth surface
361.3e6 km^2	[oc.area]	total ocean surface
70.8 %	[pc.ocean]	percent ocean of earth surface
148.8e6 km^2	[land.a]	total land surface
133.0e6 km^2	[fland.a]	total ice-free land surface
88.0e6 km^2	[pland.a]	total productive land
3.9e15 km^3	[ea.vol]	volume of earth
5000 K	[ei.temp]	internal temperature of earth
5.518 /	[ea.dens]	mean density of earth
6.0e24 kg	[ea.mass]	mass of earth
5.2e21 kg	[ocean.mass]	mass of oceans
2.9e19 kg	[ice.mass]	mass of icecaps & glaciers
1.3e17 kg	[lsw.mass]	mass of lakes & streams
5.2e18 kg	[atmo.mass]	mass of atmosphere
5.0e15 kg	[bio.mass]	wet mass; all life
3.95e18 kg	[N.mass]	mass of nitrogen in atmosphere
35900 km	[geo.surf]	geostationary orbit; surface
42200 km	[geo.cent]	geostationary orbit; centre
149.6e6 km	[ea.sun]	mean distance; earth-sun
3.84e8 m	[ea.moon]	mean distance; earth-moon
7.4e22 kg	[moon.mass]	mass of moon
708.733 h	[moon.lun]	lunation period of moon
27.322 d	[moon.sid]	sidereal period of moon
3.3e5 ea.mass [sun.mass]	mass of sun
109 eq.r	[sun.r]	radius of sun
7.0e8 t	[H.sun]	sun's helium burn input
6.95e8 t	[He.sun]	sun's helium burn output
27 d	[rot.sun]	axial rotation of sun
2e8 yr	[gx.sun]	sun's galaxy orbit period
6e3 K	[Ts.sun]	temperature of sun surface
1.5e7 K	[Ti.sun]	temperature of sun interior
5 /cm^3	[d.solw]	density of solar wind
500 km/s	[v.solw]	speed of solar wind
1.622 m/s^2 [moon.g]	moon gravity unit
3.711 m/s^2 [mars.g]	mars gravity unit
1.674920e_27 kg	[neut.mass]	mass of neutron
1.672614e_27 kg	[prot.mass]	mass of proton
9.109558e_31 kg	[elect.mass]	mass of electron
28.96 g/mol	[mwt.air]	molecular weight of air
32 g/mol	[mwt.oxy]	molecular weight of oxygen
28 g/mol	[mwt.nitr]	molecular weight of nitrogen
1 /s	[Bq]	radioactivity; becquerel
3.7e10 Bq	[Ci]	radioactivity; curie
1 J/kg	[Gy]	absorbed dose; gray
1 J/kg	[Sv]	dose equivalent; sievert
1 m Pa s	[cP]	dynamic viscosity; cpoise
100 cP	[P]	dynamic viscosity; poise
1 cm^2/s	[cSt]	kinematic viscosity; cstoke
100 cSt	[St]	kinematic viscosity; stoke
331 m/s	[snd.air]	speed of sound in dry air
1500 m/s	[snd.sea]	speed of sound in ocean/approx
11.2 km/s	[ea.esc]	earth escape velocity
350 ppm	[p.S]	est sulphur content of gasoline
170 kg	[wt.human]	weight of typical man
1.9 m	[ht.human]	height of typical man
1 cal/cm^2	[langley]	langley
1.381e_23 J/K	[Boltzmann]	Boltzmann constant
6.62606957e_34 J s	[Planck]	Planck constant
8.314 J/K/mol	[gas.c]	gas constant
9.649e4 C/mol	[Faraday]	Faraday constant
)
