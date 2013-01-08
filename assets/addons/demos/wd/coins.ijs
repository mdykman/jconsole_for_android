NB. init

require 'droidwd gtkwd gl2 wdclass'

coclass 'jcoins'


coinsert 'jgl2 wdbase'
droidwd_run=: coins_run

BOARD=: 0

NB. =========================================================
init=: 3 : 0
getboard ''
DONE=: 0
HIGH=: ''
LASTEMPTY=: ''
BUFFER=: ,<POS
BUFNDX=: COUNT=: 0
MBRDOWN=: 0
getmoves''
ENDPOS=: EMPTY
)

NB. util

getnum=: 3 : '".;._2 [ 0 : 0'
index1=: # (| - =) i.&1
intersect=: e. # [
intable=: +./"1 @: =
isempty=: 0: e. $
lookup=: (= {."1) # {:"1@]
round=: [ * [: <. 0.5"_ + %~
roundint=: <. @: +&0.5
where=: #~

info=: sminfo @ ('Coins'&;)
query=: wdquery 'Coins'&;

NB. =========================================================
NB. colors:
COLORSTD=: getnum''
192 0 0
192 192 192
0 192 0
0 0 192
)

COLORHIGH=: getnum''
248 0 0
240 240 240
0 248 0
0 160 248
)

NB. =========================================================
clearmark=: 3 : 0
if. #HIGH do.
  HIGH=: ''
  paint''
end.
)

NB. =========================================================
NB. get board
getboard=: 3 : 0
'COLORS LAYOUT POS MOVES'=: ". 'BOARD',": BOARD
CLRSTD=: COLORS { COLORSTD
CLRHIGH=: COLORS { COLORHIGH
ALLPOS=: i. #LAYOUT
NB. split MOVES into color and positions:
MOVECLR=: {."1 MOVES
MOVEPOS=: }."1 MOVES
)

NB. =========================================================
gethit=: 3 : 0
ACTIVECTR inrect 2 {. 0 ". sysdata
)

NB. =========================================================
NB. get active positions (that can move to empty)
getmoves=: 3 : 0
EMPTY=: {. ALLPOS -. {:"1 POS
msk=. +/"1 EMPTY = MOVEPOS
pot=. (msk # MOVECLR) ,. (msk # MOVEPOS) -."1 EMPTY
ACTIVE=: EMPTY -.~ , }."1 pot intersect POS
)

NB. =========================================================
NB. test rects for hit
NB. form: centers inrects pos
NB. returns hit index, or _1 if none
inrect=: 4 : 0
index1 *./"1 RAD >: | x -"1 y
)

NB. =========================================================
setparentname=: 3 : 0
wd 'pn *Coins ',BOARD pick BOARDS
)


NB. boards
NB.
NB. stored as 4 items:
NB.   color      indices (first color has to move to empty space)
NB.   layout     xy pairs
NB.   positions  token positions as: color, layout index
NB.   moves      color, end 1, end 2
BOARDS=: '8-2-48';'8-3-44';'9-2-66';'11-2-118'
BOARDIDS=: 'b' (,":) each i.#BOARDS

NB. =========================================================
NB. board0 = 8-2-48

COLORS=: 0 1

LAYOUT=: getnum''
0 0
2 9
8 9
7 6
3 6
5 4
5 2
10 0
)

POS=: getnum''
0 0
0 6
1 1
1 3
1 4
1 5
1 7
)

MOVES=: getnum''
0 0 1
0 0 6
0 1 2
0 3 4
0 3 7
0 4 5
0 6 7
1 0 4
1 0 5
1 0 7
1 1 3
1 1 4
1 2 3
1 5 6
1 5 7
)

BOARD0=: COLORS;LAYOUT;POS;MOVES

NB. =========================================================
NB. board1 =  8-3-44

COLORS=: 3 2 0

LAYOUT=: getnum''
0 0
2 0
0 2
2 2
4 2
0 4
2 4
4 4
)

POS=: getnum''
0 7
1 5
1 6
2 1
2 2
2 3
2 4
)

MOVES=: getnum''
0 0 2
0 2 6
0 6 7
1 0 3
1 2 3
1 3 4
1 4 6
1 5 6
2 0 1
2 1 3
2 1 4
2 2 5
2 3 6
2 4 7
)

BOARD1=: COLORS;LAYOUT;POS;MOVES

NB. =========================================================
NB. board2 =  9-2-66

COLORS=: 1 0

LAYOUT=: getnum''
1 0
7 0
4 2
2 3
6 3
0 4
4 4
8 4
4 6
)

