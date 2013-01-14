NB. init

3 : 0''
if. IFJ6 do.
  script_z_ '~system/main/files.ijs'
  script_z_ '~system/main/gl2.ijs'
else.
  require 'gtkwd'
end.
''
)

coclass 'pnurikabe'
NB. init

coinsert 'jgl2'
NB. util

EMPTY=: i. 0 0
HWNDP=: 0

finished=: info bind 'Game completed.'
unfinished=: info bind 'Game not yet completed.'
gethit=: 3 : 'POS inrect 2 {. 0 ". sysdata'
info=: wdinfo @ ('Nurikabe'&;)
ischar=: 3!:0 e. 2 131072"_
pathname=: 3 : '(b#y);(-.b=.+./\.y=PATHSEP_j_)#y'
query=: wdquery 'Nurikabe'&;
quote=: ''''&,@(,&'''')@(#~ >:@(=&''''))

NB. =========================================================
bufinit=: 3 : 0
BUF=: ,<BOARD
BUFPOS=: 0
)

NB. =========================================================
buffer=: 3 : 0
if. BUFPOS < <:#BUF do.
  BUF=: (BUFPOS+1) {. BUF
end.
new=. <BOARD
if. new -: {:BUF do. return. end.
BUFPOS=: #BUF
BUF=: BUF,new
EMPTY
)

NB. =========================================================
NB. 0=check when draw
NB. 1=check from button
checkdone=: 3 : 0
board=. SHAPE$BOARD
if. y do. board=. board >. _1 end.
try.
  check board
catch.
  0
end.
)

NB. =========================================================
NB. inrect v test rectangles for hit or _1 if none
NB. form: rect inrect pos
inrect=: 4 : 0
'px py'=. y
'x y w h'=. |: x
msk=. (px >: x) *. (px <: x + w) *. (py >: y) *. (py <: y + h)
(ndx<#msk){_1,ndx=. msk i. 1
)
NB. sample boards

fixnum=: 3 : '0&". ;._2 (0 : 0)'

n1=: fixnum''
0 1 0 0 0
0 0 0 0 2
0 0 0 0 0
3 0 0 0 0
0 0 0 2 0
)

n2=: fixnum''
0 0 0 0 2
0 0 2 0 0
0 0 0 0 0
0 0 2 0 0
2 0 0 0 0
)

n3=: fixnum''
0 0 0 0 0
3 0 0 0 0
0 1 0 2 0
0 0 0 0 5
0 0 0 0 0
)

n4=: fixnum''
0 5 0 0 2
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
2 0 0 1 0
)

n5=: fixnum''
0 0 1 0 5
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
7 0 1 0 0
)

n6=: fixnum''
0 0 0 0 0 0 0 3 0
0 0 0 0 0 0 5 0 0
1 0 0 0 0 0 0 0 0
0 0 4 0 0 0 0 0 0
5 0 0 0 0 0 0 0 5
0 0 0 0 0 0 5 0 0
0 0 0 0 0 0 0 0 5
0 0 1 0 0 0 0 0 0
0 3 0 0 0 0 0 0 0
)

n7=: fixnum''
0 0 5 0 0 0 0 0 0
0 8 0 0 0 0 0 0 3
0 0 0 0 0 0 0 0 0
0 0 0 0 0 3 0 0 0
2 0 0 0 0 0 0 0 1
0 0 0 4 0 0 0 0 0
0 0 0 0 0 0 0 0 0
2 0 0 0 0 0 0 6 0
0 0 0 0 0 0 3 0 0
)

n8=: fixnum''
0 0 0 0 0 0 0 5 0 2
3 0 0 0 0 0 0 0 0 0
0 4 0 0 2 0 0 0 0 0
0 0 0 0 0 0 3 0 0 0
0 4 0 0 0 4 0 0 0 0
0 0 0 0 0 0 0 0 0 3
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 3 0 0 3 0 0 0 0 0
0 0 1 0 0 1 0 3 0 3
)

NB. Sample problem 6 by OX from the Nikoli page
n9=: fixnum''
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 0 0 0 0 12 0 0 0 0 0 3 0 12 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2
2 0 0 0 0 3 0 0 0 0 0 3 0 0 0 0 3 0
0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0
3 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 2 0 0 2 0 3 0 2 0 0 0 0 0 0 0
2 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 12 0 1
)

NB. =========================================================
demoboard=: 3 : 0
id=. 'n',":y
run ('Board',":y);".id
)
NB. draw

EDITON=: ;:'editcancel editok'
EDITOFF=: ;:'undo redo hint check'
j=. ;:'newboard openboard saveboard saveboardas'
EDITENABLE=: j, (<'board') ,each ": each 1 + i.9

COLORS=: 3 #&> 255 0 128
HIGHCOLOR=: 192 0 0
GRIDCOLOR=: 3 # 112
CARETCOLOR=: 216 216 255

FONT=: IFUNIX pick 'Arial';'SansSerif'

NB. =========================================================
draw=: 3 : 0
drawit''
glpaint''
)

NB. =========================================================
drawit=: 3 : 0
if. EDIT do.
  DONE=: 0
  drawboard'' return.
end.
if. -.DONE do.
  DONE=: checkdone 0
end.
drawboard''
if. DONE=1 do.
  glpaint''
  finished''
  DONE=: 2
end.
)

NB. =========================================================
NB. drawboard
drawboard=: 3 : 0
rc=. */'r c'=. SHAPE
glsel 'g'
'wid hit'=. _1 + glqwh''
x=. <. 0.5 + wid * (i.c) % c
w=. 1 + (}.x,wid) - x
y=. <. 0.5 + hit * (i.r) % r
h=. 1 + (}.y,hit) - y
POS=: (rc$x),.(c#y),.(rc$w),.c#h
clr=. (| 0 <. BOARD){COLORS
clr=. CARETCOLOR CARET} clr
glpen 1 0 [ glrgb GRIDCOLOR
POS drawrect"1 clr
glfont FONT,' ',":<. 0.45 * <./w,h
ndx=. I. 0 < ,BOARD
if. #ndx do.
  (ndx{POS) drawtext"1 0 ndx{BOARD
end.
if. DONE < HIGH >:0 do.
  glbrushnull''
  if. EDIT do.
    glpen 2 0 [ glrgb HIGHCOLOR
    glrect 1 1 _2 _2 + HIGH{POS
  else.
    glpen 1 0 [ glrgb HIGHCOLOR
    glrect HIGH{POS
  end.
end.
if. EDIT do. return. end.
if. DONE do.
  wd 'setenable undo 0'
  wd 'setenable redo 0'
  wd 'setenable hint 0'
  wd 'setenable check 0'
else.
  len=. #BUF
  wd 'setenable restart ',":len > 1
  wd 'setenable undo ',":BUFPOS > 0
  wd 'setenable redo ',":BUFPOS < len-1
  wd 'setenable hint 1'
  wd 'setenable check 1'
end.
)

NB. =========================================================
drawsetedit=: 3 : 0
wd 'psel ',":HWNDP
EDIT=: y
wd ;(<';setshow '), each EDITON ,each <' ',":EDIT
wd ;(<';setshow '), each EDITOFF ,each <' ',":-.EDIT
wd ;(<';setenable '), each EDITENABLE ,each <' ',":-.EDIT
)

NB. =========================================================
NB. draw highlight as mouse moves
drawhigh=: 3 : 0
if. HIGH -: y do. return. end.
HIGH=: y
drawboard''
glpaint''
)

NB. =========================================================
drawrect=: glrect@[ glbrush@glrgb

NB. =========================================================
drawtext=: 4 : 0
txt=. ":y
'wid hit'=. glqextent txt
'x y w h'=. x
gltextxy <.(x + -:w-wid),y+-:h-hit
gltext txt
)
NB. files

FTYPES=: '"Nuikabe (*.nkb)|*.nkb|All Files (*.*)|*.*"'

NB. =========================================================
getboard=: 3 : 0
r=. 'BOARD=: ".;._2 (0 : 0)',LF
r=. r,,(":SHAPE$BOARD),.LF
r=. r,')',LF
if. #NAME do.
  r=. r,LF,LF,~'NAME=: ',quote NAME
end.
)

NB. =========================================================
NB. getsaveas v get a save as file name
getsaveas=: 3 : 0
fn=. FILE, (0=#FILE) # jpath '~temp/'
while. 1 do.
  'p f'=. pathname fn
  j=. FTYPES,' ofn_nochangedir'
  fn=. wd 'mbsave "Save As" "',p,'" "',f,'" ',j
  if. 0=#fn do. return. end.
  if. -. '.' e. fn do. fn=. fn,'.nkb' end.
  if. fn -: FILE do. return. end.
  if. 0=fexist fn do. return. end.
  j=. fn,LF,'This file already exists.',LF,LF
  msg=. j,'Replace existing file?'
  if. 0=2 query msg do. fn return. end.
end.
)

NB. =========================================================
openboard=: 3 : 0
if. #FILE do.
  p=. 0 pick pathname FILE
else.
  p=. jpath '~temp'
end.
j=. FTYPES,' ofn_nochangedir'
while. 1 do.
  f=. wd 'mbopen "Open File" "',p,'" "" ',j
  if. 0 = #f do. '' return. end.
  if. -. fexist f do.
    f=. f,(-. '.' e. f)#'.nkb'
    if. -. fexist f do.
      info 'Not found: ',f continue.
    end.
  end.
  break.
end.
NAME=: ''
BOARD=: i.0 0
FILE=: f
0!:100 freads FILE
if. -.1 validate BOARD do.
  info 'Invalid board'
  0 return.
end.
SHAPE=: $BOARD
BOARD=: ,BOARD
nk_run 0
1
)

NB. =========================================================
saveboard=: 3 : 0
if. #FILE do.
  (getboard'') fwrites FILE
  info 'Saved: ',FILE
else.
  saveboardas''
end.
)

NB. =========================================================
saveboardas=: 3 : 0
fn=. getsaveas''
if. #fn do.
  FILE=: fn
  (getboard'') fwrites FILE
  info 'Saved: ',FILE
  wd 'psel ',": HWNDP
  nk_name''
end.
)
NB. help

NB. =========================================================
ABOUT=: 0 : 0
Nurikabe is a binary determination puzzle invented by the Japanese games publisher Nikoli in March 1991

A puzzle is specified as a matrix of zeros and positive integers. The zeros are to be colored black or white; the positive integers are to be left alone and are considered to be colored white. In a solution:

 * "Connected" means rectangularly connected.
 * Each cell numbered k is part of an island of k connected white cells.
 * All the black cells are connected.
 * There are no 2x2 blocks of black cells.
 * A puzzle has a unique solution.

For more information, see J wiki Essays/Nurikabe.
)

NB. =========================================================
NEWBOARD=: 0 : 0
To create a new board, select New... from the File menu, and complete the dialog. The board size must be at least 5 x 5.

When the new board is displayed, double-click any cell. Any value will be deleted, and the cell colored. To enter a new value, press any number keys followed by Enter, or move the mouse away.

Accept the new board to start the game.
)
WHITE=: 0
BLACK=: _1
FREE=: _2

init=: + FREE*0=]

see=: 3 : 'y { _1|.(":&.>1+i.>./,y),<"0 ''?X '''

