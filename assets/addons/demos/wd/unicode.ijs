NB. built from project: ~Source/examples/unicode/unicode
NB. init

GTKOUTPUT_jzgrid_=: 'isi'
require 'jzgrid plot'

coclass 'judemo'


IFUNICODE=: 1
CELLALIGN=: 0
CELLFMT=: ',c'
CELLVALS=: 6146 35755 22079 12852 42854 92439
GRIDNAMES=: 'cellalign celldata cellfmt'

require 'gui/gtkwd/wdjview'

NB. util

n=. 'This demo shows examples of traditional Chinese characters in a form.'
NOTES=: n,' It assumes that your system and form font supports these characters.'



NB. demo data

PLOTDATA=: 1.5 2.7 2.7 2.1,2 0.4 2 4.4,:5.5 0.5 3.5 7.5

NB. =========================================================
NB. texts
t=. 0 : 0
0;OK;確定;
1;Close;關閉;
2;Show English;顯示漢語;
3;Apples;蘋果;
4;Bananas;香蕉;
5;Oranges;橙;
6;Hong Kong;香港;
7;United States;美國;
8;Australia;澳洲;
9;Singapore;新加坡;
10;United Kingdom;英國;
11;France;法國;
12;Fruit Sales;特價生果;
13;No problem;沒有問題;
)

t=. <;._2 &> <;._2 t
UNITEXTS=: (0 ". each {."1 t) 0 }"0 1 t

NB. following is UTF-16 Show English, actual text used is Show Chinese:
NB. 39023 31034 33521 35486

NB. =========================================================
unitext=: 3 : 0
((; {."1 UNITEXTS) i. y) { (1+IFUNICODE) {"1 UNITEXTS
)

NB. =========================================================
unitextr=: 3 : 0
((; {."1 UNITEXTS) i. y) { (1+-.IFUNICODE) {"1 UNITEXTS
)

NB. =========================================================
unitexts=: 3 : 0
((; {."1 UNITEXTS) i. y) { 1 2 {"1 UNITEXTS
)

NB. =========================================================
EDITTEXTS=: unitexts 13

NB. =========================================================
setdata=: 3 : 0
CELLDATA=: (unitext 6+i.6),.<&>CELLVALS
TOGGLE=: > unitextr 2
setplotdata''
)

NB. =========================================================
setplotdata=: 3 : 0
PLOTKEYS=: }. ; ',', each unitext 3 4 5
PLOTTITLE=: > unitext 12
'OK CLOSE'=: unitext 0 1
)


NB. win

NB. =========================================================
UNIDEMO=: 0 : 0
pc unicode;pn "Unicode Demo";
xywh 8 9 258 34;cc notes static rightmove;cn "";
xywh 195 46 70 12;cc viewsource button leftmove rightmove;cn "View Source";
xywh 3 62 265 5;cc sb staticbox ss_etchedhorz rightmove;
xywh 9 72 174 14;cc edit edit rightmove;
xywh 9 91 174 86;cc grid isigraph rightmove bottomscale;
xywh 8 182 258 110;cc plot isigraph ws_border topscale rightmove bottommove;
xywh 195 75 70 12;cc ok button leftmove rightmove;cn "";
xywh 195 90 70 12;cc cancel button leftmove rightmove;cn "";
xywh 195 105 70 12;cc toggle button leftmove rightmove;cn "";
pas 0 4;pcenter;
rem form end;
)

NB. =========================================================
unicode_run=: 3 : 0
wd UNIDEMO
wd 'set notes *',NOTES
PForm=: 'unicode'
PFormhwnd=: wd'qhwndp'
wd 'pshow;'
grid=: '' conew 'jzgrid'
plot=: '' conew 'jzplot'
show''
)

NB. =========================================================
unicode_toggle_button=: 3 : 0
read''
IFUNICODE=: -. IFUNICODE
show''
)

NB. =========================================================
unicode_viewsource_button=: 3 : 0
fview jpath '~addons/demo/wd/unicode.ijs'
)

NB. =========================================================
unicode_viewnotes_button=: 3 : 0
wdinfo 'Unicode';ALLNOTES
)

NB. =========================================================
read=: 3 : 0
EDITTEXTS=: (<edit) IFUNICODE } EDITTEXTS
)

NB. =========================================================
show=: 3 : 0
setdata''
unicode_grid_paint''
unicode_plot_paint''
wd 'set edit *',IFUNICODE pick EDITTEXTS
wd 'setcaption ok *',OK
wd 'setcaption cancel *',CLOSE
wd 'setcaption toggle *',TOGGLE
)

NB. =========================================================
unicode_grid_paint=: 3 : 0
show__grid GRIDNAMES
)

NB. =========================================================
unicode_plot_paint=: 3 : 0
loc=. coname''
cocurrent plot
PId=: 'plot'
pd 'reset'
pd 'type bar'
pd 'axes 1 0'
pd 'xlabel ',":2001+i.4
pd 'keystyle of'
pd 'keypos ro'
pd 'key ',PLOTKEYS__loc
pd 'title ',PLOTTITLE__loc
pd PLOTDATA__loc
pd 'show'
)

NB. =========================================================
unicode_close=: 3 : 0
destroy__grid ''
destroy__plot ''
wd'pclose'
)

NB. =========================================================
unicode_cancel_button=: 3 : 0
unicode_close''
)

unicode_run''
