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
