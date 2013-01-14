require 'gtkwd gl2 files strings'

coclass 'solitaire'
coinsert 'jgl2'

open=: xedit
ABOUT=: 0 : 0
pc about nomax nomenu nomin nosize owner;pn "About Solitaire";
bin vhv;
xywh 10 7 36 48;cc aboutpic isigraph;
bin sz;
xywh 54 6 80 50;cc t static;
bin sz;
xywh 54 60 30 12;cc ok button;cn "OK";
bin z;
pas 6 3;pcenter;
rem form end;
)
about_run=: 3 : 0
wd ABOUT
wd 'psel about'
wd 'setxywhx aboutpic 20 14 ',": cardWH
wd^:(-.IFJ6) 'pshow;pshow sw_hide'
wd'set t *J Solitaire',LF,LF,'Version 3.0 - August 2004',LF,LF,LF,LF,'Created by: Ken Cramer'
wd 'pshow;'
)
about_close=: 3 : 0
wd 'psel about'
wd'pclose'
)
about_ok_button=: 3 : 0
about_close''
)

about_aboutpic_paint=: 3 : 0
glpixels 0 0, cardWH, ,3 { CARDS
0
)
OPTIONS=: 0 : 0
pc options nomax nomenu nomin nosize owner;pn "Options";
xywh 14 17 36 48;cc back isigraph;
xywh 5 6 54 86;cc ccgroupbox groupbox;cn "Card Back";
xywh 68 6 170 86;cc ccgroupbox groupbox;cn "Draw Number";
xywh 183 156 49 12;cc ok button;cn "OK";
xywh 141 76 33 12;cc numbox edit;
xywh 72 18 160 55;cc ccstatic static;
xywh 19 71 24 12;cc next spin;
xywh 129 156 48 12;cc no button;cn "Cancel";
xywh 11 103 130 14;cc band checkbox;cn "Draw Lines (Instead of the Cards) While Dragging";
xywh 10 131 114 12;cc bgc button;cn "Change Background Color";
xywh 19 117 134 14;cc bandtxt static;cn "This Allows for Faster Graphics";
pas 6 6;pcenter;
rem form end;
)

OPTIONSQT=: 0 : 0
pc options nomax nomenu nomin nosize owner qtwd;pn "Options";
bin vhv;
xywh 5 6 54 86;cc ccgroupbox groupbox;cn "Card Back";
bin h;
xywh 14 17 36 48;cc back isigraph;
bin szsh;
xywh 19 71 24 12;cc next button;
bin szzv;
xywh 68 6 170 86;cc ccgroupbox groupbox;cn "Draw Number";
xywh 72 18 160 55;cc ccstatic static;
bin h;
xywh 141 76 33 12;cc numbox edit;
bin szszz;
xywh 11 103 130 14;cc band checkbox;cn "Draw Lines (Instead of the Cards) While Dragging";
xywh 19 117 134 14;cc bandtxt static;cn "This Allows for Faster Graphics";
bin h;
xywh 10 131 114 12;cc bgc button;cn "Change Background Color";
bin szhs;
xywh 129 156 48 12;cc no button;cn "Cancel";
xywh 183 156 49 12;cc ok button;cn "OK";
bin zz;
pas 6 6;pcenter;
rem form end;
)
options_run=: 3 : 0
wd IFQT{::OPTIONS;OPTIONSQT
backNUM=: 51 + CARDBACK
wd^:(-.IFJ6) 'pshow;pshow sw_hide'
glclear''
glpixels 0 0, cardWH, ,backNUM { CARDS
glpaint''
wd 'set numbox ',": NUMFLIP
wd'set band ',":BAND
wd'set ccstatic *Please enter the number of cards you want to flip each time the deck is clicked. Solitaire is usually played with 1 or 3 cards being turned over each time. However, for this version you can choose any number less than 6.'
wd 'pshow;'
tempBGCOLOR=: BGCOLOR
)
options_close=: 3 : 0
wd'pclose'
)
options_next_button=: 3 : 0
if. IFQT do.
  backNUM=: 52 + ?63-52
