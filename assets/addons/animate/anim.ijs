NB. anim - generic extensible animation form
NB.
NB. INSTALL
NB.   copy files to folder "~user/animate"
NB.   run demo.ijs
NB.
NB. USAGE
NB.   - copy one of the test examples
NB.   - modify setup and step verbs
NB.   - use go and step verbs to operate manually
NB.
NB. AUTHOR
NB.   02/06/06 Oleg Kobchenko
NB.   02/17/06 Oleg Kobchenko - INC to reverse; viewmat; demo
NB.   03/22/06 Oleg Kobchenko - removed INC; resize; export
NB.   03/23/06 Oleg Kobchenko - 3D export
NB.   09/28/06 Oleg Kobchenko - j601 updated

require 'gl2 viewmat'

coclass 'panim'
coinsert 'jgl2'

splitlast=: i:~ ({. ; (}.~ >:)~) ]

F=: 0 : 0
pc f;
menupop "&File";
menu export "&Export ..." "" "" "";
menupopz;
menupop "&Window";
menu resize "&Resize ..." "" "" "";
xywh 7 126 28 14;cc brun button topmove bottommove;cn "Run";
xywh 40 126 136 14;cc track trackbar tbs_autoticks tbs_both tbs_top topmove rightmove bottommove;
xywh 4 4 175 120;cc g isigraph opengl rightmove bottommove;
pas 4 4;pcenter;
rem form end;
)

create=: 3 : 0
  wd ('opengl';'') stringreplace^:(0=#y) F
  HWND=: wd'qhwndp'
  setup''
  wd 'set track ',":MIN,STEP,MAX,PAGE,LINE
  run''
  wd 'ptop 0'
  wd 'pshow'
)

destroy=: 3 : 0
  stop''
  wd'pclose'
  codestroy ''
)

setup=: 3 : 0
  TITLE=: 'Animator'
  MIN=: 0
  MAX=: 99
  PAGE=: 10
  LINE=: 1
  STEP=: 0
  DELAY=: 100
  RUN=: 0
  
  LOC=: ''
  FROM=: TO=: 0
  EXPORT=: 0
  IFGL3=: (<'jgl3') e. copath coname''
)

run=: 3 : 0
  step STEP
)