POS=: getnum''
0 0
0 2
1 1
1 4
1 5
1 6
1 7
1 8
)

MOVES=: getnum''
0 0 2
0 0 5
0 1 4
0 1 7
0 2 6
0 3 6
0 4 8
0 5 8
1 0 1
1 0 3
1 1 2
1 2 4
1 3 5
1 3 8
1 4 6
1 7 8
)

BOARD2=: COLORS;LAYOUT;POS;MOVES

NB. =========================================================
NB. board3 = 11-2-118

COLORS=: 1 0

LAYOUT=: getnum''
1 0
9 0
5 2
2 4
8 4
5 5
0 7
10 7
3 8
7 8
5 11
)

POS=: getnum''
0 2
0 5
1 0
1 1
1 3
1 4
1 6
1 7
1 8
1 9
)

MOVES=: getnum''
0 0 1
0 0 3
0 1 7
0 2 3
0 2 4
0 3 8
0 4 5
0 5 6
0 6 10
0 7 9
0 8 9
1 0 6
1 1 2
1 1 4
1 3 5
1 3 6
1 4 7
1 5 8
1 7 10
1 8 10
1 9 10
)

BOARD3=: COLORS;LAYOUT;POS;MOVES


NB. draw

FATPEN=: 6 0

NB. =========================================================
NB. paint does the draw and then glpaint
paint=: 3 : 0
draw''
glpaint`glpaintx@.('Android'-:UNAME)''
)

NB. =========================================================
draw=: 3 : 0
drawcenters''
drawnet''
wd 'set cnt ',":BUFNDX
wd 'setenable restart ',":COUNT > 0
wd 'setenable undo ',":BUFNDX > 0
wd 'setenable redo ',":BUFNDX < COUNT
wd ; ';set '&, each BOARDIDS ,each ' ' ,each ": each BOARD=i.#BOARDS
wd 'setfocus g'
getmoves''
ACTIVECTR=: ACTIVE { CTR
)

NB. =========================================================
NB. drawcenters v calculate vertex centers in display
drawcenters=: 3 : 0
max=. >./ LAYOUT
wh=. _2 {. wdqchildxywhx 'g'
wh=. glqwh''
div=. wh % 2 + max
rad=. -: <./div <. wh % 12
RAD=: roundint rad
RAD2=: 0 >. RAD - 5 >. 2 round 0.2 * rad
x=. ({.div) * 1 + {."1 LAYOUT
y=. ({:div) * 1 + ({:max) - {:"1 LAYOUT
CTR=: roundint x,.y
)

NB. =========================================================
NB. drawnet v draw the network
drawnet=: 3 : 0
glclear''
mxy=. MOVECLR </. MOVEPOS

NB. lines
for_i. i.#mxy do.
  glpen FATPEN [ glrgb i { CLRSTD
  gllines ,"2 CTR {~ i pick mxy
end.

NB. vertices
CRC=: (CTR-RAD) ,"1 +:RAD,RAD
glpen 1 0 [ glrgb 0 0 0
glbrush glrgb 255 255 255
glrect CRC

NB. end vertex
glpen FATPEN [ glrgb {.CLRSTD
glrect 0 0 1 1 + ENDPOS { CRC

NB. tokens
glpen 1 0 [ glrgb 0 0 0
CRC2=: (CTR-RAD2) ,"1 +:RAD2,RAD2
for_i. i.#mxy do.
  glbrush glrgb i { CLRSTD
  glrect (i lookup POS) { CRC2
end.
)


NB. help

NB. =========================================================
ABOUT=: 0 : 0
These are Bob Hearn's Coin Puzzles, featured in www.mathpuzzle.com on 21 Nov 2005.
They are copyright Bob Hearn 2005, and used with permission.

The original puzzles use round tokens (the coins). Here, square tokens are used
for a crisper screen display, otherwise the puzzles are the same.

The name '8-2-48' refers to 8 vertices, 2 colors, solvable in 48 moves.

)

NB. =========================================================
HELP=: 0 : 0
The marked square is initially empty. The goal is to slide a token of the
same color into the marked square.

Tokens can only slide along matching edges. Click on a token to move it.

A right click anywhere will move the only possible new move, or highlight
possible new moves if more than one. If no new move is available, it will
undo the previous move.

)


NB. mouse handling

NB. =========================================================
mmove=: 3 : 0
if. DONE do. return. end.
ndx=. gethit''
if. MBRDOWN < ndx < 0 do.
  clearmark''
else.
  drawhigh ndx { ACTIVE
end.
)

NB. =========================================================
mbldown=: 3 : 0
MBRDOWN=: 0
if. DONE do. return. end.
ndx=. gethit''
if. ndx < 0 do. return. end.
movemark ndx { ACTIVE
)

NB. =========================================================
drawhigh=: 3 : 0
HIGH=: POS where ({:"1 POS) e. y
for_p. HIGH do.
  'c x'=. p
  glbrush glrgb c { CLRHIGH
  glrect x { CRC2
end.
glpaint`glpaintx@.('Android'-:UNAME)''
)

