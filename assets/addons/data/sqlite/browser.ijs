NB. browse -- sqlite browser
NB.
NB. For Windows, edit path to J and extensions and run browser.reg
NB. to open sqlite files from Explorer
NB.
NB. Copyright 2006 (C) Oleg Kobchenko
NB. Provided AS IS. No warrantiles or liabilities extended.
NB.
NB. 10/04/06 Oleg Kobchenko

'Window Driver (wd) required' assert 0 <: #@(11!:0) :: _1: 'qer'

require 'data/sqlite grid'

coclass 'psqlitebr'

TITLE=: 'SQLite Browser'

F=: 0 : 0
pc f;
menupop "File";
menu con "&Connect to database" "" "" "";
menusep;
menu new "&New script" "" "" "";
menu open "&Open script..." "" "" "";
menusep;
menu save "&Save script" "" "" "";
menu saveas "Save script &As ..." "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
menupop "Edit";
menu pref "&Preferences" "" "" "";
menupopz;
menupop "Help";
menu about "&About" "" "" "";
menupopz;
xywh 4 4 50 10;cc s1 static;cn "Tables";
xywh 4 16 72 196;cc lsObj listbox bottommove;
xywh 80 2 202 82;cc tab tab rightmove;
xywh 84 18 194 60;cc vwScr editm ws_hscroll ws_vscroll es_autohscroll es_autovscroll es_readonly rightmove;
xywh 84 18 194 60;cc edScr editm ws_hscroll ws_vscroll es_autohscroll es_autovscroll rightmove;
xywh 254 86 24 11;cc btRun button leftmove rightmove;cn "Run";
xywh 80 98 200 112;cc grid isigraph rightmove bottommove;
xywh 80 88 50 10;cc sTab static;cn "Result";
xywh 4 216 276 45;cc edLog editm ws_hscroll ws_vscroll es_autohscroll es_autovscroll es_readonly topmove rightmove bottommove;
pas 4 4;pcenter;
rem form end;
)

FONT=: FIXFONT
TAB_SZ=: 16

create=: 3 : 0
  dbcon=: db=: ''
  LOG=: 1
  wd  F
  wd 'pn *',TITLE
  wd 'set tab Schema Data Script'
  edLog=: ''
  fmtScript''
  newScript ''
  showScript 0
  wd 'setselect tab 0'
  grid=: ''conew'jzgrid'
  CELLEDIT__grid=: 0
  GRIDCOLOR__grid=: (192)3 4 5}GRIDCOLOR__grid
  connect DBFILE=: y
  wd 'pshow;'
)

destroy=: 3 : 0
  if. 0=checkDirty'' do. return. end.
  connect''
  destroy__grid''
  wd 'pclose'
  codestroy''
)

f_close=: destroy
f_exit_button=: destroy
f_lsObj_select=: update
f_saveas_button=: saveAs
f_tab_button=: update
f_btRun_button=: runQuery
f_about_button=: about
f_pref_button=: pref

f_con_button=: 3 : 0
  if. 0=#f=. openDb'' do. return. end.
  connect DBFILE=. f
)

f_new_button=: 3 : 0
  if. 0=checkDirty'' do. return. end.
  newScript ''
)

f_open_button=: 3 : 0
  if. 0=checkDirty'' do. return. end.
  if. 0=#f=. openScr'' do. return. end.
  newScript f
)

f_save_button=: 3 : 0
  if. 0=#SCFILE do. f_saveas_button'' return. end.
  save ''
)

NB. =========================================================
NB. controller

connect=: 3 : 0
  if. #db do. destroy__db'' end.
  dbcon=: db=: ''
  edLog=: ''
  if. 0=#y do. return. end.
  dbcon=: y
  db=: 'psqlite'conew~dbcon
  setTitle dbcon
  viewTables getTables ''
  viewScript ''
  viewTable LAST_RES=: i.0 0
)

'TAB_SCH TAB_DAT TAB_SCR'=: i.3

update=: 3 : 0
  tab_select=: ".tab_select
  if. (tab_select~:TAB_SCR) *. 0=#lsObj do. ''return. end.
  select. tab_select
  case. TAB_SCH do.
    viewScript getCreate lsObj
    viewTable getColumns lsObj
  case. TAB_DAT do.
    viewScript sqlFullTable lsObj
    viewTable getFullTable lsObj
  case. TAB_SCR do.
    showScript 1
    viewTable LAST_RES
  end.
  ''
)

runQuery=: 3 : 0
  if. 0=#q=. ({.0".edScr_select) findQuery edScr do.
    log 'No query at selection' return. end.
  LAST_RES=: getQuery q
  viewTable LAST_RES
  wd 'setfocus edScr'
)

findQuery=: 4 : 0
  if. x>0 do. if. ';'=(x-1){y do. x=. x-1 end.end.
  d=. _1,(#y),~([:I.';'&=) y
  p=. I.x (}:@:> *. }.@:<:) d
  i=. >:p{d
  s=. i-~(p+1){d
  dltb (i,:s)];.0 y
)

