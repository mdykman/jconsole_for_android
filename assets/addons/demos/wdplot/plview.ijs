NB. Plot viewer

coclass 'jdplot'

CMDS=: ''

plotrun=: 3 : 0
glclear''
0!:100 y
pd 'show'
)

plotruns=: 3 : 0
CMDS=: ". y
)

plotrunsx=: 3 : 0
glclear''
0!:100 ". y
pd 'show'
)

PLTIMER=: 3000
IFWINCE=: 7=9!:12''
PLDEMOVER=: 6.02
SLIDES=: 0

NB. =========================================================
plotdemo_run=: 3 : 0
Cw=: _1 NB. ensure plot window is sized
f=. jpath '~system/packages/graphics/'&, @ (,&'.ijs')
DATHILO=: }. 'm' fread jpath '~addons/demos/wdplot/dm0396.txt'

MyPlotDefaults=: '' NB. turn off user defaults

if. IFWINCE do.
  def=. 'LINE'
else.
  def=. 'JGRAPHICS'
end.

if. 0 ~: 4!:0 <'PLDEMOSEL' do.
  PLDEMOSEL=: def
end.

ASPECT=: 170%270
PShow=: 0

wd PLOTDEMO
PForm=: 'plotdemo'
PFormhwnd=: wdqhwndp''
PIdhwnd=: wdqhwndc 'ps'
PId=: 'ps'
NB. wd 'pmovex _1 _1 720 520'
wd 'pshow'
pd 'reset ', PForm
wd 'set M',PLDEMOSEL,' 1'
plotruns 'D',PLDEMOSEL
glpaint''
)

NB. =========================================================
plotdemo_default=: 3 : 0
if. systype -: 'button' do.
  name=. }.syschild
  if. name -: PLDEMOSEL do.
    wd 'set M',PLDEMOSEL,' 1'
    return.
  end.
  if. (<name) e. PLOTNAMES do.
    wd 'set M',PLDEMOSEL,' 0'
    PLDEMOSEL=: name
    wd 'set M',PLDEMOSEL,' 1'
    pd 'reset ',":PForm
    if. 'Android'-:UNAME do.
      plotruns 'D',PLDEMOSEL
      glpaintx''
    else.
      plotrunsx 'D',PLDEMOSEL
    end.
  end.
end.
''
)

NB. =========================================================
plotdemo_view_button=: 3 : 0
plotedit_run_jdplotedit_`start_droidwd_jdplotedit_@.('Android'-:UNAME) 'jdplotedit'
NB. plotedit_run PLDEMOSEL
)

NB. =========================================================
plotdemo_exit_button=: 3 : 0
wd 'psel plotdemo;pclose;'
try. wd 'psel plotedit;pclose' catch. end.
)

NB. =========================================================
plotdemo_contents_button=: 3 : 0
sminfo 'help contents'
)

NB. =========================================================
plotdemo_about_button=: 3 : 0
j=. 'Plot Demo V',(4j2 ": PLDEMOVER)
sminfo 'Plot';j
)

NB. =========================================================
plotdemo_ps_paint=: 3 : 0
if. #CMDS do.
  0!:100 CMDS
  CMDS=: ''
end.
ppaint''
)

NB. =========================================================
plotdemo_slides_button=: 3 : 0
if. SLIDES do.
  wd 'timer 0'
  SLIDES=: 0
  erase 'sys_timer_z_'
else.
  wd 'timer ',":PLTIMER
  sys_timer_z_=: plotdemo_timer_jdplot_
  SLIDES=: 1
end.
wd 'set slides ',":SLIDES
)

NB. =========================================================
plotdemo_step=: 3 : 0
ndx=. (#PLOTALL) | y + PLOTALL i. <'D',PLDEMOSEL
wd 'set M',PLDEMOSEL,' 0'
PLDEMOSEL=: }.ndx pick PLOTALL
wd 'set M',PLDEMOSEL,' 1'
pd 'reset ',":PForm
if. 'Android'-:UNAME do.
  plotruns 'D',PLDEMOSEL
  glpaintx''
else.
  plotrunsx 'D',PLDEMOSEL
end.
)

NB. =========================================================
plotdemo_timer=: 3 : 0
if. wdisparent 'plotdemo' do.
  wd 'psel plotdemo'
  plotdemo_next_button''
else.
  wd 'timer 0'
  SLIDES=: 0
  erase 'sys_timer_z_'
end.
)

plotdemo_saveeps_button=: pd_jdplot_ bind 'eps'
plotdemo_savepdf_button=: pd_jdplot_ bind 'pdf'
plotdemo_clip_button=: pd_jdplot_ bind 'clip'

NB. =========================================================
plotdemo_next_button=: plotdemo_step bind 1
plotdemo_prev_button=: plotdemo_step bind _1

3 : 0 ''
if. IFWINCE do.
  plotdemo_actrl_fkey=: plotdemo_next_button
  plotdemo_actrlshift_fkey=: plotdemo_prev_button
else.
  plotdemo_f10_fkey=: plotdemo_saveeps_button
  plotdemo_f11_fkey=: plotdemo_savepdf_button
  plotdemo_f12_fkey=: plotdemo_next_button
  plotdemo_f12shift_fkey=: plotdemo_prev_button
end.
0
)

NB. plotdemo=: plotdemo_run
