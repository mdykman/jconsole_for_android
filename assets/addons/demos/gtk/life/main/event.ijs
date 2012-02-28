NB. event

NB. =========================================================
life_exit_button=: life_close
life_help_about=: 3 : 'info ABOUT'
life_help_help=: 3 : 'info HELP'
life_pause_button=: lifetimer bind 0
life_run_button=: 3 : 'lifetimer TIMER'

NB. =========================================================
life_back_button=: 3 : 0
lifetimer 0
if. HASBUF do.
  STATE=: _1 pick BUF
  BUF=: a:,}:BUF
  HASBUF=: * # _1 pick BUF
  COUNT=: COUNT - 1
  glsel locGB
  paint''
  glpaintx''
else.
  enableback 0
end.
)

NB. =========================================================
life_cfg_button=: 3 : 0
'' conew 'plifecfg'
)

NB. =========================================================
life_cfg_return=: 3 : 0
pdef y
MAXITER=: Nmaxiter
MAXBUF=: Nmaxbuf
TIMER=: Ntimer
MINRUN=: Nminrun
RUN=: MINRUN
if. (-.Nboard -: BOARD) +. Nscale ~: SCALE do.
  STATE=: ,Nboard {. BOARD $ STATE
  BOARD=: Nboard
  SCALE=: Nscale
  boardinit ''
  setlabsize''
  setformsize ''
end.
glsel locGB
paint''
glpaintx''
)

NB. =========================================================
life_close=: 3 : 0
lifetimer 0
if. -.IFGTK do.
  gtk_main_quit''
end.
gtk_widget_destroy window
1
)

NB. =========================================================
life_key_press=: 3 : 0
if. isesckey y do.
  life_close''
end.
)

NB. =========================================================
life_load_button=: 3 : 0
fl=. wd 'mbopen  "Load *.lif File" "',PATH,'"  ""  "Life(*.lif)|*.lif|All Files(*.*)|*.*"'
if. 0=#fl do. return. end.
a=. readlif fl
if. 0=#a do. return. end.
rundoit a
FILE=: fl
'PATH NAME'=: pathname fl
lif_run ''
)

NB. =========================================================
life_step_button=: 3 : 0
lifetimer 0
RUN=: 1
life''
RUN=: MINRUN
)

NB. =========================================================
cb_file_exit=: life_close
window_delete=: life_close
window_expose=: 0:
window_destroy=: 0:
