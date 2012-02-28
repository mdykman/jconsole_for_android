NB. J Solitaire
NB. This is the main script for J Solitaire.
NB. This script creates the gamboard and runs the game
NB. Functions are defined before the form is created and the constants are set when the form is run.

NB. Cards are the numbers 0 - 51 -> These two functions return the card suit and the number (Ace to King not 0-51).
suit=: 4 & |
card=: <. @ % & 4

NB. Deal function -> takes an argument of 52 numbers (cards) and assigns the numbers to the appropriate places
deal=: 3 : 0
fliptable=: '' NB. Fliptable holds the data on what cards have been flipped over by clicking on the deck.  This action empties fliptable.
acetable=: '' ; '' ; '' ; '' NB. Acetable holds the data on what cards have been placed in the ace stacks.  This action empties acetable.
DRAGSTACK=: '' NB. Dragstack holds the data on what cards are currently being dragged.  This resets dragstack.
columntable=: (>:i.7){.each(+/\i.7)}.each <y NB. This action fills the 7 stacks with the cards
facetable=: i.7 NB. The face table lists how many cards are face down in the columns.  This resets facetable
decktable=: 28 }. y NB. Decktable holds the data on what cards are in the deck.  This action sets the decktable.
NUMtoFLIP=: NUMFLIP NB. Numflip is the number of cards flipped when the deck is clicked.  NumTOflip is the number of flipped cards being displayed.
WaitTilWon=: y NB. WaitTilWon stores the deal so you can record your winning game and let other people play
)

NB. Clears the isigraph and draws the board for solitaire
drawinit=: 3 : 0
NB. wd 'psel solitaire'
glcmds DRAWINIT
)

NB. make sure no glpaint inside draw1 because it is called by paint event
NB. This function draws the deck, fliptable and aces and calls on drawcolumn and drawdragstack
draw1=: 3 : 0
drawinit''
if. 1 < # decktable do. NB. try lesser of #decktable and 2
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
drawdragstack'' NB. draw DRAGSTACK at DRAGPOS
NB. glpaint ''

if. CheckIfWon acetable do.  NB. everytime the board is drawn the script checks to see if you have won
  acetable=: '' ; '' ; '' ; ''
  draw''
end.
''
)

