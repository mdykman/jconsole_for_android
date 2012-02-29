NB. class browser - famous SmallTalk tool for J
NB.
NB. fresh rewrite using grid from Locale Browser
NB.   first appeared in okole http://olegykj.sourceforge.net/
NB.   for details see http://www.jsoftware.com/jwiki/Addons/gui/util
NB.
NB. to hookup to session, add Config/Fkeys:
NB.   load 'gui/util/cobrowse'
NB.
NB. 03/21/2007 Oleg Kobchenko

require 'gtkwd'

3 : 0''
if. IFJ6 do.
require 'jzgrid coutil scriptdoc strings'
else.
require 'jzgrid coutil general/scriptdoc strings'
end.
''
)
coclass 'pcobrowse'

F=: 0 : 0
pc f;
tbar "TOOLBAR" 7 tbstyle_flat;
tbarset tbrefresh 0 4 "Refresh locales" "Refresh";
tbarset "" 1 18;
tbarset tbopen 2 1 "Open script" "Open";
tbarset tbdoc 3 8 "Show scriptdoc" "Scriptdoc";
tbarset "" 4 18;
tbarset tbcopy 5 5 "Copy name to clipboard" "Copy Name";
tbarset tbscr 6 4 "Copy script path to clipboard" "Copy Path";
tbarshow;
xywh 6 6 64 80;cc gloc isigraph leftscale rightscale;
xywh 75 6 78 80;cc ginst isigraph leftscale rightscale;
xywh 158 6 27 80;cc gtype isigraph leftscale rightscale;
xywh 190 6 82 167;cc gname isigraph leftscale rightmove bottommove;
xywh 6 92 180 80;cc eview editm ws_hscroll ws_vscroll es_autohscroll es_autovscroll es_readonly rightscale bottommove;
xywh 7 176 187 10;cc stscript static topmove rightmove bottommove;cn "stscript";
xywh 202 175 34 10;cc stshape edit es_readonly leftmove topmove rightmove bottommove;
xywh 238 175 34 10;cc stspace edit es_readonly leftmove topmove rightmove bottommove;
pas 4 0;pcenter;
rem form end;
)

TITLE=: 'Class Browser'
TYPES=: ;:'Noun Adverb Conj Verb All'

create=: 3 : 0
  wd F rplc 'TOOLBAR';jpath IFJ6{::'~addons/gui/util/isitbar8.bmp';'~system/examples/data/isitbar8.bmp'
  wd 'pn *',TITLE
  if. IFJ6 do.
  wd 'setfont eview ',FIXFONT
  end.
  wd 'pshow;'
  
  makegrid 'gloc'
  HDRCOL__gloc=: <'Locales'
  CURLOC=: <'base'
  
  makegrid 'ginst'
  HDRCOL__ginst=: '#';'Name';'At'
  CURINST=: ''
  
  makegrid 'gtype'
  HDRCOL__gtype=: <'Types'
  CURTYPE=: <'All'
  CELLDATA__gtype=: ,.TYPES
  CELLMARK__gtype=: 0,~TYPES i. CURTYPE
  show__gtype''
  
  makegrid 'gname'
  COLSCALE__gname=: 0 1
  HDRCOL__gname=: '';'Names'
  CURNAME=: ''
  
  gloc_update ''
  ginst_update ''
  gname_update ''
  wd 'setfocus gloc'
)

destroy=: 3 : 0
  destroy__gname''
  destroy__ginst''
  destroy__gtype''
  destroy__gloc''
  wd'pclose'
  codestroy''
)

makegrid=: 3 : 0
  g=. (y)=: '' conew 'jzgrid'
  GRIDID__g=: y
  GRIDROWMODE__g=: 1
  GRIDBORDER__g=: 0
  GRIDLINES__g=: 0
  GRIDMARGIN__g=: 2 0 1 0
  GRIDSORT__g=: 0
  GRIDBACKCOLOR__g=: WHITE__g
  GRIDCOLOR__g=: (192)3 4 5}GRIDCOLOR__g
  CELLALIGN__g=: 0
  CELLEDIT__g=: 0
  COLSCALE__g=: 1
  CELLCOLORS__g=: ,:~{:CELLCOLORS__g
)

f_close=: destroy

gloc_update=: 3 : 0
  CELLDATA__gloc=: ,.NL=. nl 6
  CELLMARK__gloc=: 0,~NL i. CURLOC
  show__gloc''
)

gloc_gridhandler=: 3 : 0
  select. y
  case. 'mark' do.
    CURLOC=: CELLDATA__gloc {~ <CELLMARK__gloc
    CURINST=: a:
    ginst_update ''
    gname_update ''
    glsel_jgl2_ 'gloc'
  end.
)