newScript=: 3 : 0
  if. 0=#SCFILE=: y do.
    SCLAST=: ''
  else.
    SCLAST=: toJ fread SCFILE
  end.
  editScript SCLAST
)

checkDirty=: 3 : 0
  if. edScr-: SCLAST do.
    1 return. end.
  if. a=. 3 wdquery TITLE;'Script changed',LF,'Would you like to save?' do.
    -.<:a return.end.
  saveAs''
)

save=: 3 : 0
  SCLAST=: edScr
  0<: (toHOST SCLAST) fwrite SCFILE
)

saveAs=: 3 : 0
  if. 0=#f=. saveScr SCFILE do. 0 return. end.
  SCFILE=: f
  save ''
)

MBO_SC=: 'SQL (*.sql)|*.sql|DDL (*.ddl)|*.ddl|All files (*.*)|*.*'

saveScr=: 3 : 0
  wd 'mbopen "Save SQL" "" "',y,'" "',MBO_SC,'" ofn_overwriteprompt ofn_pathmustexist'
)

openScr=: 3 : 0
  wd 'mbopen "Open SQL" "" "" "',MBO_SC,'" ofn_filemustexist'
)

MBO_DB=: 'SQLite (*.sqlite)|*.sqlite|SQLite (*.db)|*.db|All files (*.*)|*.*'

openDb=: 3 : 0
  wd 'mbopen "Open SQLite" "" "" "',MBO_DB,'" ofn_createprompt ofn_pathmustexist'
)

about=: wdinfo bind(('About ',TITLE,' ...');0 : 0)
SQLite Browser version 1.01

Copyright (C) 2006 Oleg Kobchenko. All right reserved.
	http://olegykj.sourceforge.net/

SQLite	http://www.sqlite.org/
J	http://www.jsoftware.com/
)

NB. =========================================================
NB. view

fmtScript=: 3 : 0
  try.
    wd 'setfont vwScr ',FONT
    wd 'setfont edScr ',FONT
  catch. FONT=: FIXFONT end.
  wd 'settabstops edScr ',":TAB_SZ
  wd 'settabstops edLog ',":TAB_SZ
)

viewTables=: 3 : 0
  if. 0=#y do. log 'No tables' return. end.
  wd 'set lsObj *',,;,&LF&.>{."1}.y
)

viewScript=: 3 : 0
  showScript 0
  wd 'set vwScr *',y
  if. 0=#y do. log 'No script' return. end.
)

editScript=: 3 : 0
  showScript 1
  wd 'set edScr *',y
  wd 'setselect tab ',":TAB_SCR
  if. 0=#y do. log 'No script' return. end.
)

SCR_FOC=: 0

showScript=: 3 : 0
  wd 'setshow vwScr ',":-.y
  wd 'setshow edScr ',":y
  wd 'setshow btRun ',":y
  if. SCR_FOC do. wd 'setfocus ',y{::;:'vwScr edScr' end.
)

viewTable=: 3 : 0
  if. 0=#y do.
    CELLDATA__grid=: i.0 0
    HDRCOL__grid=: ''
    HDRROW__grid=: ''
    log 'No data'
  else.
    CELLDATA__grid=: }.y
    CELLALIGN__grid=: 2 0{~2=(3!:0)&> 1{y
    HDRCOL__grid=: {.y
    HDRROW__grid=: 1
  end.
  show__grid''
)

setTitle=: 3 : 0
  wd 'pn *',y,' - ',TITLE
)

NB. =========================================================
NB. model

unlf=: }:^:(LF={:)^:(0<#)

'LOG_MAX LOG_CUT LOG_MIN LOG_ABS'=: 160 _40 20 10000

log=: 3 : 0
  if. 0=LOG do. return. end.
  if. LOG_MAX<([: +/ =&' ') edLog do.
    edLog=: (LOG_CUT{([: I. =&' ')edLog)}.edLog end.
  wd 'set edLog *', edLog=: edLog,LF,(unlf,":y)
  wd 'setselect edLog ',":(0 0+#edLog),0
)

'LIM_SKP LIM_SIZ LIM_MIN LIM_MAX'=: 0 10 10 1000

query=: ''&$: : (4 : 0)
  log 'Query: ',y
  if. #x do. log 'Params: ',":1:^:(0=#)$x end.
  r=. _1
  limit__db LIM_SKP, LIM_SIZ
  try. r=. x query__db y
  catch. log 13!:12'' end.
  if. _1-:r do. r=. 0 0$'' else.
    log 'Return: ',":$r end.
  r
)

schema=: ''&$: : (4 : 0)
  log 'Schema: ',y
  if. #x do. log 'Params: ',":1:^:(0=#)$x end.
  r=. _1
  try. r=. x query__db y
  catch. log 13!:12'' end.
  if. _1-:r do. r=. 0 0$'' else.
    log 'Return: ',":$r end.
  r
)

sqlTables=: 0 : 0
  select name,sql from sqlite_master
  where type='table' order by name;
)
getTables=: 3 : 0
  schema sqlTables
)

