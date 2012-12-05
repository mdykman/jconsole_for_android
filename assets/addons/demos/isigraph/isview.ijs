NB. Isigraph viewer

require 'droidwd gtkwd wdclass viewmat'

coclass 'jigdemo'
coinsert 'jgl2 wdbase jisigraph'
droidwd_run=: isdemo

require '~addons/demos/isigraph/iscolor.ijs'

NB. include evolute in-line
e0=. }: @ (2: # >:@i.)
e1=. <: @ +: $ _1: , ] , 1: , -
e2=. _1 & |. @ (e0 # e1)
evolute=: ,~ $ /: @ (+/\) @ e2 f.

HWNDP=: ''

clean=: 13 : 'y * 1e_10 <: |y'
mp=: +/ .*
viewbmp=: gshow

NB. =========================================================
NB. getbmp v get current graphics window as bitmap
getbmp=: 3 : 0
box=. 0 0,glqwh''
(3 2 { box) $ glqpixels box
)

NB. =========================================================
ISTYPE=: 0
locVM=: conew 'jviewmat'
j=. 'TITLE 1 EVOLUTE1 1 EVOLUTE2 1'
j=. j,' SIERCAR1 1 SIERCAR2 1 SIERTRI1 1 SIERTRI2 1 SIERTRI3 1 SIERTRI4 1'
j=. j,' PLASMA1 1 FRIEZE1 1 IFS1 1 IFS2 1'
j=. j,' KOCH 1 POLYGON 1 SPIRALS 1'
j=. j,' POWER 1 SINES 1'
j=. j,' PAINT 2 SMESSER 1'
j=. _2 [\ ;:j
ISDEMONAMES=: {."1 j
ISDEMOTYPE=: ". &> {:"1 j

ISDEMOVER=: 1.8
ISDEMOSEL=: 'TITLE'
ISDEMOPATH=: jpath '~addons/demos/isigraph/'

ISHANDLERS=: <;._2 (0 : 0)
isdemo_g_char
isdemo_g_mbldown
)

NB. =========================================================
OPENISDEMO=: 0 : 0
pc isdemo closeok;pn "J Graphics";
menupop "&Options";
menu view "&View Definition" "" "" "";
menusep ;
menu clip "&Clip" "" "" "";
menusep ;
menu savebmp "&Save ~temp/isdemo.bmp" "" "" "";
menusep ;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Basic";
menu MTITLE "Isigraph Graphics" "" "" "";
menusep ;
menu MEVOLUTE1 "E&volute 1" "" "" "";
menu MEVOLUTE2 "E&volute 2" "" "" "";
menupopz;
menupop "&IFS";
menupop "&Sierpinski";
menu MSIERCAR1 "&Carpet 1" "" "" "";
menu MSIERCAR2 "&Carpet 2" "" "" "";
menusep ;
menu MSIERTRI1 "&Triangle 1" "" "" "";
menu MSIERTRI2 "&Triangle 2" "" "" "";
menu MSIERTRI3 "&Triangle 3" "" "" "";
menu MSIERTRI4 "&Triangle 4" "" "" "";
menupopz;
menusep ;
menu MPLASMA1 "&Plasma Cloud 1" "" "" "";
menu MFRIEZE1 "&Frieze Pattern 1" "" "" "";
menusep ;
menu MIFS1 "&IFS1" "" "" "";
menu MIFS2 "&IFS2" "" "" "";
menupopz;
menupop "&Shapes";
menu MKOCH "&Koch" "" "" "";
menu MPOLYGON "&Polygon" "" "" "";
menu MSPIRALS "&Spirals" "" "" "";
menu MPOWER "&Power" "" "" "";
menu MSINES "&Sines" "" "" "";
menupopz;
menupop "&Extras";
menu MPAINT "&Paint" "" "" "";
menusep ;
menu MSMESSER "&Screen Roller" "" "" "";
menupopz;
menupop "&Help";
menu MF12 "&F12 Next" "" "" "";
menu MF12S "&Shift F12 Previous" "" "" "";
menusep ;
menu about "&About" "" "" "";
menupopz;
xywh 0 0 220 200;cc g isigraph rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)

NB. menusep ;
NB. menu print "&Print" "" "" "";

NB. =========================================================
isdemo=: 3 : 0
wd OPENISDEMO
HWNDP=: wd 'qhwndp'
wd 'setenable clip ',":-.IFUNIX
ISDEMOSEL=: ISDEMOSEL,(0=#ISDEMOSEL)#'TITLE'
wd 'pshow'
wd 'set M',ISDEMOSEL,' 1'
ISDEMODAT=: fread tolower ISDEMOPATH,ISDEMOSEL,'.ijs'
)

NB. =========================================================
isdemo_run=: 3 : 0
if. wdisparent 'isdemo' do.
  ISDEMODAT=: fread tolower ISDEMOPATH,ISDEMOSEL,'.ijs'
  if. IFJ6 +. ('Android'-.@-:UNAME) do.
    isdemo_run1 ISDEMODAT
  else.
    if. ('Android'-:UNAME) *. (<ISDEMOSEL) e. ;:'PAINT SMESSER ' do.
      sminfo 'J Graphics';'This demo is for desktop versions only'
      return.
    end.
    glsel 'g'
    glpaintx''
  end.
end.
)

