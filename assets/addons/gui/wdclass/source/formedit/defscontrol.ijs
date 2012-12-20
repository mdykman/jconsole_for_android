NB. define controls matrix

NB. =========================================================
NB. define controls as 7 rows:
NB. control, class, standard_style, class_style, size index,
NB. if caption, events
NB. button width, button height, edit width, edit height, label height
NB.
NB. the following are converted on read/write:
NB.   group   ws_group
NB.   opengl  gs_opengl
j=. 0 : 0
button
bs
group
defpushbutton ownerdraw
0 1
1
button
checkbox
bs
group
lefttext
2 4
1
button
combobox
cbs
group vscroll
autohscroll sort
2 2
0
button select
combodrop
cbs
group vscroll
autohscroll sort
2 2
0
button select
combolist
cbs
group vscroll
sort
2 2
0
button select
edit
es
group thickframe
autohscroll lowercase nohidesel password readonly right uppercase
2 3
0
button
editm
es
group hscroll thickframe vscroll
autohscroll autovscroll center lowercase nohidesel readonly right uppercase
2 2
0

groupbox
-
group
-
2 2
1

isigraph
gs
-
opengl
2 2
0
char copy cut focus focuslost mbldbl mbldown mblup mblmdown mblmdbl mblmup mbrdbl mbrdown mbrup mmove mwheel paint paste undo
listbox
lbs
group hscroll vscroll
extendedsel multicolumn multiplesel ownerdrawfixed sort
2 2
0
button select
progress
-
group
-
2 3
0
button
radiobutton
bs
-
lefttext
2 4
1
button
richedit
es
group thickframe
autohscroll nohidesel readonly sunken
2 3
0
button
richeditm
es
group hscroll thickframe vscroll
autohscroll autovscroll center nohidesel readonly right sunken
2 2
0

scrollbar
sbs
group
-
2 3
0
button
scrollbarv
sbs
group
-
3 2
0
button
spin

group
-
1 1
0
button
spinv

group
-
1 1
0
button
static
ss
group
center leftnowordwrap noprefix right simple
2 4
1

staticbox
ss
group
blackframe blackrect etchedframe etchedhorz etchedvert grayframe grayrect sunken whiteframe whiterect
2 2
0

tab
tcs
group
buttons multiline
2 2
0
button
trackbar
tbs
group
autoticks both enableselrange nothumb noticks top
2 3
0
button
trackbarv
tbs
group
autoticks both enableselrange left nothumb noticks
3 2
0
button
ocx
ocx
group

2 2
0
button
)

NB. editijs
NB. es
NB. group hscroll thickframe vscroll
NB. autohscroll autovscroll center lowercase nohidesel readonly right uppercase
NB. 2 2
NB. 0
NB.
NB. editijx
NB. es
NB. group hscroll thickframe vscroll
NB. autohscroll autovscroll center lowercase nohidesel readonly right uppercase
NB. 2 2
NB. 0

j=. _7 [\ <;._2 j -. '-'
s=. 'border disabled '
std=. ([: 'ws_'&, each [: ;: s&,) each 2 {"1 j
sty=. (1 {"1 j) ,each '_'
cls=. (< each sty) ,each each ;: each 3 {"1 j
siz=. 0 ". each 4 {"1 j
cap=. 0 ". each 5 {"1 j
evt=. ;: each 6 {"1 j
CONTROLS=: (2 {."1 j) ,. std ,. cls ,. siz ,. cap ,. evt

NB. =========================================================
JAVASTYLES=: cutopen 0 : 0
bs_defpushbutton
bs_lefttext
bs_ownerdraw
cbs_autohscroll
cbs_sort
es_autohscroll
es_autovscroll
es_center
es_lowercase
es_nohidesel
es_password
es_readonly
es_right
es_sunken
es_uppercase
gs_opengl
lbs_extendedsel
lbs_multicolumn
lbs_multiplesel
lbs_ownerdrawfixed
lbs_sort
sbs_vert
ss_blackframe
ss_blackrect
ss_center
ss_etchedframe
ss_etchedhorz
ss_etchedvert
ss_grayframe
ss_grayrect
ss_leftnowordwrap
ss_noprefix
ss_right
ss_simple
ss_sunken
ss_whiteframe
ss_whiterect
tbs_autoticks
tbs_both
tbs_enableselrange
tbs_left
tbs_nothumb
tbs_noticks
tbs_top
tcs_buttons
tcs_multiline
ws_border
ws_disabled
ws_group
ws_hscroll
ws_thickframe
ws_vscroll
)

NB. =========================================================
NB. If Java, limit styles to those supported:
3 : 0''
std=. 2 {"1 CONTROLS
cls=. 3 {"1 CONTROLS
if. IFJAVA do.
  std=. std (e. # [) each <JAVASTYLES
  cls=. cls (e. # [) each <JAVASTYLES
end.
CONTROLS=: (std ,. cls) 2 3 }"1 CONTROLS
STDCONTROLS=: CONTROLS #~ (<'ocx') ~: {."1 CONTROLS
)