sqlColumns=: 3 : 0
  'PRAGMA table_info(',y,');'
)
getColumns=: 3 : 0
  schema sqlColumns y
)
getColNames=: [: }. 1 {"1 getColumns

sqlCreate=: 0 : 0
  select sql from sqlite_master
  where type='table' and name=? order by name;
)
getCreate=: 3 : 0
  1 0{::(boxopen y) schema sqlCreate
)

sqlFullTable=: 3 : 0
  'select ',(','strjoin spquot&.>getColNames y),LF,'  from ',y,';'
)
getFullTable=: 3 : 0
  blobsize__db 1
  query sqlFullTable y
)

getQuery=: 3 : 0
  blobsize__db 1
  query y
)

NB. =========================================================
P=: 0 : 0
pc p closeok dialog nomax nomin nosize owner;pn "SQLite Browser - Preferences";
xywh 10 5 199 61;cc gr1 groupbox;cn "Script Format";
xywh 42 18 27 10;cc s1 static;cn "Font";
xywh 74 16 86 11;cc edFont edit;
xywh 30 33 36 10;cc st2 static;cn "Tab Size";
xywh 74 32 50 11;cc edTabSz edit;
xywh 74 49 50 10;cc chScrFoc checkbox;cn "Autofocus";
xywh 10 70 97 50;cc gr2 groupbox;cn "Query Limit";
xywh 30 86 25 10;cc st3 static;cn "Skip";
xywh 60 85 30 11;cc edLimSkp edit;
xywh 30 102 26 10;cc st4 static;cn "Size";
xywh 60 101 30 11;cc edLimSiz edit;
xywh 116 70 93 50;cc gr3 groupbox;cn "Log Limit";
xywh 132 86 25 10;cc st5 static;cn "Max";
xywh 162 85 30 11;cc edLogMax edit;
xywh 132 102 26 10;cc st6 static;cn "Cut";
xywh 162 101 30 11;cc edLogCut edit;
xywh 71 130 34 11;cc ok button;cn "OK";
xywh 118 130 34 11;cc cancel button;cn "Cancel";
xywh 165 16 32 11;cc btFont button;cn "Browse";
pas 10 10;pcenter;
rem form end;
)

pref=: 3 : 0
  wd P
  wd 'set edFont *',FONT
  wd 'set edTabSz ',":TAB_SZ
  wd 'set chScrFoc ',":SCR_FOC
  wd 'set edLimSkp ',":LIM_SKP
  wd 'set edLimSiz ',":LIM_SIZ
  wd 'set edLogMax ',":LOG_MAX
  wd 'set edLogCut ',":-LOG_CUT
  wd 'pshow;'
)

p_close=: 3 : 0
  wd 'pclose'
)
p_cancel_button=: p_close

p_btFont_button=: 3 : 0
  try. if. 0=#f=. wd 'mbfont ',edFont do. return. end.
  catch. if. 0=#f=. wd 'mbfont ',FIXFONT do. return. end. end.FIXFONT
  wd 'set edFont *',f
)

p_ok_button=: 3 : 0
  wd 'pclose'
  wd 'psel f'
  if. 0<#edFont=. dltb edFont do.
    FONT=: edFont
  end.
  if. 0<#edTabSz=. dltb edTabSz do.
    TAB_SZ=: 40<.8>.{.0".edTabSz
  end.
  fmtScript''
  if. 0<#chScrFoc=. dltb chScrFoc do.
    SCR_FOC=: 0~:{.0".chScrFoc
  end.
  if. 0<#edLimSkp=. dltb edLimSkp do.
    LIM_SKP=: LIM_MAX<.0>.{.0".edLimSkp
  end.
  if. 0<#edLimSiz=. dltb edLimSiz do.
    LIM_SIZ=: LIM_MAX<.LIM_MIN>.{.0".edLimSiz
  end.
  if. 0<#edLogMax=. dltb edLogMax do.
    LOG_MAX=: LOG_ABS<.LOG_MIN>.{.0".edLogMax
  end.
  if. 0<#edLogCut=. dltb edLogCut do.
    LOG_CUT=: -(<.-:LOG_MAX)<.LOG_MIN>.{.0".edLogCut
  end.
)



NB. =========================================================
strjoin=: ":&.>@] ;@}:@,@,. boxopen@[
spquot=: ([:'"'&, ,&'"')^:(' '&e.)

NB. =========================================================
sqlitebr_z_=: conew&'psqlitebr'

NB. sqlitebr jpath'~addons/data/sqlite/test/date.sqlite'
NB. sqlitebr jpath'~addons/web/jhp/examples/phrasedb/phrases.sqlite'
sqlitebr (''"_)`(2&{::)@.(2<#)}.ARGV