connect=: 3 : 0     NB. connection matrix for Nurikabe
s=. WHITE<.y
i=. I., (}.=}:) s
j=. I., 0,.~(}."1 = }:"1) s
(+.|:) 1 (<"1 (i+/0,{:$y),j+/0 1)}=i.*/$y
)

tc=: +./ .*~^:(>.@(2&^.)@#)
NB. transitive closure of a reflexive graph

islands=: ~. @ (<@I."1"_) @ tc @ connect
NB. connected components

check=: 3 : 0       NB. 1 iff y is a Nurikabe solution
assert. (y e. BLACK,WHITE) +. 0<y
assert. -. 2 2 (2 2$BLACK)&-:;._3 y
c=. islands y
assert. (#c) = 1++/,0<y
i=. c{&.><,y
n=. #&>i
b=. i = n$&.><BLACK
assert. 1=+/b
assert. b +. *./@(0&<:)&>i
assert. b +. 1 = +/@(0&<)&>i
assert. b +. n = +/&>i
1
)

wf=: 3 : 0          NB. # white cells, # free cells
t=. ,y
m=. (+/0>.t)-+/(0<t)+.t=WHITE
n=. +/t=FREE
m,n
)

comb=: 4 : 0        NB. All size x combinations of i.y
k=. i.>:d=. y-x
z=. (d$<i.0 0),<i.1 0
for. i.x do. z=. k ,.&.> ,&.>/\. >:&.> z end.
; z
)