NB. =========================================================
isdemo_g_paint=: 3 : 0
if. (<ISDEMOSEL) -.@e. ;:'PAINT SMESSER ' do.
  isdemo_run1 ISDEMODAT
end.
)

NB. =========================================================
isdemo_run1=: 3 : 0
try. wd 'psel isdemo'
catch. return. end.
glnodblbuf 0
glmark''
gopen''
0!:100 y
gshow''
glpaint''
)

NB. =========================================================
isdemo_about_button=: 3 : 0
j=. 'Isigraph Graphics Demo V',(4j2 ": ISDEMOVER)
sminfo 'Isigraph Graphics';j
)

NB. =========================================================
NB. following works only in Win32, need to make this
isdemo_clip_button=: 3 : 0
if. -. IFWIN do.
  sminfo 'Save graphics to clipboard is only available in Windows'
  return.
end.
f=. jpath '~temp/isdemo.emf'
glfile f
glemfopen''
isdemo_g_paint''
glemfclose''
wd 'clipcopyx enhmetafile "',f,'"'
1!:55 <f
)

NB. =========================================================
isdemo_default=: 3 : 0
if. 0=wdisparent 'isdemo' do. return. end.
if. systype -: 'button' do.
  name=. }.syschild
  if. (<name) e. ISDEMONAMES do.
    isdemo_showname name
  end.
end.
''
)

NB. =========================================================
isdemo_f12_fkey=: 3 : 0
wd 'psel isdemo'
ndx=. (#ISDEMONAMES) | >: ISDEMONAMES i. <ISDEMOSEL
isdemo_showname ndx pick ISDEMONAMES
)

NB. =========================================================
isdemo_f12shift_fkey=: 3 : 0
wd 'psel isdemo'
ndx=. (#ISDEMONAMES) | <: ISDEMONAMES i. <ISDEMOSEL
isdemo_showname ndx pick ISDEMONAMES
)

isdemo_MF12_button=: isdemo_f12_fkey
isdemo_MF12S_button=: isdemo_f12shift_fkey

NB. =========================================================
isdemo_savebmp_button=: 3 : 0
(getbmp'') writebmp jpath '~temp/isdemo.bmp'
)

NB. =========================================================
isdemo_showname=: 3 : 0
wd 'set M',ISDEMOSEL,' 0'
ISDEMOSEL=: y
ISTYPE=: ISDEMOTYPE {~ ISDEMONAMES i. <y
wd 'set M',ISDEMOSEL,' 1'
if. wdisparent 'paint' do.
  wd :: ] 'psel paint;pclose'
  wd 'psel isdemo'
end.
isdemo_run''
)

NB. =========================================================
isdemo_exit_button=: 3 : 0
try. wd 'psel paint;pclose;' catch. end.
try. wd 'psel isdemo;pclose;' catch. end.
destroy__locVM''
)

NB. =========================================================
isdemo_view_button=: 3 : 0
isedit_run_jigdemoedit_`start_droidwd_jigdemoedit_@.('Android'-:UNAME) 'jigdemoedit'
NB. isedit_run ISDEMODAT
)

NB. =========================================================
gback=: 3 : 0
glbrush glrgb y
glrect 0 0,glqwh''
)

NB. =========================================================
NB. gopen
gopen=: 3 : 0
try.
  wd 'psel isdemo;pactive'
catch. return.
end.
glsel 'g'
glclear''
GSIZE=: 0 ". wd 'qchildxywhx g'
)

NB. =========================================================
gshow=: 3 : 0
try. wd 'psel isdemo'
catch. return. end.
glsel 'g'
glpaint''
0
)

NB. =========================================================
vmat=: 3 : 0
'' vmat y
:
x viewmatcc__locVM y;wd'qhwndc g'
)

NB. =========================================================
isdemo_close=: isdemo_exit_button
