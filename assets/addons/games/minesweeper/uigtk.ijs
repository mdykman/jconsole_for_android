NB. Gtk user interface for Minesweeper game
NB. works with J7 gui/gtk addon (either from GtkIDE or console).

Note 'Example commands to run'
  MinesweeperGtk ''
  MinesweeperGtk 12 12
)
MinesweeperGtk_z_=: conew&'mineswpgtk'

require 'gui/gtk'
require 'games/minesweeper/minefield'
coclass 'mineswpgtk'
coinsert 'mineswp';'jgtk'

AddonPath=. jpath '~addons/games/minesweeper/'
Tiles=: ,((2 2 $ #) <;._3 ]) readimg AddonPath,'tiles26.png'

NB. Methods
NB. =========================================================

create=: 3 : 0
  if. -.IFGTK do. gtkinit'' end.
  newMinefield y
  IsEnd=: 0

  newwindow 'Minesweeper GTK'                         NB. create new window with Title
  consig window;'destroy';'window_destroy'            NB. assign event handler for event
  box1=. gtk_vbox_new 0 0                             NB. create vertical box container for widgets
  gtk_container_add window, box1                      NB. Add the container to the window
NB. menu bar
  menu_init''
  mb=. edit_menu''
  gtk_box_pack_start box1, mb, 0 0 0                  NB. pack menubar in the vertical box
NB. drawing area
  gtkda=: gtk_drawing_area_new''
  gtk_widget_set_size_request gtkda,((#>{.Tiles)*$Map)
  NB. GDK_LEAVE_NOTIFY_MASK,GDK_POINTER_MOTION_HINT_MASK
  events=. GDK_EXPOSURE_MASK,GDK_BUTTON_PRESS_MASK,GDK_BUTTON_RELEASE_MASK,GDK_POINTER_MOTION_MASK
  gtk_widget_add_events gtkda, OR events
  if. 3=GTKVER_j_ do.
    consig3 gtkda;'draw';'gtkda_minefld_draw'
  else.
    consig3 gtkda;'expose_event';'gtkda_minefld_expose_event'
  end.
  consig3 gtkda;'button_release_event';'gtkda_minefld_button_release_event'
  gtk_box_pack_start box1, gtkda, 1 1 0               NB. pack drawing area in the vertical box
NB. status bar
  GtkSbar=: gtk_statusbar_new ''
  SbarContxt=: gtk_statusbar_get_context_id GtkSbar;'msg'
  gtk_box_pack_start box1, GtkSbar, 0 0 0             NB. pack statusbar in the vertical box
  windowfinish''

  msgtk_update''
  if. -.IFGTK do. gtk_main'' end.
)

destroy=: 3 : 0
  cbfree''
  codestroy''
)

msgtk_startnew=: msgtk_update@newMinefield

msgtk_update=: 3 : 0
  'isend msg'=. eval ''
  IsEnd=: isend
  gtk_widget_queue_draw gtkda
  updateStatusbar msg
  if. isend do.
    mbinfo 'Game Over';msg
    msg=. ('K'={.msg) {:: 'won';'lost'
    updateStatusbar 'You ',msg,'! Try again?'
  end.
)

updateStatusbar=: 3 : 0
  gtk_statusbar_pop GtkSbar;SbarContxt   NB. clear last msg
  gtk_statusbar_push GtkSbar;SbarContxt;y
)

getTileIdx=: [: >:@:<. (#>{.Tiles) %~ 2 {. 0&".
gettext=: ]

NB. Event Handlers
NB. =========================================================

window_delete=: 0:

window_destroy=: 3 : 0
  if. -.IFGTK do. gtk_main_quit '' end.
  destroy ''
  0
)

NB. drawing area expose events
NB. ---------------------------------------------------------
NB. gtkwin      gtkda window
NB. gtkwh
gtkda_minefld_draw=: gtkda_minefld_expose_event=: 3 : 0
  'widget event data'=. y
  NB. house keeping
  gtkwh=. 2 3{getGtkWidgetAllocation widget
  if. 3=GTKVER_j_ do.
    cr=. event
    cr pixbufcr_setpixels 0 0,gtkwh,(*/gtkwh)#0                NB. reset background
    imgpixels=. ; ,.&.>/"1 Tiles showField IsEnd               NB. get matrix of argb values to paint
    cr pixbufcr_setpixels 0 0,((#>{.Tiles)*$Map), , imgpixels  NB. the real 'paint'
  else.
    gtkwin=. getGtkWidgetWindow widget
    gtkwin pixbufwin_setpixels 0 0,gtkwh,(*/gtkwh)#0                NB. reset background
    imgpixels=. ; ,.&.>/"1 Tiles showField IsEnd                    NB. get matrix of argb values to paint
    gtkwin pixbufwin_setpixels 0 0,((#>{.Tiles)*$Map), , imgpixels  NB. the real 'paint'
  end.
)

NB. drawing area mouse events
NB. ---------------------------------------------------------
gtkda_minefld_button_release_event=: 3 : 0
'widget event data'=. y
  'button type x1 y1 w h state'=. get_button_event_data event
  if. +./ IsEnd , ($Map)<idx=. getTileIdx ":x1,y1 do. return. end.
  select. button
    case. 1 do. msgtk_update@clearTiles idx
    case. 3 do. msgtk_update@markTiles idx
  end.
)

NB. menu events
NB. ---------------------------------------------------------
gamenew_activate=: 3 : 0
  msgtk_startnew $Map
)

gameoption_activate=: 0:

gamequit_activate=: 3 : 0
  gtk_widget_destroy window
)

helphelp_activate=: 3 : 0
  mbinfo ((gettext 'Minesweeper Instructions');Instructions)
)

helpabout_activate=: 3 : 0
  mbinfo ((gettext 'About Minesweeper');About)
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
Authors: Ric Sherlock, Bill Lam

Uses J7 graphics/gtk for GUI
)

NB. Menu bar
NB. =========================================================

NB. replace nb. by NB.
fixNB=: 3 : 0
  x=. I. 'nb.' E. y
  'NB' (0 1 +/~ x) } y
)

getmenu=: 3 : 0
  ndx=. MENUIDS i. <y
  if. ndx=#MENUIDS do.
    ((gettext 'menu not found: '),y) assert 0
  end.
  ndx pick MENUDEF
)

menu_init=: 3 : 0
  f=. < @ (<;._1) @ (','&,)
  j=. f;._2 Menus
  MENUIDS=: {.&> j
  MENUDEF=: }.each j
  0
)

Menus=: fixNB 0 : 0
gamenew,gtk-new,_New Game,,Start a new game,gamenew_activate
gameoption,gtk-preferences,_Options,,Not implemented,gameoption_activate
gamequit,gtk-quit,_Quit,cQ,Quit the program,gamequit_activate

helphelp,gtk-help,_Instructions,,,helphelp_activate
helpabout,gtk-about,_About,,,helpabout_activate
)

edit_menu=: 3 : 0
  mb=. gtk_menu_bar_new''
  game_menu mb
  help_menu mb
  gtk_widget_show_all mb
  mb
)

game_menu=: 3 : 0
  pop=. create_menu_popup y;gettext '_Game'
  con=. create_menu_container pop
  con ccmenu 'gamenew'
  con ccmenu 'gameoption'
  create_menu_sep con
  con ccmenu 'gamequit'
)

help_menu=: 3 : 0
  pop=. create_menu_popup y;gettext '_Help'
  con=. create_menu_container pop
  con ccmenu 'helphelp'
  con ccmenu 'helpabout'
)

NB. Auto-run UI
NB. =========================================================
cocurrent 'base'
MinesweeperGtk ''
