load 'gui/droidwd'  NB. should use require except debug

cocurrent 'base'

coinsert 'wdbase'
droidwd_run=: run_me

run_me=: 3 : 0
wd FORM
wd 'set tabs tab1 tab2'
wd 'creategroup tabs'
wd FORM1
wd FORM2
wd 'creategroup'
wd 'pshow'
)

FORM=: 0 : 0
pc form; pn demo;
menupop "&Options";
menu view "&View Definition" "" "" "";
menusep;
menu clip "&Clip" "" "" "";
menusep;
menu saveeps "&Save EPS" "" "" "";
menusep;
menu savepdf "&Save PDF" "" "" "";
menusep;
menu slides "&Slide Show" "" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&2D";
menu MJGRAPHICS "J Plot" "" "" "";
menusep;
menu MLINE "Line Plots" "" "" "";
menusep;
menu MLINES "Line Sampler" "" "" "";
menu MLINESTYLE "Line Options" "" "" "";
menu MLINE2Y "Line Second Y Axes" "" "" "";
menu MLINEPATTERN "Line Patterns" "" "" "";
menusep;
menu MAREA "Area" "" "" "";
menu MDOT "Dot" "" "" "";
menu MMARKER "Marker" "" "" "";
menu MSYMBOL "Symbol" "" "" "";
menu MPOLAR "Polar" "" "" "";
menu MSTICK "Stick" "" "" "";
menusep;
menu MBAR "Bar" "" "" "";
menu MBARS "Bar Sampler" "" "" "";
menu MHIST "Histogram" "" "" "";
menusep;
menu MERRORBAR "Error Bar" "" "" "";
menu MHILO "HiLo" "" "" "";
menusep;
menu MPIE "Pie" "" "" "";
menu MPIEM "Pie Multi" "" "" "";
menu MRADAR "Radar" "" "" "";
menusep;
menu MPOLY "Poly" "" "" "";
menusep;
menu MCONTOUR "Contour" "" "" "";
menu MDENSITY "Density" "" "" "";
menupopz;
menupop "&3D";
menu MLINE3D "Line" "" "" "";
menu MSTICK3D "Stick" "" "" "";
menu MWIRE "Wire" "" "" "";
menusep;
menu MSURFACE "Surface" "" "" "";
menu MSURFACEREV "Surface of Revolution" "" "" "";
menusep;
menu MSURFACES "Surface Sampler" "" "" "";
menusep;
menu MSPHERE "Sphere" "" "" "";
menusep;
menu MSOLID "Solids" "" "" "";
menu MSTELLATE "Stellates" "" "" "";
menupopz;
menupop "&Multi";
menu MMULTI1 "Simple Multiplot" "" "" "";
menusep;
menu MMULTI2 "Y Grouped Multiplot" "" "" "";
menusep;
menu MMULTI3 "XY Grouped Multiplot" "" "" "";
menusep;
menu MMULTI4 "Mixed Multiplot" "" "" "";
menupopz;
menupop "&Styles";
menu MSAMPLER "Plot Sampler" "" "" "";
menu MRULE "Rule Sampler" "" "" "";
menu MKEYS "Key Styles" "" "" "";
menusep;
menu MCOLOR1 "Style 1" "" "" "";
menu MCOLOR2 "Style 2" "" "" "";
menu MCOLOR3 "Style 3" "" "" "";
menusep;
menu MLOGS "Log Examples" "" "" "";
menupopz;
menupop "&Gallery";
menu MLINE1 "Line 1" "" "" "";
menu MLINE2 "Line 2" "" "" "";
menusep;
menu MCURVEFIT "Curve Fitting" "" "" "";
menu MLEGENDRE "Legendre" "" "" "";
menu MPRIMERACE "Prime Race" "" "" "";
menu MCONTOUR1 "Contour vs Density" "" "" "";
menusep;
menu MPAT1 "Patterns 1" "" "" "";
menu MPAT2 "Patterns 2" "" "" "";
menusep;
menu MWIRES "Wire" "" "" "";
menu MGAMMA "Gamma Function" "" "" "";
menu MDRUM "Drum" "" "" "";
menu MSURFACE1 "Surface" "" "" "";
menupopz;
menupop "&Help";
menu next "&F12 Next" "" "" "";
menu prev "&Shift F12 Previous" "" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
xywh 0 0 40 10; cc e1 edit;
xywh 5 10 40 10; cc b1 button;cn "dog";
xywh 5 25 200 200;cc tabs tab;
rem ;
)

FORM1=: 0 : 0
pc form1; pn dumy;
xywh 0 0 40 10; cc e2 edit;
xywh 5 10 40 10; cc b2 button;cn "cat";
rem ;
)

FORM2=: 0 : 0
pc form2; pn dummy;
xywh 0 0 40 10; cc e3 edit;
xywh 5 10 40 10; cc b3 button;cn "mouse";
rem ;
)

form_b1_button=: 3 : 0
smoutput wdq
)

start_droidwd coname''
