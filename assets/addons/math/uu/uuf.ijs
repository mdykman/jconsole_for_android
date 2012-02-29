NB. == FORMULAS ==
NB. syntax of a line:
NB.	<formula>                  [<units>] <desc>
NB.	<formula> : <dependencies> [<units>] <desc>
NB.	<formula> ; <dependencies> [<units>] <desc>

NB. Put ';' in place of ':' to require evaluation in the given units only.
NB. This must be done if the formula is UNITS-SPECIFIC, eg it contains
NB. a numeric value standing for a physical (dimensioned) constant,
NB. which would not be valid for vars expressed in different units.
NB. >>> Examples of UNITS-SPECIFIC formulas:
NB.  a*3.281 ; a(m) [ft]  (3.281 DEMANDS a in [m], result in [ft])
NB.  u+(t*9.812865328) ; u(m/s),t(s) [m/s]  (const has units [ft/s^2])
NB. Using ':' declares that the formula is valid for vars in ANY units.
NB. This can be guaranteed by supplying as vars any physical constants.
NB. Use of PI, PI2, etc, does not make a formula UNITS-SPECIFIC,
NB. because such constants are dimensionless.
NB. >>> Examples of UNITS-FREE formulas:
NB.  abs a [/]
NB.  a/b : a(m),b(s) [m/s] (units used only to check compatibility)
NB.  u+(t*f) : u(m/s),t(s),f(m/s^2) [m/s] (f will be converted as needed)
NB. If units not specified for a given var (say a) then a(*) assumed.

cocurrent 'uu'