NB. =========================================================
mbrdown=: 3 : 0
MBRDOWN=: 1
coin_helper''
)

NB. =========================================================
mbrup=: 3 : 0
MBRDOWN=: 0
clearmark''
)


NB. move

NB. =========================================================
NB. movemark v move the marked coin
movemark=: 3 : 0
pos=. {.y
mov=. sort pos,.EMPTY
clr=. MOVECLR {~ MOVEPOS i. mov
DONE=: (clr=0) *. EMPTY = ENDPOS
POS=: (clr,EMPTY), POS -. clr,pos
LASTEMPTY=: EMPTY
COUNT=: BUFNDX=: >: BUFNDX
BUFFER=: (BUFNDX {. BUFFER), <POS
paint''
if. DONE do.
  info 'Finished.'
end.
)


NB. win

COIN=: 0 : 0
pc coin qtwd;pn "Coins";
menupop "File";
menu b0 "&Load 8-2-48" "" "" "";
menu b1 "&Load 8-3-44" "" "" "";
menu b2 "&Load 9-2-66" "" "" "";
menu b3 "&Load 11-2-118" "" "" "";
menusep;
menu viewcode "&View Code" "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
menupop "Help";
menu help "&Help" "" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
bin vh;
xywh 2 1 39 12;cc restart button;cn "Restart";
xywh 41 1 39 12;cc undo button;cn "Undo";
xywh 80 1 39 12;cc redo button;cn "Redo";
xywh 120 3 36 11;cc cnt static ss_center;cn "";
xywh 0 14 250 1;cc s0 staticbox ss_etchedhorz rightmove ;
bin sz;
xywh 0 15 250 250;cc g isigraph rightmove bottommove;
bin z;
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
coin_run=: 3 : 0
DONE=: 0
wd COIN
setparentname''
wd^:(-.IFJ6) 'pshow;pshow sw_hide'
paint''
wd 'pshow;'
evtloop^:(-.IFJ6)''
)

NB. =========================================================
coin_helper=: 3 : 0
act=. ACTIVE -. LASTEMPTY
select. #act
case. 0 do.
  coin_undo_button''
case. 1 do.
  movemark act
case. do.
  drawhigh act
end.
)

NB. =========================================================
coin_newbutton=: 3 : 0
BOARD=: y
init''
setparentname''
paint''
)

coin_b0_button=: coin_newbutton bind 0
coin_b1_button=: coin_newbutton bind 1
coin_b2_button=: coin_newbutton bind 2
coin_b3_button=: coin_newbutton bind 3

NB. =========================================================
coin_redo_button=: 3 : 0
BUFNDX=: (<:#BUFFER) <. >: BUFNDX
POS=: BUFNDX pick BUFFER
paint''
)

NB. =========================================================
coin_restart_button=: 3 : 0
if. IFQT+.'Android'-:UNAME do. paint@init '' return. end.
if. 0 = 2 query`0:@.(IFQT+.'Android'-:UNAME) 'OK to restart?' do.
  init''
  paint''
end.
)

NB. =========================================================
coin_viewcode_button=: 3 : 0
fview jpath '~addons/demos/wd/coins.ijs'
)

NB. =========================================================
coin_undo_button=: 3 : 0
BUFNDX=: 0 >. <: BUFNDX
POS=: BUFNDX pick BUFFER
paint''
)

NB. =========================================================
coin_g_paint=: draw
coin_g_mmove=: mmove
coin_g_mbldown=: mbldown
coin_g_mbrdown=: mbrdown
coin_g_mbrup=: mbrup
coin_close=: wd bind 'pclose'
coin_exit_button=: coin_close
coin_about_button=: 3 : 'info ABOUT'
coin_help_button=: 3 : 'info HELP'


NB. run

NB. =========================================================
coins_run=: 3 : 0
init''
coin_run''
)

coins_run`start_droidwd@.('Android'-:UNAME) coname''