NB. draw column
drawcolumn=: 3 : 0 "0
s=. >y{columntable             NB. cards in column

if. (0=#s) +. _1-:s do. '' return. end. NB. _1 vs ''
pos=. (cardOVER+cardSPACE*y),34 + cardDOWN + 1 { cardWH
f=. y{facetable               NB. cards face down
upc=. }:f}.s                   NB. cards face up and covered
t=. f-f=#s                     NB. # cards facedown partials
r=. (t*#CBTOP)$CBTOP           NB. face down partial pixels
r=. r,,(CFTOPN,CW){."2 upc{CARDS  NB. face up partial pixels
r=. r,>(f~:#s){CB;,({:s){CARDS    NB. top card (face or back) pixels
r=. pos,71,((CBTOPN*t)+(CFTOPN*#upc)+CH),r
glcmds (2+#r),2076,r
)

NB. draw column
drawdragstack=: 3 : 0
if. 0=#DRAGSTACK do. '' return. end.
s=. >1{DRAGSTACK
pos=. (> 0 { DRAGSTACK) + mousepos''
upc=. }:s                      NB. cards face up and covered
r=. ,(CFTOPN,CW){."2 upc{CARDS    NB. face up partial pixels
r=. r,,>({:s){CARDS               NB. top card pixels
r=. pos,71,(CH+CFTOPN*#upc),r
glcmds (2+#r),2076,r
)

NB. Flip cards -> when the decktable is clicked this action is triggered and it flips the cards.
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

NB. This is a function which returns the position of all playable cards in the columns
ups=: 3 : 0
NB. y = stack/column#
if. _1 < +/ > y { columntable do.
  cardsup=. (y { facetable) }. (> y { columntable)
  cardsxy=. ''
  for_i. cardsup do.
    cardsxy=. cardsxy, ((cardOVER + (cardSPACE * y)),34 + cardDOWN + 1 { cardWH )+((0 5 * y { facetable) + (0 25 * (((> y { columntable) i. i ) - (y { facetable))))
  end.
  cardsxy=. ((0.5 * # cardsxy), 2) $ cardsxy
end.
)

NB. hittest takes the origin of the card (x,y) and checks to see if the card was clicked
hittest=: 4 : 0
NB. mouse data HITTEST ups (or other tables of coordinates)
if. 1 <: # y do.
  if. (*./ 0 < {: (*./"1 [ 0<: x - "1 y) # y) *. (*./ x >: {: (*./"1 [ 0<: x - "1 y) # y) *. [ *./ x <: cardWH + {: (*./"1 [ 0<: x - "1 y) # y do.       NB.
    {: (*./"1 [ 0<: "1 x -"1 y)# y
  else.
    ''
  end.
end.
)

NB. This function uses hittest and ups to find which stack and card was clicked on
findstack=: 3 : 0
NB. findstack pos
for_i. i. 7 do.    NB. when flip and ace is added change this number
  if. 1 < # y hittest ups i do.
    i; (((ups i) i. (y hittest ups i))+ i { facetable) ; y hittest ups i
    return.
  else.
    ''
  end.
end.
)

NB. This verb checks to see if the deck was clicked
finddeck=: 3 : 0
NB. finddeck pos
if. 2 <: # decktable do.
  1 <: # y hittest 1 2 $ (cardOVER, cardDOWN) + 5 3
elseif. 2 > # decktable do.
  1 <: # y hittest 1 2 $ cardOVER, cardDOWN
end.
)

NB. This verb checks to see if the fliptable has been clicked
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

NB. This verb returns the cards to their origonal place if they are dragged to the wrong place.
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

NB. This verb checks to see if the columns are being built correctly (alternating suit color and decremented card number).
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

NB. This verb checks to see if the ace stacks are being built correctly (same suit , increasing number)
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

NB. This verb checks to see if any one of a cards four corners is in a valid area (such as a stack to drop on)
NB. The acecheck has this function built in and this verbonly works for the 7 stacks
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

NB. This verb is similar to ups except it returns the position of a stack with all cardsface down.
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

NB. This verb is similar to findstack but it uses downs to see if a card in the columns needs to be flipped
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

NB. This verb is again similar to ups except it returns the column number of any column that is empty.
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

NB. This runs a hittest on the verb kings
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

NB. This runs a hittest to see if any of the aces have been clicked
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

NB. The verb to check if you won
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

NB. Text for "What's New" pop up
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

NB. The form being created
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

NB. menu rules "&Help" "" "" "";
NB. menusep;

solitaire_run=: 3 : 0
wd SOLITAIRE
NB. initialize form here
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
  NUMFLIP=: 3 NB. Number of cards flipped when deck is clicked
  BGCOLOR=: 0 100 0 NB. Background color
  BAND=: 0
end.
DOWN=: DRAWDOWN=: 0
CARDS=: 3!:2 [ 1!:1 <PATH, '/cards.j31'           NB. If cards.j31 changes directory then update here
NUMtoFLIP=: NUMFLIP
cardOVER=: 15
cardDOWN=: 10
cardSPACE=: 90
CW=: 71
CH=: 96
cardWH=: CW,CH
CFTOPN=: 25 NB. pixel height of partial card face in column display
CB=: ,(51+CARDBACK){CARDS NB. current card back
CBTOPN=: 5 NB. pixles height of partial card back in column display
CBTOP=: (CBTOPN*{.cardWH){.CB NB. current partial card back
xy=. 2 3{".wd'qscreen'
DRAWINIT=: 2 2007 5 2032, BGCOLOR, 2 2004, 6 2031 0 0,xy,6 2031 ,((cardOVER + 3 * cardSPACE), cardDOWN),cardWH, 6 2031 ,((cardOVER + 4 * cardSPACE), cardDOWN),cardWH, 6 2031 ,((cardOVER + 5 * cardSPACE), cardDOWN), cardWH, 6 2031 ,((cardOVER + 6 * cardSPACE), cardDOWN),cardWH
NB. (((cardOVER + 3 * cardSPACE), cardDOWN) + b * cardSPACE, 0 )
9!:1 >.*:+/6!:0'' NB. random seed
deal 52?52 NB. deals a random deck
wd 'pshow ;'
draw''
)

draw=: glpaint@draw1
solitaire_game_paint=: draw1

solitaire_close=: 3 : 0
wd'pclose'
)

mousepos=: 3 : '2 {. ". sysdata'
NB. mouse down events
solitaire_game_mbldown=: 3 : 0
DOWN=: DRAWDOWN=: 1
NB.  Disappearing card ERROR CORRECTED HERE
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

NB. mouse up events
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

NB. mouse move events
solitaire_game_mmove=: 3 : 0
if. (-.BAND) *. 1 < # DRAGSTACK do.
  draw''
end.
)

NB. mouse double-click events
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

NB. error fixed here
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

NB. the verb that is run when deal is selected from the menu
solitaire_deal_button=: 3 : 0
DOWN=: DRAWDOWN=: 0
deal 52?52
drawinit''
draw''
)

NB. Exits the game
solitaire_quit_button=: 3 : 0
solitaire_close''
)

NB. Displays a wdinfo box with my knowledge of the rules (This is triggered by selecting Help | Help)
solitaire_rules_button=: 3 : 0
wdinfo 'Sorry, I do not know the rules either.'
)

NB. About the program
solitaire_about_button=: 3 : 0
about_run''
)

NB. loads the form that allows you to choose a game which has already been won
solitaire_used_button=: 3 : 0
used_run''
)

NB. Restarts the game (similar to deal but uses the same deck as the last game)
solitaire_restart_button=: 3 : 0
if. fexist PATHRECORD do. NB. This IF statement checks to see if the game you were playing was an old game and if so updates the stats on that game.
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

NB. Loads the form to chose your options.  Options are saved in the record file.
solitaire_options_button=: 3 : 0
options_run''
)

NB. Opens the Main.ijs file so users can view and edit the code
solitaire_vm_button=: 3 : 0
open PATH,'/main.ijs'
)

NB. Opens the Used.ijs file so users can view and edit the code
solitaire_vu_button=: 3 : 0
open PATH,'/used.ijs'
)

NB. Opens the Win.ijs file so users can view and edit the code
solitaire_vw_button=: 3 : 0
open PATH,'/win.ijs'
)

NB. Opens the Options.ijs file so users can view and edit the code
solitaire_vo_button=: 3 : 0
open PATH,'/options.ijs'
)

NB. Opens the About.ijs file so users can view and edit the code
solitaire_va_button=: 3 : 0
open PATH,'/about.ijs'
)

solitaire_vr_button=: 3 : 0
open PATH,'/record.txt'
)

solitaire_whtnw_button=: 3 : 0
wd 'mb "Updates" *', WhatNew
)

NB. Runs J Solitaire automaticly when the script is run
solitaire_run''