UUF=: cmx noun define
a/b^2 : a(kg),b(m)	[/]	body mass index
((-b)+sqrt((b^2)-4*a*c))%2*a : a(/),b(/),c(/)	[/]	quadratic root[+]
((-b)-sqrt((b^2)-4*a*c))%2*a : a(/),b(/),c(/)	[/]	quadratic root[-]
(v^2)/r : v(m/s),r(m)		[m/s^2]	centripetal acceleration
(v-u)/t : v(m/s),u(m/s),t(s)	[m/s^2]	acceleration to final speed
a*3.281 ; a(m)		[ft]	convert m to ft <<<<< TEST ONLY
u+(t*32.1944) ; u(ft/s),t(s)	[ft/s]	final speed <<<<< TEST ONLY
u+(t*9.812865328) ; u(m/s),t(s)	[m/s]	final speed <<<<< TEST ONLY
u+(t*f) : u(m/s),t(s),f(m/s/s)	[m/s]	final speed <<<<< TEST ONLY
sin a ; a(rad)		[/]	sine
cos a ; a(rad)		[/]	cosine
tan a ; a(rad)		[/]	tangent
arcsin u ; u(/)		[rad]	arc sine
arccos u ; u(/)		[rad]	arc cosine
arctan u ; u(/)		[rad]	arc tangent
sinh u ; u(/)		[/]	hyperbolic sine
cosh u ; u(/)		[/]	hyperbolic cosine
tanh u ; u(/)		[/]	hyperbolic tangent
arcsinh u ; u(/)	[/]	inverse hyperbolic sine
arccosh u ; u(/)	[/]	inverse hyperbolic cosine
arctanh u ; u(/)	[/]	inverse hyperbolic tangent
PI*r*r : r(m)		[m^2]	area of circle
PI*a*b : a(m),b(m)	[m^2]	area of ellipse
PI4*r^2 : r(m)		[m^2]	surface area of sphere
h*b/2 : b(m),h(m)	[m^2]	area of triangle
a*RT3/2 : a(m)		[m]	hgt of equilateral triangle
a*a*RT3/4 : a(m)	[m^2]	area of equilateral triangle
a*a*1.5*RT3 : a(m)	[m^2]	area of regular hexagon
2*a*a*(1+RT2) : a(m)	[m^2]	area of regular octagon
2*PIb3*(r^3)*(v^2)*d : r(m),v(m/s),d(/)	[Mton.TNT]	asteroid impact energy; d=rel.density; CHECK THIS
400.0*(p^0.67) ; p(Mton.TNT)	[m^2]	area of destruction; CHECK THIS
m*(v^2)/2 : m(kg),v(m/s)	[J]	kinetic energy
m*f*h : m(kg),f(m/s^2),h(m)	[J]	potential energy
9.812865328*m*h : m(kg),h(m)	[J]	potential energy; earth surface
PI2*r : r(m)		[m]	circumference of circle
73.3*m^0.75 ; m(kg)	[kcal/d]	basal metabolic rate
0.01*m^0.7 ; m(kg)	[kg]	mammalian brain weight; not ape
0.04*m^0.66 ; m(kg)	[kg]	ape brain weight
11.8*m^0.2 ; m(kg)	[yr]	life span; not human or bird
28.3*m^0.19 ; m(kg)	[yr]	life span; bird
0.0058*m^0.98 ; m(kg)	[kg]	weight of heart
0.0113*m^0.98 ; m(kg)	[kg]	weight of lung
0.085*m^0.66 ; m(kg)	[kg]	weight of brain
7.69*m^1.04 ; m(kg)	[ml]	tidal volume
56.7*m^1.03 ; m(kg)	[ml]	vital capacity
65.6*m^1.02 ; m(kg)	[ml]	blood volume
0.4*m ; m(kg)		[kg]	muscle mass
0.0608*m^1.08 ; m(kg)	[kg]	skeletal mass
241*m^-0.25 ; m(kg)	[/min]	heart rate
17.4*m^0.25 ; m(kg)	[s]	blood circulation time
53.5*m^-0.26 ; m(kg)	[/min]	respiratory rate
1.94*m^0.79 ; m(kg)	[ml/s]	oxygen consumption
5.59*m^0.75 ; m(kg)	[/]	glucose turnover
i choice(a,b) : i(/),a(*),b(*)	[*]	choice i of 2 values
i*exp(d*r) : i(/),d(/),r(/)	[/]	residue; decay; CHECK THIS
i*exp(x*t) : i(mol),x(/),t(s)	[mol]	radioactive decay; CHECK THIS
i*exp(x*d) : i(cd),x(/),d(m)	[cd]	Lambert's law; CHECK THIS
M*L*L/12 : M(kg),L(m)		[kg m^2]	1st moment; slender rod; axis thru centre
M*L*L/3 : M(kg),L(m)		[kg m^2]	1st moment; slender rod; axis thru end
M*W times W/3 : M(kg),W(m)		[kg m^2]	1st moment; rectangular plane; axis along edge
M*((L^2)+(W^2))div 12 : M(kg),L(m),W(m)	[kg m^2]	1st moment; rectangular plane; axis thru centre
M*((I^2)+(J^2))div 2 : M(kg),I(m),J(m)	[kg m^2]	1st moment; cylinder; hollow
M*R*R/2 : M(kg),R(m)	[kg m^2]	1st moment; cylinder; solid
M*R*R : M(kg),R(m)	[kg m^2]	1st moment; cylinder; thin walled hollow
M*L*L : M(kg),L(m)	[kg m^2]	1st moment; point mass on weightless rod
M*R*R*2/3 : M(kg),R(m)	[kg m^2]	1st moment; sphere; thin walled hollow
M*R*R*2/5 : M(kg),R(m)	[kg m^2]	1st moment; sphere; solid
M*R*R/4 : M(kg),R(m)	[kg m^2]	1st moment; disk
G*M/d^2 : G(G),M(ea.mass),d(eq.r)	[m/s^2]	gravitational attraction; earth; estimate
G*M/d^2 : G(G),M(kg),d(m)		[m/s^2]	gravitational attraction;unit
PI2*sqrt(a/g) : g(grav),a(m)  [s]	earth orbital period
PI2*sqrt((a^3)/(G*M)) : G(G),M(kg),a(m)	[s]	orbital period; small body; a=semimajor axis
PI2*sqrt((a^3)/(G*(M+N))) : G(G),M(kg),N(kg),a(m)	[s]	orbital period; two bodies; a=semimajor axis
-(G*M)/(2*a) : G(G),M(kg),a(m)		[MJ/kg]	specific orbital energy (vis-viva); elliptical orbit
x/t : x(m),t(s)				[m/s]	average speed
u+(f*t) : u(m/s),t(s),f(m/s^2)		[m/s]	final speed
(u*t)+(0.5*f*t^2) : u(m/s),t(s),f(m/s^2)	[m]	distance covered
T-(T mod 3600) : T(s)			[h]	hours portion
(T mod 3600)-(T mod 60) : T(s)		[min]	minutes portion
T mod 60 : T(s)				[s]	seconds portion
d^3 : d(m)		[m^3]	volume of cube
4*PIb3*r^3 : r(m)	[m^3]	volume of sphere
PIb3*h*r^2 : r(m),h(m)	[m^3]	volume of cone
PI*h*r^2 : r(m),h(m)	[m^3]	volume of cylinder
)