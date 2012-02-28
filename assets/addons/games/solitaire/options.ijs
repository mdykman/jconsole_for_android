NB. J Solitaire
NB. This is the options script for J Solitaire
NB. This script creates and runs the options form

NB. Creating the form
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

NB. running the form and setting up the isigraph and numbox
options_run=: 3 : 0
wd OPTIONS
NB. initialize form here
backNUM=: 51 + CARDBACK
wd 'psel options'
wd 'pshow;'
glclear''
glpixels 0 0, cardWH, ,backNUM { CARDS
glpaint''
wd 'set numbox ',": NUMFLIP
wd'set band ',":BAND
wd'set ccstatic *Please enter the number of cards you want to flip each time the deck is clicked. Solitaire is usually played with 1 or 3 cards being turned over each time. However, for this version you can choose any number less than 6.'
tempBGCOLOR=: BGCOLOR
)

NB. This verb closes the options form
options_close=: 3 : 0
wd'pclose'
)

NB. This verb is attached to the spin control (next) and changes the card back being displayed
options_next_button=: 3 : 0
if. ((backNUM + ".next) < 64) *. (backNUM + ".next) > 51 do.
  backNUM=: backNUM+ ".next
end.
wd 'psel options'
glclear''

glpixels 0 0, cardWH, ,backNUM { CARDS
glpaint ''
)

NB. This verb is tied to the ok control and checks to see if the data entered is valid; if so it updates the data.
options_ok_button=: 3 : 0
if. (5 >: ". numbox) *. (1<: ". numbox) *. (". numbox) = <. ". numbox do.
  NUMFLIP=: <. ". numbox
else.
  wdinfo 'Enter a valid number of cards to flip.'
  return.
end.
BAND=: band='1'
CARDBACK=: backNUM - 51
CB=: ,(51+CARDBACK){CARDS NB. current card back
CBTOP=: (CBTOPN*{.cardWH){.CB
BGCOLOR=: tempBGCOLOR
xy=. 2 3{".wd'qscreen'
DRAWINIT=: 2 2007 5 2032, BGCOLOR, 2 2004, 6 2031 0 0,xy,6 2031 ,((cardOVER + 3 * cardSPACE), cardDOWN),cardWH, 6 2031 ,((cardOVER + 4 * cardSPACE), cardDOWN),cardWH, 6 2031 ,((cardOVER + 5 * cardSPACE), cardDOWN), cardWH, 6 2031 ,((cardOVER + 6 * cardSPACE), cardDOWN),cardWH
draw''
FILE=. (<(": CARDBACK),' ', (": NUMFLIP), ' ' , (": BGCOLOR), ' ', ": BAND), }. 'b' fread PATHRECORD
FILE=. ;FILE, each <LF
FILE fwrite PATHRECORD
wd 'psel options'
wd 'pclose'
)

NB. This verb is tied to the cancel control.  It exits without making changes.
options_no_button=: 3 : 0
wd 'psel options'
wd 'pclose'
)

NB. This verb allows the user to launch a color picker to chose the background
options_bgc_button=: 3 : 0
tempBGCOLOR=: wd 'mbcolor'
if. 1 > # tempBGCOLOR do.
  tempBGCOLOR=: BGCOLOR
else.
  tempBGCOLOR=: 3 {. ".tempBGCOLOR
end.
)

