NB. J Solitaire
NB. This is the win script for J Solitaire
NB. This script is run when a game is won and it records the user's name and the deal so others can play it.

NB. Creates the win form
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

NB. Runs the win form
win_run=: 3 : 0
wd WIN
NB. initialize form here
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

NB. Closes the win form
win_close=: 3 : 0
wd'pclose'
)

NB. This verb is used when the submit control is pressed.  It records the deal and the persons name
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

