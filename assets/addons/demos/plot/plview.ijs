NB. Plot viewer

3 : 0''
if. -.IFGTK do. gtkinit_jgtk_'' end.
''
)

coclass 'jdplot'
coinsert 'jgtk jzplot jgl2'


RUNID1=: 0
plotedit=: 0
CMDS=: ''

plotruns=: plotrunsx=: 3 : 0
CMDS=: ". y
glsel PIdLoc
glpaint''
)

PLTIMER=: 3000
PLDEMOVER=: 7.01
SLIDES=: 0

NB. =========================================================
plotdemo_run=: 3 : 0

Cw=: Ch=: _1 NB. ensure plot window is sized
f=. jpath '~system/packages/graphics/'&, @ (,&'.ijs')
DATHILO=: }. 'm' fread jpath '~Demos/plot/dm0396.txt'

MyPlotDefaults=: '' NB. turn off user defaults

def=. 'JGRAPHICS'

if. 0 ~: 4!:0 <'PLDEMOSEL' do.
  PLDEMOSEL=: def
end.

ASPECT=: 170%270
PShow=: 0

PForm=: 'plotdemo'
PId=: 'ps'
make_main_window''
PFormhwnd=: window
gtk_widget_show_all window

plotruns 'D',PLDEMOSEL

if. -.IFGTK do. gtk_main'' end.
)

NB. =========================================================
menu_button=: 0 : 0
plotdemo_Mxxx_button=: (3) : 0
'widget data'=. y
name=. 'xxx'
if. name -: PLDEMOSEL do.
  0 return.
end.
if. (<name) e. PLOTNAMES do.
  if. 0~:RUNID1 do. RUNID1=: 0 [ g_source_remove RUNID1 end.
  SLIDES=: 0
  PLDEMOSEL=: name
  plotrunsx 'D',PLDEMOSEL
end.
0
)

NB. =========================================================
NB. menu button event handler
3 : 0''
for_i. PLOTNAMES do.
  0!:0 (')',LF),~ ('xxx';>i) stringreplace menu_button
end.
''
)

NB. =========================================================
plotdemo_view_button=: 3 : 0
plotedit_run PLDEMOSEL
0
)

NB. =========================================================
plotdemo_exit_button=: 3 : 0
gtk_widget_destroy window
0
)

NB. =========================================================
plotdemo_contents_button=: 3 : 0
mbox 1;'help contents'
0
)

NB. =========================================================
plotdemo_about_button=: 3 : 0
j=. 'Plot Demo V',(4j2 ": PLDEMOVER)
mbox 1;'Plot';j
0
)

NB. =========================================================
plotdemo_ps_paint=: 3 : 0
if. newsize__PIdLoc do.
  if. #CMDS do.
    glclear''
    pd 'reset ',PForm
    0!:100 CMDS
  end.
  gtk_show''
  newsize__PIdLoc=: 0
end.
0
)

NB. =========================================================
plotdemo_ps_char=: 0:

NB. =========================================================
plotdemo_slides_button=: 3 : 0
SLIDES=: -. SLIDES
if. SLIDES do.
  RUNID1=: g_timeout_add_full G_PRIORITY_DEFAULT_IDLE;3000;cb1;(cbreg 'plotdemo_slides','_',(>coname''),'_');0
else.
  if. 0~:RUNID1 do. RUNID1=: 0 [ g_source_remove RUNID1 end.
end.
0
)

NB. =========================================================
plotdemo_slides=: 3 : 0
try.
  plotdemo_next_button''
  1
catch.
  RUNID1=: 0
  0
end.
)

NB. =========================================================
plotdemo_step=: 3 : 0
ndx=. (#PLOTALL) | y + PLOTALL i. <'D',PLDEMOSEL
PLDEMOSEL=: }.ndx pick PLOTALL
plotrunsx 'D',PLDEMOSEL
0
)

NB. =========================================================
plotdemo_destroy=: 3 : 0
'widget data'=. y
if. 0~:RUNID1 do. RUNID1=: 0 [ g_source_remove RUNID1 end.
if. plotedit do. gtk_widget_destroy ::0: plotedit end.
window=: 0
if. -.IFGTK do. gtk_main_quit'' end.
cbfree''
0
)

plotdemo_saveeps_button=: pd_jdplot_ bind 'eps'
plotdemo_savepdf_button=: pd_jdplot_ bind 'pdf'
plotdemo_clip_button=: pd_jdplot_ bind 'clip'
plotdemo_print_button=: 0:

NB. =========================================================
plotdemo_next_button=: plotdemo_step bind 1
plotdemo_prev_button=: plotdemo_step bind _1
plotdemo_f10_fkey=: plotdemo_saveeps_button
plotdemo_f11_fkey=: plotdemo_savepdf_button
plotdemo_f12_fkey=: plotdemo_next_button
plotdemo_f12shift_fkey=: plotdemo_prev_button

plotdemo=: plotdemo_run
