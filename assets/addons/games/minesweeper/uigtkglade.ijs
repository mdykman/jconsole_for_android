NB. Gtk GUI (Glade) for Minesweeper game
NB. works with J7 gui/gtk addon (either from GtkIDE or console).

Note 'Example commands to run'
  MinesweeperGtkGlade ''
  MinesweeperGtkGlade 12 12
)
MinesweeperGtkGlade_z_=: conew&'mineswpgtkglade'

require 'gui/gtk'
require 'games/minesweeper/minefield'
coclass 'mineswpgtkglade'
coinsert 'mineswp';'jgtk'

ACCELBUG=: IFWIN*.-.IF64       NB. kludge for adding ctrl-q keyboard accelerator

AddonPath=: jpath '~addons/games/minesweeper/'
Tiles=: ,((2 2 $ #) <;._3 ]) readimg AddonPath,'tiles26.png'

NB. Methods
NB. =========================================================

create=: 3 : 0
  if. -.IFGTK do. gtkinit'' end.
  newMinefield y
  IsEnd=: 0
  newwindow 'Minesweeper'
NB. glade not yet work in gtk3, draw event not handled
  'GtkBuilder window'=: 'window' gtkglade AddonPath,'uigtk.glade'
  assert. 0~:GtkBuilder
  assert. 0~:window
  gtkda=: gtk_builder_get_object GtkBuilder;'gtkda_minefld'          NB. get id of gtkdrawingarea widget
  gtk_widget_set_size_request gtkda,((#>{.Tiles)*$Map)               NB. size gtkda_minefld appropriately
  GtkSbar=: gtk_builder_get_object GtkBuilder;'sbar'                 NB. get id of statusbar widget
  SbarContxt=: gtk_statusbar_get_context_id GtkSbar;'status updates' NB. get context id to use for all msgs
  if. ACCELBUG do.
    accel_group=: gtk_accel_group_new''
    gtk_window_add_accel_group window,accel_group
    gamequit=. gtk_builder_get_object GtkBuilder;'gamequit'
    create_menu_accel window;gamequit;'gamequit';(a.i.'q');GDK_CONTROL_MASK
  end.
  msgtk_update''
  gtk_widget_show window
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

on_window_delete_event=: 0:

on_window_destroy=: 3 : 0
  g_object_unref GtkBuilder
  if. -.IFGTK do. gtk_main_quit '' end.
  destroy ''
  0
)

NB. drawing area expose events
NB. ---------------------------------------------------------
NB. gtkwin      gtkda window
NB. gtkwh
on_gtkda_minefld_draw=: on_gtkda_minefld_expose_event=: 3 : 0
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
on_gtkda_minefld_button_release_event=: 3 : 0
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
on_gamenew_activate=: 3 : 0
  msgtk_startnew $Map
)

on_gameoptions_activate=: 0:

on_gamequit_activate=: 3 : 0
  gtk_widget_destroy window
)

on_helphelp_activate=: 3 : 0
  mbinfo ('Minesweeper Instructions';Instructions)
)

on_helpabout_activate=: 3 : 0
  mbinfo ('About Minesweeper';About)
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

Uses J7 graphics/gtk/glade for GUI
)

NB. Auto-run UI
NB. =========================================================
cocurrent 'base'
MinesweeperGtkGlade ''
