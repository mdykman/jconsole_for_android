NB. util - view

require 'gui/gtkwd'


coclass 'jview'


NB. maximum size of viewable data
MAXSIZE=: 400000

ischar=: 2 = 3!:0
getfontsz=: 13 : '{.1{._1 -.~ _1 ". y'

NB. =========================================================
3 : 0''
if. 0 ~: 4!:0 <'VIEWFONT' do.
  VIEWFONT=: FIXFONT
end.
if. 0 ~: 4!:0 <'SMPRINT_j_' do.
  VIEWPRINT=: ''
else.
  VIEWPRINT=: SMPRINT_j_
end.
0
)

VIEWFONTSIZE=: getfontsz VIEWFONT
VIEWFONTSCALE=: 1

NB. =========================================================
NB. cifmt1 comma integer format of single integer:
cifmt1=: 3 : 0
neg=. 0 > y
dat=. 0 ": | y
len=. #dat
msk=. (-len) {. (|. len$1j1 1 1) , 3$1
dat=. msk # !. ',' dat
(neg # '-'), dat
)

NB. =========================================================
flat=: 3 : 0
dat=. ": y
dat=. 1 1}. _1 _1}. ": <dat
}: (,|."1 [ 1,.-. *./\"1 |."1 dat=' ')#,dat,.LF
)

NB. =========================================================
NB. setfontsz
setfontsz=: 4 : 0
b=. ~: /\ y='"'
nam=. b#y
txt=. ;:(-.b)#y
ndx=. 1 i.~ ([: *./ e.&'0123456789.') &> txt
nam, }: ; ,&' ' &.> (<": x) ndx } txt
)

NB. =========================================================
unibox=: 3 : 0
fm=. (16+i.11) { a.
msk=. y e. fm
if. -. 1 e. msk do. y return. end.
to=. 4 u: 9484 9516 9488 9500 9532 9508 9492 9524 9496 9474 9472
y=. ucp y
msk=. y e. fm
un=. to {~ fm i. msk#y
utf8 un (I.msk) } y
)

NB. provides jview form
NB.
NB. methods:
NB.   create
NB.   destroy

NB. =========================================================
NB.*create v create view form
NB. y is  window name;header;text [;options]
NB. uses standard Windows edit control.
NB. options are in one of two forms:
NB.
NB. 1. up to 4 boxed flags
NB.   if wrap        default 0
NB.   if show print  default yes if a printer available (not WINCE)
NB.   if ptop        default 0
NB.   if edit        default 0
NB.
NB. new form: a single list in any order:
NB.   wrap,noprint,ptop,edit
NB.
NB. Here edit means the form is editable, and the result is
NB. returned in view_result__COCREATOR
create=: jview_run

NB. =========================================================
destroy=: codestroy