bf=: 3 : 0          NB. brute force solver
t=. ,y
b=. t=FREE
'm n'=. wf t
t=. ($y) $"1 (t*-.b) +"1 b #^:_1"1 ((i.n) e."1 m comb n){BLACK,WHITE
t {~ (check :: 0:"2 i. 1:) t
)

heuristics=: hendgame @ (hislands @ h2ell @ h22 ^:_) @ h2far

bfh=: bf @ heuristics @ init
NB. brute force with heuristics

h2far=: 3 : 0       NB. set to black cells too far from a numbered cell
i=. ($y)#:I.,_2=y
j=. ($y)#:I.,1<y
b=. (i +/@:|@:-"1/ j) */ .>: (1<y)#&,y
p=. (i.$y) e. ($y)#.b#i
(p*BLACK) + y*-.p
)

neighborhood=: 3 3 ,;._3 [,.([,],[),.[
NB. neighborhood of each atom in y, bordering y by x

h22=: 3 : 0         NB. set to white the free cell of a 2x2 block with 3 black cells
p=. (FREE=y) *. +./"1 (=i.4) e.~ (,/2 2 ,;._3 i.3 3) {"2 1 (BLACK,FREE) i. WHITE neighborhood y
(p*WHITE) + y*-.p
)

NB. If a 2-cell has only two possibilities for a white neighbor,
NB. and the three cells together form an "L",
NB. then set to black the neighbor of the two limbs of the "L".

h2ell=: 3 : 0
k=. #: 12 10 5 3
t=. FREE = (* (2=4{"1]) * (k{BLACK,FREE) e.~ 1 3 5 7{"1 ]) ,/ BLACK neighborhood y
i=. I. -. t-:"1 (9$0)
j=. (k i.(<i;1 3 5 7){t){(-1 _1+n),_1 1+n=. {:$y
p=. (i.$y) e. i+j
(p*BLACK) + y*-.p
)

NB. set to black neighbors of complete white islands
NB. set to white the only free neighbor of an incomplete white island surrounded by blacks
NB. set to black the only free neighbor of a black island, if there is more than one black island
NB. set to black a free cell neighboring >1 numbered white islands
NB. set to x cells of a free island surrounded by x cells

hislands=: 3 : 0
N=. 1 3 5 7 {"1 ,/_1 neighborhood i.$y  NB. neighbors for each cell
t=. islands y                           NB. islands
c=. t{&.><,y                            NB. corresp. colors
n=. (t ,@:{&.> <N) ~.@-.&.> _1,&.>t     NB. neighbors of each island
d=. n{&.><,y                            NB. corresp. colors
s=. (#&>c) (= * 0<]) +/&>c              NB. for white islands, 1 iff complete
y=. BLACK i"_} y [ i=. ;p#n [ p=. w * s [ w=. WHITE<:{.&>c
y=. WHITE i"_} y [ i=. ((p#d)i.&>FREE){&>p#n [ p=. w * s < (FREE e.&>d) * (<:#&>d)=+/@(BLACK&=)&>d
y=. BLACK i"_} y [ i=. ((p#d)i.&>FREE){&>p#n [ p=. (1=+/@(FREE&=)&>d) (* * 1<+/@]) BLACK={.&>c
y=. BLACK i"_} y [ i=. (I.FREE=,y) (e.#[) (-.@~: # ]) ;n#~0<+/&>c
y=. BLACK i"_} y [ i=. ; t #~ f * */@(BLACK&=)&>d [ f=. FREE={.&>c
y=. WHITE i"_} y [ i=. ; t #~ f * WHITE=<./&>d
)

NB. set to black all free cells if no white cells are left
NB. set to white all free cells if # missing white cells equals # free cells

hendgame=: 3 : 0
c=. wf y
(p*i{BLACK,WHITE,FREE) + y*-.p=. (FREE=y)*2>i=. ((0={.c),=/c)i.1
)

NB. apply heuristics and pick a cell that can be colored
NB. the result is (i,j,COLOR), or '' if no hints are available

hint=: 3 : 0
if. -. y -: h=. h2far y do. h ijv y~:h return. end.
if. -. y -: h=. h22 y do. h ijv y~:h return. end.
if. -. y -: h=. h2ell y do. h ijv y~:h return. end.
if. -. y -: h=. hislands y do. h ijv y~:h return. end.
if. -. y -: h=. hendgame y do. h ijv y~:h return. end.
''
)

ijv=: 4 : '(, x {~ <) ($y) #: (?@# { ]) I.,y'
NB. (row,column,value) in x of a cell having value 1 in boolean y
NB. newboard

NB. =========================================================
NEW=: 0 : 0
pc new;pn "New Board";
xywh 10 12 31 12;cc s1 static;cn "Rows:";
xywh 45 11 20 13;cc erows edit;
xywh 10 28 31 12;cc s2 static;cn "Cols:";
xywh 45 28 20 13;cc ecols edit;
xywh 10 46 65 12;cc s0 static;cn "Name (optional):";
xywh 76 45 120 13;cc ename edit rightmove;
xywh 156 8 44 12;cc ok button leftmove rightmove;cn "OK";
xywh 156 23 44 12;cc cancel button leftmove rightmove;cn "Cancel";
pas 6 6;pcenter;
rem form end;
)

NB. =========================================================
new_run=: 3 : 0
wd NEW
wd 'pshow'
)

NB. =========================================================
new_close=: 3 : 0
wd 'pclose'
wd 'psel ',":HWNDP
)

NB. =========================================================
new_ok_button=: 3 : 0
rws=. {. 0 ". erows
cls=. {. 0 ". ecols
name=. deb ename
if. 0 e. ((-:<.) rws,cls), 5 <: rws,cls do.
  info 'Rows and Cols should be 5 or more'
  return.
end.
OLDBOARD=: BOARD;SHAPE;NAME;FILE
CARET=: ''
SHAPE=: rws,cls
BOARD=: (rws*cls)$0
NAME=: name
FILE=: ''
new_close''
nk_run 1
)

NB. =========================================================
newboardcancel=: 3 : 0
if. 2 query 'OK to cancel edit?' do. return. end.
'BOARD SHAPE NAME FILE'=: OLDBOARD
nk_run 0
)

NB. =========================================================
newboardok=: 3 : 0
if. 2 query 'OK to accept board?' do. return. end.
BOARD=: init BOARD
nk_run 0
)

NB. =========================================================
new_cancel_button=: new_close
newboard=: new_run
NB. mouse handling

NB. =========================================================
mmove=: 3 : 0
if. DONE do. return. end.
hit=. gethit''
if. #CARET do.
  if. hit ~: CARET do. charset'' end.
end.
drawhigh hit
)

NB. =========================================================
mbldown=: 3 : 0
CARET=: TEXT=: ''
if. DONE do. return. end.
ndx=. gethit''
if. EDIT do. return. end.
if. ndx >: 0 do.
  val=. ndx{,BOARD
  if. val>0 do. return. end.
  BOARD=: (val { _1 0 _2) ndx} BOARD
  buffer''
end.
draw''
)

NB. =========================================================
mbldbl=: 3 : 0
if. -. EDIT do.
  mbldown'' return.
end.
ndx=. gethit''
BOARD=: 0 ndx} BOARD
CARET=: ndx
TEXT=: ''
wd 'setfocus g'
draw''
)

NB. text

NB. =========================================================
char=: 3 : 0
if. 0=#CARET do. return. end.
m=. 0 ". sysmodifiers
c=. {.sysdata
if. m do. charreset'' return. end.
if. c e. '0123456789' do.
  TEXT=: TEXT,c
else.
  if. c ~: 13{a. do.
    TEXT=: ''
  end.
  charset''
end.
draw''
)

NB. =========================================================
charset=: 3 : 0
BOARD=: ({. 0 ". TEXT) CARET} BOARD
CARET=: TEXT=: ''
)
NB. validate

NB. =========================================================
NB. simple validations on starting board
NB. x:
NB.  0 = opening board (no negatives)
NB.  1 = board in play (includes _1 _2)
validate=: 4 : 0
board=. y

if. 2 ~: #$board do. info 'Board should be a matrix.'
  0 return.
end.

if. 1 e. 5 > $board do.
  info 'Board should be a matrix with sides length 5 or more.'
  0 return.
end.

board=. ,board
if. x do.
  if. 1 e. _2 > board do.
    info 'Board should only have _1 and _2 negative entries.'
    0 return.
  end.
else.
  if. 1 e. 0 > board do.
    info 'Board should have no negative entries.'
    0 return.
  end.
end.

if. *./0 = board do.
  info 'Board should have some positive entries.'
  0 return.
end.

if. -. board -: <. board do.
  info 'Board should have only integer entries'
  0 return.
end.

1
)

NB. win

NK=: 0 : 0
pc nk;pn "Nurikabe";
menupop "File";
menu newboard "&New..." "Ctrl+N" "" "";
menusep;
menu openboard "&Open..." "Ctrl+O" "" "";
menusep ;
menu saveboard "Save" "Ctrl+S" "" "";
menu saveboardas "Save &As..." "" "" "";
menusep;
menu exit "Exit" "" "" "";
menupopz;
menupop "Demos";
menu board1 "&Board1 5x5" "" "" "";
menu board2 "&Board2 5x5" "" "" "";
menu board3 "&Board3 5x5" "" "" "";
menu board4 "&Board4 5x5" "" "" "";
menu board5 "&Board5 5x5" "" "" "";
menusep;
menu board6 "&Board6 9x9" "" "" "";
menu board7 "&Board7 9x9" "" "" "";
menusep;
menu board8 "&Board8 10x10" "" "" "";
menusep;
menu board9 "&Board9 10x18" "" "" "";
menupopz;
menupop "Help";
menu about "&About" "" "" "";
menusep;
menu helpnew "&New Board" "" "" "";
menupopz;
xywh 2 1 39 12;cc restart button;cn "Restart";
xywh 41 1 39 12;cc undo button;cn "Undo";
xywh 80 1 39 12;cc redo button;cn "Redo";
xywh 119 1 39 12;cc hint button;cn "Hint";
xywh 158 1 39 12;cc check button;cn "Check";
xywh 2 1 39 12;cc editcancel button;cn "Cancel";
xywh 41 1 39 12;cc editok button;cn "Accept";
xywh 0 14 250 1;cc s0 staticbox ss_etchedhorz rightmove;
xywh 0 15 250 250;cc g isigraph rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)

NKQT=: 0 : 0
pc nk qtwd;pn "Nurikabe";
menupop "File";
menu newboard "&New..." "Ctrl+N" "" "";
menusep;
menu openboard "&Open..." "Ctrl+O" "" "";
menusep ;
menu saveboard "Save" "Ctrl+S" "" "";
menu saveboardas "Save &As..." "" "" "";
menusep;
menu exit "Exit" "" "" "";
menupopz;
menupop "Demos";
menu board1 "&Board1 5x5" "" "" "";
menu board2 "&Board2 5x5" "" "" "";
menu board3 "&Board3 5x5" "" "" "";
menu board4 "&Board4 5x5" "" "" "";
menu board5 "&Board5 5x5" "" "" "";
menusep;
menu board6 "&Board6 9x9" "" "" "";
menu board7 "&Board7 9x9" "" "" "";
menusep;
menu board8 "&Board8 10x10" "" "" "";
menusep;
menu board9 "&Board9 10x18" "" "" "";
menupopz;
menupop "Help";
menu about "&About" "" "" "";
menusep;
menu helpnew "&New Board" "" "" "";
menupopz;
bin vh;
xywh 2 1 39 12;cc restart button;cn "Restart";
xywh 41 1 39 12;cc undo button;cn "Undo";
xywh 80 1 39 12;cc redo button;cn "Redo";
xywh 119 1 39 12;cc hint button;cn "Hint";
xywh 158 1 39 12;cc check button;cn "Check";
xywh 2 1 39 12;cc editcancel button;cn "Cancel";
xywh 41 1 39 12;cc editok button;cn "Accept";
bin z;
xywh 0 14 250 1;cc s0 staticbox ss_etchedhorz rightmove;
xywh 0 15 250 250;cc g isigraph rightmove bottommove;
bin z;
pas 0 0;pcenter;
rem form end;
)

NB. not yet...
NB. menu solve "Solve" "" "" "";

NB. =========================================================
nk_run=: 3 : 0
bufinit''
DONE=: 0
HIGH=: _1
if. HWNDP=0 do.
  wd IFQT{::NK;NKQT
  HWNDP=: wdqhwndp''
end.
wd^:(-.IFJ6) 'pshow;pshow sw_hide'
drawsetedit {.y,0
nk_fit''
nk_name''
drawit''
wd 'setfocus g'
wd 'pshow;'
)

NB. =========================================================
nk_check_button=: 3 : 0
if. DONE=: checkdone 1 do.
  BOARD=: BOARD >. _1
  draw''
else.
  unfinished''
end.
)

NB. =========================================================
nk_close=: 3 : 0
wd 'setenable g 0'
wd 'pclose'
codestroy''
)

NB. =========================================================
NB. try to fit in part of available screen
NB. if edge is > 10, scale up to near full screen
nk_fit=: 3 : 0
formx=. wdqformx''
gx=. wdqchildxywhx 'g'
swh=. 2 {. wdqm''
cr=. |. SHAPE
if. *./ 10 >: cr do.
  siz=. cr * <./ <. 0.5 * swh % cr
else.
  siz=. cr * (<./ <. 0.5 * swh % 10) <. <./ <. 0.85 * swh % cr
end.
del=. 1 + siz - _2 {. gx
if. -. IFJAVA do.
  wd 'setxywhx g ',":gx + 0 0,del
end.
wd 'pmovex ',":formx + 0 0,del+5*IFJAVA
wd 'pcenter'
)

NB. =========================================================
nk_name=: 3 : 0
name=. NAME,(0<#NAME)#' '
if. #FILE do.
  file=. ' ',1 pick pathname FILE
else.
  file=. ''
end.
wd 'pn *Nurikabe ',name,(}.;'x'&,each ":each SHAPE),file
)

NB. NB. =========================================================
NB. nk_hint_button=: 3 : 0
NB. board=. ,heuristics SHAPE$BOARD
NB. ndx=. I. board ~: BOARD
NB. if. #ndx do.
NB.   ndx=. (?@# { ]) ndx
NB.   BOARD=: (ndx{board) ndx} BOARD
NB.   buffer''
NB.   draw''
NB. else.
NB.   info 'No hint available.'
NB. end.
NB. )

NB. =========================================================
nk_hint_button=: 3 : 0
sel=. hint SHAPE$BOARD
if. #sel do.
  BOARD=: (2{sel) (<SHAPE #. 2{.sel)} BOARD
  buffer''
  draw''
else.
  info 'No hint available.'
end.
)

NB. =========================================================
nk_redo_button=: 3 : 0
BUFPOS=: (<:#BUF) <. >: BUFPOS
BOARD=: BUFPOS pick BUF
draw''
)

NB. =========================================================
nk_restart_button=: 3 : 0
if. 0 = 2 query 'OK to restart?' do.
  BOARD=: 0 pick BUF
  bufinit ''
  draw''
end.
)

NB. =========================================================
nk_solve_button=: 3 : 0
BOARD=: ,bfh SHAPE$BOARD
DONE=: 2
drawboard''
glpaint''
)

NB. =========================================================
nk_undo_button=: 3 : 0
BUFPOS=: 0 >. <: BUFPOS
BOARD=: BUFPOS pick BUF
draw''
)

