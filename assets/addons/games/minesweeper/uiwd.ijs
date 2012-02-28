NB. wd GUI for Minesweeper game
NB. works for jwdw and jwdp J6 front ends.

Note 'Example commands to run'
  MinesweeperWd ''
  MinesweeperWd 12 12
)
MinesweeperWd_z_=: conew&'mineswpwd'

3 : 0''
  if. IFJ6 do.
    require 'media/platimg gl2'
    require 'games/minesweeper/minefield'
    coclass 'mineswpwd'
    coinsert 'mineswp';'pplatimg';'jgl2'

    AddonPath=. jpath '~addons/games/minesweeper/'
NB. Tiles=: ,((2 2 $ #) <;._3 ]) readimg AddonPath,'tiles18.png'
    Tiles=: ,((2 2 $ #) <;._3 ]) readimg AddonPath,'tiles26.png'
  else.
    require 'gui/gtkwd'
    require 'games/minesweeper/minefield'
    coclass 'mineswpwd'
    coinsert 'mineswp';'jgl2'

    AddonPath=. jpath '~addons/games/minesweeper/'
NB. Tiles=: ,((2 2 $ #) <;._3 ]) readimg_jgtk_ AddonPath,'tiles18.png'
    Tiles=: ,((2 2 $ #) <;._3 ]) readimg_jgtk_ AddonPath,'tiles26.png'
  end.
  ''
)

NB. Form definition
MSWD=: 0 : 0
pc mswd;pn "Minesweeper";
menupop "Game";
menu new "&New Game" "" "" "";
menu options "&Options" "" "" "";
menusep;
menu exit "&Quit" "" "" "";
menupopz;
menupop "Help";
menu help "&Instructions" "" "" "";
menu about "&About" "" "" "";
menupopz;
sbar 1;sbarshow 1;
xywh 0 0 90 90;cc isifld isigraph rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)

NB. Methods
NB. =========================================================

create=: 3 : 0
  wd MSWD
  newMinefield y
  'isend msg'=. eval''
  wd 'sbarset status 80 "',msg,'"'
  mswd_update@resizeFrm ''
  wd 'pshow'
)

destroy=: 3 : 0
  wd 'pclose'
  codestroy ''
)

mswd_startnew=: mswd_update@newMinefield

mswd_update=: 3 : 0
  'isend msg'=. eval ''
  IsEnd=: isend
  wd 'sbarset status -1 *',msg
  if. isend do. 
    wdinfo 'Game Over';msg 
    msg=. ('K'={.msg) {:: 'won';'lost'
    wd 'sbarset status -1 * You ',msg,'! Try again?'
  end.
  wd 'setinvalid isifld'
  empty''
)

resizeFrm=: 3 : 0
  isisz=. (#>{.Tiles)*$Map
  frmsz=. (21 81 + isisz) ,~ 2{. 0". wd 'qformx'
  wd 'pmovex ',": frmsz
)

getTileIdx=: [: >:@:<. (#>{.Tiles) %~ 2 {. 0&".

NB. Event Handlers
NB. =========================================================

mswd_new_button=: 3 : 0
  mswd_startnew $Map
)

mswd_exit_button=: destroy
mswd_close=: destroy
mswd_cancel=: destroy

mswd_isifld_paint=: 3 : 0
  if. IFJ6 do.
    'isifld' glimgrgb ; ,.&.>/"1 Tiles showField IsEnd
  else.
    imgpixels=. ; ,.&.>/"1 Tiles showField IsEnd               NB. get matrix of argb values to paint
    glpixels 0 0,((#>{.Tiles)*$Map), , imgpixels  NB. the real 'paint'
  end.
)

mswd_isifld_mblup=: 3 : 0
  if. +./ IsEnd , ($Map)<idx=. getTileIdx sysdata do. return. end.
  mswd_update@clearTiles idx
)

mswd_isifld_mbrup=: 3 : 0
  if. +./ IsEnd , ($Map)<idx=. getTileIdx sysdata do. return. end.
  mswd_update@markTiles idx
)

mswd_about_button=: 3 : 0
  wdinfo 'About Minesweeper';About
)

mswd_help_button=: 3 : 0
  wdinfo 'Minesweeper Instructions';Instructions
)

NB. Text Nouns
NB. =========================================================

Instructions=: 0 : 0
Object: 
   Uncover (clear) all the tiles that are not mines.

How to play:
 - click on a tile to clear it
 - right-click on a tile to mark it as a suspected mine
 - if you uncover a number, that is the number of mines adjacent 
    to the tile
 - if you uncover a mine the game ends (you lose)
 - if you uncover all tiles that are not mines the game ends (you win).
)

About=: 0 : 0
Minesweeper Game
Author: Ric Sherlock

Uses J6 Window Driver for GUI
)

NB. Auto-run UI
NB. =========================================================
cocurrent 'base'
MinesweeperWd ''