NB. =========================================================
NB. form defined for reference but not used here..
JVIEW=: 0 : 0
pc jview;
xywh 2 2 132 10;cc h0 static;
xywh 0 13 350 250;cc e0 editm ws_border ws_vscroll es_readonly rightmove bottommove;
xywh 140 2 24 10;cc Top checkbox leftmove rightmove;
xywh 166 2 29 10;cc Wrap checkbox leftmove rightmove;
xywh 196 1 38 12;cc Print button leftmove rightmove;
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
jview_form=: 3 : 0
'print edit'=. 2 {. y
VIEWMAX=: 0
ed=. ' ws_border ws_vscroll rightmove bottommove'
ed=. ed, (edit=0)# '  es_readonly'
wd 'pc jview'
wd 'xywh 2 2 132 10;cc h0 static;'
wd 'xywh 0 13 350 250;cc e0 editm',ed,' ws_hscroll'
NB. wd 'xywh 0 13 350 250;cc e1 editm',ed
p=. 269 - 48 * print + edit
wd 'xywh ',(":p),' 2 34 10;cc Top checkbox leftmove rightmove;'
p=. p + 37
wd 'xywh ',(":p),' 2 39 10;cc Wrap checkbox leftmove rightmove;'
p=. p + 43
if. print do.
  wd 'xywh ',(":p),' 1 48 12;cc Print button leftmove rightmove;'
  p=. p + 48
end.
if. edit do.
  wd 'xywh ',(":p),' 1 48 12;cc OK button leftmove rightmove;'
end.
wd 'setfont e0 ',VIEWFONT
NB. wd 'setfont e1 ',VIEWFONT
wd 'pas 0 0;pcenter;'
formhwnd=: wd 'qhwndp'
)

NB. =========================================================
jview_getargs=: 3 : 0
defprint=. (0<#VIEWPRINT) *. 0=IFWINCE
y=. boxopen y
'name hdr txt'=. 3 {. y,'';''
wrap=. ptop=. edit=. noprint=. 0
print=. 1
y=. 3 }. y
if. #y do.
  if. (1=#y) *. ischar >{.y do.
    y=. ' ',>{.y
    y=. (y e. ', ') <;._1 y
    y=. y #~ y e. ;:'wrap ptop edit noprint'
    if. #y do.
      (y)=. 1
    end.
    print=. -. noprint
  else.
    y=. ; y
    'wrap print ptop edit'=. 4 {. y, (#y) }. 0 1 0 0
  end.
end.
print=. print *. defprint
if. edit do.
  edit=. 3 = 4!:0 <'view_result__COCREATOR'
end.
name;hdr;txt;wrap;print;ptop;edit
)

NB. =========================================================
jview_gettext=: 3 : 0
e1=: e0
('1'={.Wrap) pick e0;e1
)

NB. =========================================================
NB. x arguments as for jview_form
jview_run=: 3 : 0

'name hdr txt wrap print ptop edit'=. jview_getargs y

if. 2 <: #$txt do. txt=. flat txt end.
txt=. unibox txt
txt=. (1{a.) (I. DEL=txt) }txt

NB. truncate text to MAXSIZE
if. MAXSIZE <: #txt do.
  msg=. 'Text size of ',(cifmt1 #txt),' characters is too large to view.'
  msg=. msg,LF,LF,'Truncated to ',(cifmt1 MAXSIZE),' characters.'
  txt=. (MAXSIZE {. txt),LF,'...'
  wdinfo name;msg
end.
TEXT=: txt

jview_form print,edit
wd 'pn *',name
wd 'set h0 *',hdr
wd 'set Wrap ',": wrap
wd 'set Top ',": ptop
wd 'ptop ',": ptop

try.
  wd 'set e0 *',txt
NB.   if. wrap=0 do.
NB.     wd 'set e0 *',txt
NB.     wd 'setshow e1 0;setshow e0 1'
NB.   else.
NB.     wd 'set e1 *',txt
NB.     wd 'setshow e1 1;setshow e0 0'
NB.   end.
catch.
  msg=. LF,LF,({.~ i.&':') wd 'qer'
  wdinfo 'jview';'Unable to view text',msg
  wd 'psel jview;pclose'
  destroy''
  return.
end.

wdfit''
wd 'pshow'
)

NB. =========================================================
jview_OK_button=: 3 : 0
TEXT=: jview_gettext''
jview_close 1
)

NB. =========================================================
jview_Print_button=: 3 : 0
txt=. jview_gettext''
try. '' VIEWPRINT~ txt
catch. wdinfo 'Print';'Print failed.',LF,LF,'Check the printer is installed'
end.
)

NB. =========================================================
jview_Top_button=: 3 : 0
wd 'ptop ',Top
)

NB. =========================================================
jview_Wrap_button=: 3 : 0
return.
if. Wrap='1' do.
  wd 'set e1 *',e0
  wd 'setselect e1 ',e0_select
  wd 'setshow e1 1;setshow e0 0'
else.
  wd 'set e0 *',e1
  wd 'setselect e0 ',e1_select
  wd 'setshow e0 1;setshow e1 0'
end.
)

NB. =========================================================
NB. close enables and selects our owner
jview_close=: 3 : 0
wd 'pclose'
f=. 'view_result__COCREATOR'
if. 3 = 4!:0 :: _1: < f do.
  if. y -: 1 do.
    res=. 0;TEXT
  else.
    res=. 1;TEXT
  end.
  try. f~res catch. end.
end.
destroy''
)

NB. =========================================================
jview_cancel=: jview_close

NB. =========================================================
jview_mctrl_fkey=: 3 : 0
VIEWMAX=: -. VIEWMAX
if. VIEWMAX do.
  wd 'pshow sw_showmaximized'
else.
  wd 'pshow sw_shownormal'
end.
)

NB. =========================================================
jview_maximize=: 3 : 0
VIEWMAX=: 0
jview_mctrl_fkey''
)

NB. =========================================================
jview_scale=: 3 : 0
VIEWFONTSCALE=: VIEWFONTSCALE * 1.2 ^ y
font=. (<. 0.5 + VIEWFONTSIZE * VIEWFONTSCALE) setfontsz VIEWFONT
wd 'setfont e0 ',font
NB. wd 'setfont e1 ',font
)

NB. =========================================================
jview_bctrl_fkey=: jview_scale bind 1
jview_bctrlshift_fkey=: jview_scale bind _1


NB. zdefs
NB.
NB. J601: fview is moved from files.ijs
NB. J601: wdview is moved from winlib.ijs
NB. J601 both now create a jview object

cocurrent 'z'

NB. =========================================================
NB.*fview v view file
fview=: 3 : 0
y=. boxopen y
f=. 1!:(1 11 {~ 2=#y)
dat=. f :: _1: y
if. dat -: _1 do. return. end.
empty (>{.y) wdview dat
)

NB. =========================================================
NB.*wdview v text viewer
NB. y is text  or  header;text [;options...]
NB.
NB. options are in one of two forms:
NB.
NB. 1. a boxed list of up to 4 flags:
NB.   wrap;print;top;edit (default 0;1;0;0)
NB.
NB. 2. a character list of keywords delimited by commas and/or blanks,
NB. all default 0 if not given:
NB.    wrap, noprint, top, edit
NB.
NB. Here edit means the form is editable, and the result is
NB. returned in view_result__COCREATOR
NB.
NB. x is optional window name
NB. uses standard Windows edit control,
wdview=: 3 : 0
'View' wdview y
:
txt=. y
if. 0=L.txt do. txt=. '';txt end.
empty (x;txt) conew 'jview'
)