NB. =========================================================
nk_default=: 3 : 0
if. 'board' -: 5 {. syschild do.
  demoboard 5 }. syschild
end.
)

NB. =========================================================
nk_g_char=: char
nk_g_paint=: drawit
nk_g_mmove=: mmove
nk_g_mbldown=: mbldown
nk_g_mbldbl=: mbldbl

NB. =========================================================
nk_about_button=: 3 : 'info ABOUT'
nk_helpnew_button=: 3 : 'info NEWBOARD'
nk_editcancel_button=: newboardcancel
nk_editok_button=: newboardok
nk_exit_button=: nk_close
nk_openboard_button=: openboard
nk_newboard_button=: newboard
nk_saveboard_button=: saveboard
nk_saveboardas_button=: saveboardas
nk_nctrl_fkey=: newboard
nk_octrl_fkey=: openboard
nk_sctrl_fkey=: saveboard
NB. run
NB.
NB. nurikabe/run argument is either:
NB.   board  (integer matrix)
NB.   name;board
NB.   filename

NB. =========================================================
run=: 3 : 0
name=. file=. ''
if. 0=#y do.
  demoboard 1 return.
end.
if. L.y do.
  'name board'=. y
  if. 0=#board do.
    demoboard 1 return.
  end.
elseif. ischar y do.
  if. 0 = openboard y do.
    nk_close''
  end.
  return.
elseif. do.
  board=. y
end.
if. -.0 validate board do. nk_close'' return. end.
dat=. init board
SHAPE=: $dat
BOARD=: ,dat
FILE=: file
NAME=: name
CARET=: ''
nk_run 0
evtloop^:(-.IFJ6)''
)

NB. =========================================================
nurikabe_z_=: 3 : 0
a=. conew 'pnurikabe'
run__a y
)