ginst_update=: 3 : 0
  si=. empty''
  for_ref. inst=. CURLOC ((e. copath)"0 # ]) conl 1 do.
    if. 0=4!:0 <'COCREATOR__ref' do.
      c=. COCREATOR__ref
      n=. conouns__c ref
    else. n=. c=. a: end.
    si=. si,ref,n,c
  end.
  CELLDATA__ginst=: si,~3#a:
  CELLMARK__ginst=: 0 0
  show__ginst''
)

ginst_gridhandler=: 3 : 0
  select. y
  case. 'mark' do.
    CURINST=: CELLDATA__ginst {~ <0,~{.2{.CELLMARK__ginst
    gname_update ''
    glsel_jgl2_ 'ginst'
  end.
)

gtype_gridhandler=: 3 : 0
  select. y
  case. 'mark' do.
    CURTYPE=: CELLDATA__gtype {~ <CELLMARK__gtype
    gname_update ''
    glsel_jgl2_ 'gtype'
  end.
)

gname_update=: 3 : 0
  if. 0=#&>CURINST do. loc=. CURLOC else. loc=. CURINST end.
  NL=. nl__loc (-.CURTYPE-:<'All')#TYPES i.CURTYPE
  CL=. <"0'nacvd '{~ nc__loc NL
  CELLDATA__gname=: /:~CL,.NL
  CELLMARK__gname=: 0 0
  if. #NL do. CURNAME=: {.NL else.CURNAME=: ''end.
  show__gname''
  eview_update''
)

gname_gridhandler=: 3 : 0
  select. y
  case. 'mark' do.
    CURNAME=: CELLDATA__gname {~ <1,~{.2{.CELLMARK__gname
    eview_update''
    glsel_jgl2_ 'gname'
  end.
)

eview_update=: 3 : 0
  view=. ''
  scr=. '<script>'
  sp=. '<space>'
  sh=. '<shape>'
  if. #CURNAME do.
    if. 0=#&>CURINST do. loc=. CURLOC else. loc=. CURINST end.
    name=. <(>CURNAME),'__loc'
    ni=. 4!:4 name
    if. 0<:ni do. scr=. >ni{4!:3'' else. scr=. 'defined in session' end.
    sp=. 'c'>@(8!:0) 7!:5 name
    if. 0=nc name do.
      if. 2 ((>#@$)*.(=3!:0)) v=. (>name)~ do.
        view=. v
      else. view=. ,,&LF"1((1 1,:_2+$) ];.0 ]) ":<v end.
      sh=. ":$v
    else.
      if. 3=nc name do. sh=. ":(>name)~ b.0 end.
      view=. 5!:5 name
    end.
  end.
  wd 'set eview *',view
  wd 'set stscript *',scr
  wd 'set stspace *',sp
  wd 'set stshape *',sh
)

f_tbrefresh_button=: 3 : 0
  gloc_update''
  gloc_gridhandler'mark'
)

f_rctrl_fkey=: f_tbrefresh_button

f_tbopen_button=: 3 : 0
  if. 0>ni=. 4!:4 name=. curname'' do. ''return. end.
  myedit CURNAME,ni{4!:3''
)


f_tbdoc_button=: 3 : 0
  if. 0>ni=. 4!:4 name=. curname'' do. ''return. end.
  scriptdoc ni{4!:3''
)

f_tbcopy_button=: 3 : 0
if. IFJ6 do.
  wd'clipcopy *', >curname''
else.
  clipwrite >curname''
end.
)

f_tbscr_button=: 3 : 0
  if. 0>ni=. 4!:4 name=. curname'' do. ''return. end.
if. IFJ6 do.
  wd'clipcopy *', >tofoldername_jijs_ ni{4!:3''
else.
  clipwrite > ni{4!:3''
end.
)

curname=: 3 : 0
  if. 0=#CURNAME do. ''return. end.
  if. 0=#&>CURINST do. loc=. CURLOC else. loc=. CURINST end.
  if. 0>ni=. 4!:4 name=.<(>CURNAME),'_',(>loc),'_'do. ''return. end.
  name
)

myedit=: 3 : 0
'n s'=. y
file=. {.,getscripts_j_ s
dat=. 1!:1 :: _1: file
if. dat -: _1 do.
  'file read error: ',,>file return.
end.
dat=. toJ dat
dat=. < @ (;: :: <) ;._2 dat,LF
ndx=. I. (1: e. (n;'=:')&E.) &> dat
if. 0 = #ndx do.
  m=. }:(2<:+/\.n='_')#n
  ndx=. I. (1: e. (m;'=:')&E.) &> dat
end.
if. 0=#ndx do.
  open file
else.
if. IFJ6 do.
  ({.ndx) flopen_jijs_ file
else.
  open file
end.
end.
)

NB. =========================================================
cocurrent 'base'
'' conew 'pcobrowse'