f_brun_button=: 3 : 0
  empty stop`start@.] RUN=: -.RUN
)

f_track_button=: 3 : 0
  step ".track
)

f_export_button=: e_run
f_resize_button=: s_run

f_close=: destroy

f_g_paint=: run

start=: 3 : 0
  ".'sys_timer_z_=:timer_',(>coname''),'_'
  wd 'timer ',":DELAY
  wd 'setcaption brun Stop'
)

stop=: 3 : 0
  wd 'timer 0'
  erase <'sys_timer_z_'
  wd 'setcaption brun Run'
)

errmsg=: 3 : 0
  stop''
  wdinfo (13!:12)^:(0: = #) y
)

timer=: 3 : 0
  try.
    go''
  catch. errmsg'' end.
)

go=: 3 : 0
  step MIN+(1+MAX-MIN)|1+STEP-MIN
  export''
)

step=: 3 : 0
  wd 'psel ',HWND
  wd 'set track ',":STEP=: y
  wd 'pn *',TITLE,' - ',":STEP
)

export=: 3 : 0
  if. -.EXPORT do. return. end.
  'FN EX'=. '.' splitlast LOC
  FP=. FN,(}.":STEP+>.&.(10&^.)@>:MAX),'.',EX
  
  try.
    if. IFGL3 do.
      gswritebmp FP
    else.
      data=. (|.wh)$glqpixels 0 0,wh=. glqwh ''
      data writebmp FP
    end.
  catch. wdinfo TITLE;'Error capturing graphics',LF,13!:12''
    EXPORT=: 0 return. end.
  
  if. STEP>:TO do.
    stop EXPORT=: 0 end.
)

IFJ6=: 'j6' 1 0&-:@/:@,:&(a.&i.) 2{.9!:14''

NB. =========================================================

S=: 0 : 0
pc s closeok;pn "Resize Graphics";
xywh 48 14 40 11;cc width edit;
xywh 48 31 40 11;cc height edit;
xywh 8 16 40 10;cc s1 static;cn "Width";
xywh 8 32 40 10;cc s2 static;cn "Height";
xywh 32 56 34 11;cc ok button bs_defpushbutton;cn "OK";
pas 10 10;pcenter;
rem form end;
)

s_run=: 3 : 0
  stop''
  'CW CH'=. _2{.0".wd 'qchildxywhx g'
  'PX PY PW PH'=: 0".wd 'qformx'
  'DW DH'=: (PW-CW),PH-CH
  wd S
  wd 'set width ',":CW
  wd 'set height ',":CH
  wd 'pshow'
)

s_ok_button=: 3 : 0
  wd 'pclose'
  wd 'psel ',HWND
  wd 'pmovex ',":PX,PY,(DW+100>.1000<.0".width),DH+100>.1000<.0".height
  run''
)

NB. =========================================================

E=: 0 : 0
pc e closeok;pn "Export Image Sequence";
xywh 48 16 40 11;cc from edit;
xywh 48 33 40 11;cc to edit;
xywh 8 18 40 10;cc s1 static;cn "From";
xywh 8 34 40 10;cc s2 static;cn "To";
xywh 171 10 34 11;cc ok button bs_defpushbutton;cn "OK";
xywh 8 55 50 10;cc s3 static;cn "Save As";
xywh 4 66 188 11;cc loc edit;
xywh 195 66 11 11;cc br button;cn "...";
xywh 4 6 150 45;cc gr1 groupbox;cn "Frames";
xywh 112 16 34 11;cc cur button;cn "Current";
xywh 112 32 34 11;cc all button;cn "All";
pas 10 10;pcenter;
rem form end;
)

e_run=: 3 : 0
  stop''
  wd E
  HWNDE=: wd'qhwndp'
  wd 'set from *',":FROM
  wd 'set to *',":TO
  wd 'set loc *',":LOC
  wd 'pshow'
)

e_ok_button=: 3 : 0
  wd 'pclose'
  wd 'psel ',HWND
  if. 0=#loc do. wdinfo 'Missing location' return. end.
  LOC=: loc
  STEP=: FROM=: 0>.0".from
  TO=: MAX<.FROM>.0".to
  EXPORT=: 1
  run''
  export''
  if. TO>FROM do. start'' end.
)

e_cur_button=: 3 : 0
  wd 'set from *',":STEP
  wd 'set to *',":STEP
)

e_all_button=: 3 : 0
  wd 'set from *',":MIN
  wd 'set to *',":MAX
)

e_br_button=: 3 : 0
  'P F'=. PATHSEP_j_ splitlast LOC
  FT=. '"Bitmap (*.bmp)|*.bmp|All File (*.*)|*.*"'
  ST=. 'ofn_overwriteprompt ofn_pathmustexist'
  MB=. 'mbsave "Save As" "',P,'" "',F,'" ',FT,' ',ST
  wd 'psel ',HWNDE
  if. 0=#r=. wd MB do. return. end.
  wd 'set loc *',r
)

glGetInteger_jzopenglutil_=: 4 : 0
  r=. x#_1
  glGetIntegerv y;r
  r
)

gswritebmpWin_jzopenglutil_=: 0 : 0
  (2}.4 glGetInteger GL_VIEWPORT) gswritebmp y
:
  if. ''-:y do. 'clipboard not supported' 13!:8]3 end.
  glPushAttrib GL_PIXEL_MODE_BIT
  b2=. 1 glGetInteger GL_MAP_COLOR
  glPushClientAttrib GL_CLIENT_PIXEL_STORE_BIT
  
  glPixelTransferi ,.&1 GL_RED_SCALE,GL_GREEN_SCALE,GL_BLUE_SCALE,GL_ALPHA_SCALE
  glPixelTransferi ,.&0 GL_RED_BIAS,GL_GREEN_BIAS,GL_BLUE_BIAS,GL_ALPHA_BIAS
  glPixelTransferi GL_MAP_COLOR,0
  glPixelStorei GL_PACK_ALIGNMENT, 4
  
  p=. _1 #~ */x
  glReadPixels 0;0;(<"0 x),GL_RGBA;GL_UNSIGNED_BYTE;p
  
  glPopClientAttrib ''
  glPixelTransferi GL_MAP_COLOR,b2
  glPopAttrib ''
  
  p=. (|.x) $ |."1&.:((3#256)&#:) p
  
  p writebmp_z_ y;24
)

3 : 0''
  if. IFWIN32*.-.IFJAVA do.
    gswritebmp_jzopenglutil_=: 3 : gswritebmpWin_jzopenglutil_ 
  end. i.0 0
)

0 : 0 NB. =========================================================
'' conew 'panim'
)