else.
  if. ((backNUM + ".next) < 64) *. (backNUM + ".next) > 51 do.
    backNUM=: backNUM+ ".next
  end.
end.
glsel 'back'
glclear''

glpixels 0 0, cardWH, ,backNUM { CARDS
glpaint ''
)

options_back_paint=: 3 : 0
glclear''
glpixels 0 0, cardWH, ,backNUM { CARDS
)
options_ok_button=: 3 : 0
if. (5 >: ". numbox) *. (1<: ". numbox) *. (". numbox) = <. ". numbox do.
  NUMFLIP=: <. ". numbox
else.
  wdinfo 'Enter a valid number of cards to flip.'
  return.
end.
BAND=: band='1'
CARDBACK=: backNUM - 51
CB=: ,(51+CARDBACK){CARDS
CBTOP=: (CBTOPN*{.cardWH){.CB
BGCOLOR=: tempBGCOLOR
xy=. 2 3{wdqscreen''
DRAWINIT=: 2 2007 5 2032, BGCOLOR, 2 2004, 6 2031 0 0,xy,6 2031 ,((cardOVER + 3 * cardSPACE), cardDOWN),cardWH, 6 2031 ,((cardOVER + 4 * cardSPACE), cardDOWN),cardWH, 6 2031 ,((cardOVER + 5 * cardSPACE), cardDOWN), cardWH, 6 2031 ,((cardOVER + 6 * cardSPACE), cardDOWN),cardWH
draw''
FILE=. (<(": CARDBACK),' ', (": NUMFLIP), ' ' , (": BGCOLOR), ' ', ": BAND), }. 'b' fread PATHRECORD
FILE=. ;FILE, each <LF
FILE fwrite PATHRECORD
wd 'psel options'
wd 'pclose'
)
options_no_button=: 3 : 0
wd 'psel options'
wd 'pclose'
)
options_bgc_button=: 3 : 0
tempBGCOLOR=: wd 'mbcolor'
if. 1 > # tempBGCOLOR do.
  tempBGCOLOR=: BGCOLOR
else.
  tempBGCOLOR=: 3 {. ".tempBGCOLOR
end.
)
USED=: 0 : 0
pc used nomax nomenu nomin nosize owner;pn "Winning Games";
bin v;
xywh 10 4 156 41;cc ccstatic static;cn "The list below are games which have been won. Please select a game from the list if you would like to play a game that can be won.";
bin h;
xywh 13 48 69 12;cc ccstatic static;cn "Winner's Name";
xywh 93 48 69 12;cc s2 static ss_right;cn "Wins | Losses";
bin z;
xywh 9 63 156 185;cc name listbox ws_border ws_vscroll;
bin h;
xywh 9 254 39 12;cc no button;cn "Cancel";
xywh 51 254 92 12;cc play button;cn "Play The Game!";
bin zz;
xywh 9 63 156 185;cc name listbox ws_border ws_vscroll;
pas 6 6;pcenter;
rem form end;
)
used_run=: 3 : 0
wd USED
NameList=: ''
GameList=: ''
if. fexist PATHRECORD do.
  FILE=. ''
  FILE=. }. 'b' fread PATHRECORD
  for_a. i. # FILE do.
    WINS=. 0 { ".(- <:(#> a{ FILE ) - ((> a { FILE) i: ';')) {. > a { FILE
    LOSES=. (1 { ".(- <:(#> a{ FILE ) - ((> a { FILE) i: ';')) {. > a { FILE) - WINS
    NameList=: NameList,' "', (18 {. (((> a { FILE) i: ':') {. > a { FILE)),'     ',(":WINS),' | ',(":LOSES),'"',LF
    GameList=: GameList, <(>:(> a { FILE) i: ':') }. (- (#> a{ FILE ) - ((> a { FILE) i: ';')) }. > a { FILE
  end.
  if. NameList -: '' do.
    wd 'mb "J Solitaire" "Sorry, there are no Old Games."'
    wd 'psel used'
    wd 'pclose'
    return.
  end.
  wd 'setfont name ',FIXFONT
  wd 'set name ', ,NameList
else.
  wd 'mb "J Solitaire" "Sorry, there are no Old Games."'
  wd 'psel used'
  wd 'pclose'
  return.
end.
wd 'pshow;'
)
used_close=: 3 : 0
wd'pclose'
)
used_play_button=: 3 : 0
if. 1 <: # name do.
  deal ". > ((<;.2 NameList) i. < ' "',name,'"',LF ) { GameList
  b=. ((<;.2 NameList) i. < ' "',name,'"',LF )
  FILE=. }. 'b' fread PATHRECORD
  FILE=. (<((- (#> b{ FILE ) - ((> b { FILE) i: ';')) }. > b { FILE),';',": 0 1 + ".(- <:(#> b{ FILE ) - ((> b { FILE) i: ';')) {. > b { FILE) b } FILE
  FILE=. (0 { 'b' fread PATHRECORD), FILE
  FILE=. ;FILE, each <LF
  FILE fwrite PATHRECORD
  draw''
  wd 'psel used'
  wd 'pclose'
end.
)
used_no_button=: 3 : 0
wd 'psel used'
wd 'pclose'
)
used_name_button=: 3 : 0
used_play_button''
)
WIN=: 0 : 0
pc win nomax nomenu nomin nosize owner;pn "Congratulations!";
bin v;
xywh 8 12 147 10;cc ccstatic static ss_center;cn "Congratulations! You've Won!";
xywh 20 26 120 32;cc ccstatic static ss_center;cn "Please enter your name below so that you can be immortalized in the Solitaire Hall of Fame";
xywh 8 60 147 12;cc name edit;
xywh 8 78 147 11;cc submit button;cn "Submit";
bin z;
pas 6 6;pcenter;
rem form end;
)
win_run=: 3 : 0
wd WIN
if. fexist PATHRECORD do.
  GameList=: ''
  NameList=: ''
  FILE=. }. 'b' fread PATHRECORD
  for_a. i. # FILE do.
    GameList=: GameList, <(>:(> a { FILE) i: ':') }. (- (#> a{ FILE ) - ((> a { FILE) i: ';')) }. > a { FILE
    NameList=: NameList, <(- (#> a{ FILE ) - ((> a { FILE) i: ':')) }. > a { FILE
  end.
  for_b. i. #GameList do.
    if. WaitTilWon -: ". >b { GameList do.
      wd 'mb "J Solitaire" "Congratulations on winning.  Unfortunately ',(> b { NameList),' has already won with this deck."'
      FILE=. (<((- (#> b{ FILE ) - ((> b { FILE) i: ';')) }. > b { FILE),';',": 1 0 + ".(- <:(#> b{ FILE ) - ((> b { FILE) i: ';')) {. > b { FILE) b } FILE
      FILE=. (0 { 'b' fread PATHRECORD), FILE
      FILE=. ;FILE, each <LF
      FILE fwrite PATHRECORD
      wd 'psel win'
      wd 'pclose'
      return.
    end.
  end.
end.
wd 'pshow;'
)
win_close=: 3 : 0
wd'pclose'
)
win_submit_button=: 3 : 0
Info=. ''
if. fexist PATHRECORD do.
  Info=. (fread PATHRECORD)
else.
  Info=. (": CARDBACK),' ', (": NUMFLIP),LF
end.
Info=. Info, name,':',(":WaitTilWon),';', '1 1', LF
Info fwrite PATHRECORD


wd 'set name ""'
wd 'psel win'
wd 'pclose'
)
suit=: 4 & |
card=: <. @ % & 4
deal=: 3 : 0
fliptable=: ''
acetable=: '' ; '' ; '' ; ''
DRAGSTACK=: ''
columntable=: (>:i.7){.each(+/\i.7)}.each <y
facetable=: i.7
decktable=: 28 }. y
NUMtoFLIP=: NUMFLIP
WaitTilWon=: y
)
drawinit=: 3 : 0
glcmds DRAWINIT
)
draw=: 3 : 0
drawinit''
if. 1 < # decktable do.
  glpixels ((cardOVER, cardDOWN), cardWH), CB
  glpixels ((cardOVER, cardDOWN) + 5 3), cardWH, CB
elseif. 1 > # decktable do.
  glpixels (cardOVER, cardDOWN), cardWH, ,65 { CARDS
elseif. 1 = # decktable do.
  glpixels ((cardOVER, cardDOWN), cardWH), CB
end.
if. 1 <: # fliptable do.
  pos=. (cardOVER + cardSPACE), cardDOWN
  if. 1 > NUMtoFLIP do.
    NUMtoFLIP=: 1
  end.
  for_a. |. i. NUMtoFLIP <. # fliptable do.
    glpixels pos, cardWH, ,(a { fliptable) { CARDS
    pos=. pos + 15 3
  end.
end.
for_b. i. # acetable do.
  Ace=. {: > b { acetable
  if. 1 <: # > b { acetable do.
    glpixels (((cardOVER + 3 * cardSPACE), cardDOWN) + b * cardSPACE, 0 ), cardWH, ,Ace { CARDS
  end.
end.


drawcolumn i.7
drawdragstack''
glpaint ''

if. CheckIfWon acetable do.
  acetable=: '' ; '' ; '' ; ''
  draw''
end.
''
)
drawcolumn=: 3 : 0 "0
s=. >y{columntable

if. (0=#s) +. _1-:s do. '' return. end.
pos=. (cardOVER+cardSPACE*y),34 + cardDOWN + 1 { cardWH
f=. y{facetable
upc=. }:f}.s
t=. f-f=#s
r=. (t*#CBTOP)$CBTOP
r=. r,,(CFTOPN,CW){."2 upc{CARDS
r=. r,>(f~:#s){CB;,({:s){CARDS
r=. pos,71,((CBTOPN*t)+(CFTOPN*#upc)+CH),r
glcmds (2+#r),2076,r
)
drawdragstack=: 3 : 0
if. 0=#DRAGSTACK do. '' return. end.
s=. >1{DRAGSTACK
pos=. (> 0 { DRAGSTACK) + mousepos''
upc=. }:s
r=. ,(CFTOPN,CW){."2 upc{CARDS
r=. r,,>({:s){CARDS
r=. pos,71,(CH+CFTOPN*#upc),r
glcmds (2+#r),2076,r
)
flipcards=: 3 : 0
if. NUMFLIP < # decktable do.
  NUMtoFLIP=: NUMFLIP
  fliptable=: (|. (NUMFLIP {. decktable)) , fliptable
  decktable=: NUMFLIP }. decktable
  draw''
elseif. (NUMFLIP >: # decktable) *. (0 < # decktable) do.
  NUMtoFLIP=: # decktable
  fliptable=: (|. > decktable) , fliptable
  decktable=: ''
  draw''
elseif. 1 > # decktable do.
  decktable=: |. fliptable
  fliptable=: ''
  draw''
end.
)
ups=: 3 : 0
if. _1 < +/ > y { columntable do.
  cardsup=. (y { facetable) }. (> y { columntable)
  cardsxy=. ''
  for_i. cardsup do.
    cardsxy=. cardsxy, ((cardOVER + (cardSPACE * y)),34 + cardDOWN + 1 { cardWH )+((0 5 * y { facetable) + (0 25 * (((> y { columntable) i. i ) - (y { facetable))))
  end.
  cardsxy=. ((0.5 * # cardsxy), 2) $ cardsxy
end.
)
hittest=: 4 : 0
if. 1 <: # y do.
  if. (*./ 0 < {: (*./"1 [ 0<: x - "1 y) # y) *. (*./ x >: {: (*./"1 [ 0<: x - "1 y) # y) *. [ *./ x <: cardWH + {: (*./"1 [ 0<: x - "1 y) # y do.
    {: (*./"1 [ 0<: "1 x -"1 y)# y
  else.
    ''
  end.
end.
)
findstack=: 3 : 0
for_i. i. 7 do.
  if. 1 < # y hittest ups i do.
    i; (((ups i) i. (y hittest ups i))+ i { facetable) ; y hittest ups i
    return.
  else.
    ''
  end.
end.
)
finddeck=: 3 : 0
if. 2 <: # decktable do.
  1 <: # y hittest 1 2 $ (cardOVER, cardDOWN) + 5 3
elseif. 2 > # decktable do.
  1 <: # y hittest 1 2 $ cardOVER, cardDOWN
end.
)
findflip=: 3 : 0
if. NUMFLIP <: # fliptable do.
  if. 1 <: # y hittest 1 2 $ ((cardOVER + cardSPACE), cardDOWN) + (NUMtoFLIP - 1) * 15 3 do.
    8; (0 { fliptable) ; y hittest 1 2 $ ((cardOVER + cardSPACE), cardDOWN) + (NUMtoFLIP-1) * 15 3
  else.
    ''
  end.
elseif. NUMFLIP > # fliptable do.
  if. (1 <: # fliptable) *. 1 <: # y hittest 1 2 $ ((cardOVER + cardSPACE), cardDOWN) + (<:# fliptable) * 15 3 do.
    8; (0 { fliptable) ; y hittest 1 2 $ ((cardOVER + cardSPACE), cardDOWN) + (<: # fliptable) * 15 3
  else.
    ''
  end.
end.
)
return=: 3 : 0
if. 6 >: > 2 { DRAGSTACK do.
  returnCOL=. > 2 { DRAGSTACK
  returnCOLdata=. > returnCOL { columntable
  addonDATA=. > 1 { DRAGSTACK
  if. _1 < +/ returnCOLdata do.
    columntable=: (< returnCOLdata , addonDATA) returnCOL } columntable
  else.
    columntable=: (< addonDATA) returnCOL } columntable
  end.
elseif. 8 = > 2 { DRAGSTACK do.
  NUMtoFLIP=: NUMFLIP <. >: NUMtoFLIP
  fliptable=: (> 1 { DRAGSTACK ), fliptable
elseif. 10 <: > 2 { DRAGSTACK do.
  acetable=: (<(> (_10 + > 2 { DRAGSTACK) { acetable), > 1 { DRAGSTACK) (_10 + > 2 { DRAGSTACK) } acetable
end.
)
cardcheck=: 4 : 0
if. (card y) = <: card x do.
  oldCHECK=. *: suit x
  newCHECK=. *: suit y
  if. +./ (1 = oldCHECK + newCHECK),(4 = oldCHECK + newCHECK),(10 = oldCHECK + newCHECK),(13 = oldCHECK + newCHECK) do.
    1
  else.
    0
  end.
else.
  0
end.
)
acecheck=: 4 : 0
WhichAce=. 0 { >./ (findaces (x + 0 , 1 { cardWH)),(findaces (x + cardWH)),(findaces x) , (findaces (x + (0 { cardWH), 0))
if. 1 = # y do.
  if. 0 <: WhichAce do.
    if. 1 > # > WhichAce { acetable do.
      if. 0 = card y do.
        WhichAce
      else.
        _1
      end.
    elseif. ((card y) = >: card _1 { > WhichAce { acetable) *. ((suit y) = suit _1 { > WhichAce { acetable) *. _1 < 0 { > WhichAce { acetable do.
      WhichAce
    elseif. 1 do.
      _1
    end.
  else.
    _1
  end.
else.
  _1
end.
)
four_corners=: 3 :0
pos=. y
if.	1 < # findstack (0 , 1 { cardWH) + pos + > 0 { DRAGSTACK do.
  findstack (0 , 1 { cardWH) + pos + > 0 { DRAGSTACK
elseif. 1 < # findstack cardWH + pos + > 0 { DRAGSTACK do.
  findstack cardWH + pos + > 0 { DRAGSTACK
elseif. 1 < # findstack pos + > 0 { DRAGSTACK do.
  findstack pos + > 0 { DRAGSTACK
elseif. 1 < # findstack ((0 { cardWH) , 0) + pos + > 0 { DRAGSTACK do.
  findstack ((0 { cardWH) , 0) + pos + > 0 { DRAGSTACK
elseif. 1 do.
  ''
end.
)
downs=: 3 : 0
cardsxy=. ''
for_i. i. # columntable do.
  colDATA=. > i { columntable
  faceDATA=. i { facetable
  if. (_1 < +/ colDATA) *. (faceDATA = # colDATA) do.
    cardsxy=. cardsxy, ((cardOVER + (cardSPACE * i)), 34 + cardDOWN+ 1 { cardWH) + (0 5) * faceDATA
  else.
    cardsxy=. cardsxy, _1 _1
  end.
end.
cardsxy=. ((0.5 * # cardsxy), 2) $ cardsxy
)
finddowns=: 3 : 0
for_i. i. # downs'' do.
  downPOSdata=. i { downs''
  if. (0 < +/ downPOSdata) *. (1 < # y hittest 1 2 $ downPOSdata) do.
    i
    return.
  else.
    ''
  end.
end.
)
kings=: 3 : 0
cardsxy=. ''
for_i. i. # columntable do.
  colDATA=. > i { columntable
  if. '' -: colDATA do.
    cardsxy=. cardsxy, (cardOVER + (cardSPACE * i)), 140
  else.
    cardsxy=. cardsxy, _1 _1
  end.
end.
cardsxy=. ((0.5 * # cardsxy), 2) $ cardsxy
)
findkings=: 3 : 0
for_i. i. # kings'' do.
  downPOSdata=. i { kings''
  if. (0 < +/ downPOSdata) *. (1 < # y hittest 1 2 $ downPOSdata) do.
    i
    return.
  else.
    ''
  end.
end.
)
findaces=: 3 : 0
aces=. ''
for_a. i. 4 do.
  aces=. aces, (cardOVER + cardSPACE * 3+a), cardDOWN
end.
aces=. 4 2 $ aces
for_i. aces do.
  if. 1 < # y hittest 1 2 $ i do.
    aces i. i
    return.
  else.
    _1
  end.
end.
)
CheckIfWon=: 3 : 0
Win0=. {: , > 0 { y
Win1=. {: , > 1 { y
Win2=. {: , > 2 { y
Win3=. {: , > 3 { y
if. (1 < # > 0 { acetable) *. (1 < # > 1 { acetable) *. (1 < # > 2 { acetable) *. 1 < # > 3 { acetable do.
  if. (48 <: Win0) *. (48 <: Win1) *. (48 <: Win2) *. (48 <: Win3) do.
    1
  else.
    0
  end.
else.
  0
end.
)
WhatNew=: 0 : 0
J Solitaire v3.0
August 5, 2004

- Disappearing card bug fixed
  Cards no longer disappear after being dragged
  out of the window and then brought back in.

- Ace bug fixed
  Prevents a card, with other cards ontop of it,
  from being placed in the ace piles.

- Draw lines option is now saved to file Record.txt
  Before it was selected based on the computer's OS

- Draw lines option is not saved until the "OK"
  button is clicked.  Before, cancel still saved it.

- New games added (Easy and Medium)
  The previous Easy is now titled "Piece of Cake"

- When an played game is won the winners name
  is displayed in the pop up box

- Record.txt is in the Code menu

- Tropical card back is now startup default

)
SOLITAIRE=: 0 : 0
pc solitaire;pn "J Solitaire";
menupop "&File";
menu deal "&Deal" "" "" "";
menu restart "&Restart" "" "" "";
menusep;
menu used "&Winning Games" "" "" "";
menusep;
menu options "&Options" "" "" "";
menusep;
menu quit "&Exit" "" "" "";
menupopz;
menupop "&Code";
menu vm "&Main.ijs" "" "" "";
menu vu "&Used.ijs" "" "" "";
menu vw "&Win.ijs" "" "" "";
menu vo "&Options.ijs" "" "" "";
menu va "&About.ijs" "" "" "";
menu vr "&Record.txt" "" "" "";
menupopz;
menupop "&Help";
menu whtnw "&What's New" "" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
xywh 0 0 323 270;cc game isigraph rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)
solitaire_run=: 3 : 0
wd SOLITAIRE
PATH=: jpath '~addons/games/solitaire'
PATHRECORD=: jpath PATH,'/record.txt'
if. fexist PATHRECORD do.
  FILE=. ". > {. 'b' fread PATHRECORD
  CARDBACK=: 0 { FILE
  NUMFLIP=: 1 { FILE
  BGCOLOR=: 2 }. 5 {. FILE
  BAND=: 5 { FILE
  if. BAND = 3 do. BAND=:0 end.
else.
  CARDBACK=: 1
  NUMFLIP=: 3
  BGCOLOR=: 0 100 0
  BAND=: 0
end.
DOWN=: DRAWDOWN=: 0
CARDS=: 3!:2 [ 1!:1 <PATH, '/cards.j31'
if. -.IFJ6 do.
  if. -.RGBSEQ_j_ do. CARDS=: fliprgb CARDS end.
end.
NUMtoFLIP=: NUMFLIP
cardOVER=: 15
cardDOWN=: 10
cardSPACE=: 90
CW=: 71
CH=: 96
cardWH=: CW,CH
CFTOPN=: 25
CB=: ,(51+CARDBACK){CARDS
CBTOPN=: 5
CBTOP=: (CBTOPN*{.cardWH){.CB
xy=. 2 3{wdqscreen''
DRAWINIT=: 2 2007 5 2032, BGCOLOR, 2 2004, 6 2031 0 0,xy,6 2031 ,((cardOVER + 3 * cardSPACE), cardDOWN),cardWH, 6 2031 ,((cardOVER + 4 * cardSPACE), cardDOWN),cardWH, 6 2031 ,((cardOVER + 5 * cardSPACE), cardDOWN), cardWH, 6 2031 ,((cardOVER + 6 * cardSPACE), cardDOWN),cardWH
9!:1 >.*:+/6!:0''
deal 52?52
wd^:(-.IFJ6) 'pshow;pshow sw_hide'
draw''
wd 'pshow'
evtloop^:(-.IFJ6)''
)

solitaire_game_paint=: draw

solitaire_close=: 3 : 0
wd'pclose'
)

mousepos=: 3 : '2 {. ". sysdata'
solitaire_game_mbldown=: 3 : 0
DOWN=: DRAWDOWN=: 1
if. 1 < # DRAGSTACK do.
  solitaire_game_mblup''
end.

if. BAND do. glcapture 2 end.
pos=. mousepos''

if. finddeck pos do.
  flipcards''
elseif. 1 < # findflip pos do.
  DRAGSTACK=: ((> 2 { findflip pos) - pos) ; ((0 { fliptable) ) ; > 0{ findflip pos
  fliptable=: }. fliptable
  NUMtoFLIP=: <: NUMtoFLIP
elseif. 1 <: # finddowns pos do.
  facetable=: (0>.<: (finddowns pos) { facetable) (finddowns pos) } facetable
elseif. 0 <: findaces pos do.
  if. 0=#> (findaces pos) { acetable do. return. end.
  AceCard=. _1 { > (findaces pos) { acetable
  AcePos=. (((cardOVER + 3* cardSPACE), cardDOWN) + (findaces pos) * cardSPACE, 0) - pos
  AceFrom=. 10 + findaces pos
  DRAGSTACK=: AcePos ; AceCard ; AceFrom
  acetable=: (< }: > (findaces pos) { acetable) (findaces pos) } acetable
elseif. 1 < # findstack pos do.
  stackNUM=. > 0 { findstack pos
  stackDATA=. > stackNUM { columntable
  stackCARDplace=. > 1 { findstack pos
  stackCARD=. stackCARDplace { stackDATA
  stackOFFSET=. (> 2 { findstack pos) - pos
  dragCARDdata=. (stackCARDplace - # stackDATA) {. stackDATA
  DRAGSTACK=: stackOFFSET; dragCARDdata ; stackNUM
  columntable=: (<(stackCARDplace - # stackDATA) }. stackDATA) stackNUM } columntable
end.
)
solitaire_game_mblup=: 3 : 0
DOWN=: DRAWDOWN=: 0
if. BAND do. glcapture 0 end.
pos=. mousepos''
if. 1 < # DRAGSTACK do.
  newSTACKdata=. four_corners pos
  if. 0 <: ((pos + > 0 { DRAGSTACK) acecheck (> 1 { DRAGSTACK)) do.
    aceSUIT=. (pos + > 0 { DRAGSTACK) acecheck > 1 { DRAGSTACK
    suitDATA=. , > aceSUIT { acetable
    acetable=: ( < suitDATA , > 1 { DRAGSTACK) aceSUIT } acetable
  elseif. (1 <: # findkings pos) *. 12 = card 0 { > 1 { DRAGSTACK do.
    columntable=: (1 { DRAGSTACK) (findkings pos) } columntable
  elseif. (1 < # newSTACKdata) do.
    newSTACKnum=. > 0 { newSTACKdata
    newSTACKcards=. > newSTACKnum { columntable
    if. (_1 { newSTACKcards) cardcheck 0 { > 1 { DRAGSTACK do.
      if. (<: # newSTACKcards) = > 1 { newSTACKdata do.
        if. _1 = +/ newSTACKcards do.
          return''
        else.
          columntable=: (< newSTACKcards, > 1 { DRAGSTACK) newSTACKnum } columntable
        end.
      else.
        return''
      end.
    else.
      return''
    end.
  elseif. 1 do.
    return''
  end.
end.
DRAGSTACK=: ''
draw''
)
solitaire_game_mmove=: 3 : 0
if. (-.BAND) *. 1 < # DRAGSTACK do.
  draw''
end.
)
solitaire_game_mbldbl=: 3 : 0
pos=. mousepos''
if. finddeck pos do.
  flipcards''
  return.
elseif. 1 < # findflip pos do.
  for_a. i. # acetable do.
    if. 1 > # > a { acetable do.
      if. 0 = card 0 { fliptable do.
        acetable=: (< 0 { fliptable) a } acetable
        fliptable=: }. fliptable
        NUMtoFLIP=: <: NUMtoFLIP
        return.
      end.
    elseif. ((suit _1 { > a { acetable) = suit 0 { fliptable) *. (card _1 { > a { acetable) = <: card 0 { fliptable do.
      acetable=: (< (> a { acetable), 0 { fliptable) a } acetable
      fliptable=: }. fliptable
      NUMtoFLIP=: <: NUMtoFLIP
      return.
    end.
  end.
elseif. 1 <: # finddowns pos do.
  facetable=: (0>.<: (finddowns pos) { facetable) (finddowns pos) } facetable
elseif. 1 < # findstack pos do.
  stackNUM=. > 0 { findstack pos
  stackDATA=. > stackNUM { columntable
  stackCARDplace=. > 1 { findstack pos
  stackCARD=. stackCARDplace { stackDATA
  if. stackCARDplace = _1+ # > stackNUM { columntable do.

    for_b. i. # acetable do.
      if. 1 > # > b { acetable do.
        if. 0 = card stackCARD do.
          acetable=: (< stackCARD) b } acetable
          columntable=: (<(stackCARDplace - # stackDATA) }. stackDATA) stackNUM } columntable
          return.
        end.
      elseif. ((suit _1 { > b { acetable) = suit stackCARD) *. (card _1 { > b { acetable) = <: card stackCARD do.
        acetable=: (< (> b { acetable), stackCARD) b } acetable
        columntable=: (<(stackCARDplace - # stackDATA) }. stackDATA) stackNUM } columntable
        return.
      end.
    end.

  else.
    return.
  end.

end.
)
solitaire_deal_button=: 3 : 0
DOWN=: DRAWDOWN=: 0
deal 52?52
drawinit''
draw''
)
solitaire_quit_button=: 3 : 0
solitaire_close''
)
solitaire_rules_button=: 3 : 0
wdinfo 'Sorry, I do not know the rules either.'
)
solitaire_about_button=: 3 : 0
about_run''
)
solitaire_used_button=: 3 : 0
used_run''
)
solitaire_restart_button=: 3 : 0
if. fexist PATHRECORD do.
  GameList=: ''
  FILE=. }. 'b' fread PATHRECORD
  for_a. i. # FILE do.
    GameList=: GameList, <(>:(> a { FILE) i: ':') }. (- (#> a{ FILE ) - ((> a { FILE) i: ';')) }. > a { FILE
  end.
  for_b. i. #GameList do.
    if. WaitTilWon -: ". >b { GameList do.
      FILE=. (<((- (#> b{ FILE ) - ((> b { FILE) i: ';')) }. > b { FILE),';',": 0 1 + ".(- <:(#> b{ FILE ) - ((> b { FILE) i: ';')) {. > b { FILE) b } FILE
      FILE=. (0 { 'b' fread PATHRECORD), FILE
      FILE=. ;FILE, each <LF
      FILE fwrite PATHRECORD
    end.
  end.
end.

DOWN=: DRAWDOWN=: 0
deal WaitTilWon
drawinit''
draw''
)
solitaire_options_button=: 3 : 0
options_run''
)
solitaire_vm_button=: 3 : 0
open PATH,'/main.ijs'
)
solitaire_vu_button=: 3 : 0
open PATH,'/used.ijs'
)
solitaire_vw_button=: 3 : 0
open PATH,'/win.ijs'
)
solitaire_vo_button=: 3 : 0
open PATH,'/options.ijs'
)
solitaire_va_button=: 3 : 0
open PATH,'/about.ijs'
)

solitaire_vr_button=: 3 : 0
open PATH,'/record.txt'
)

solitaire_whtnw_button=: 3 : 0
wd 'mb "Updates" *', WhatNew
)
solitaire_run''
