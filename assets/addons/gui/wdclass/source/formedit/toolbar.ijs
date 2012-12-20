NB. toolbar

NB. =========================================================
WTBAR=: 0 : 0
pc wtbar owner;
xywh 0 0 270 15;cc tbbmp isigraph rightmove;
xywh 0 16 270 12;cc tbids isigraph rightmove;
xywh 4 31 36 12;cc tbfile button;cn "File...";
xywh 42 32 218 11;cc tbname static;cn "";
xywh 4 46 89 11;cc tbflat checkbox;cn "Flat Toolbar (Jwdw)";
xywh 4 66 175 11;cc sdef static;cn "";
xywh 0 79 270 150;cc toolbardef editm es_autovscroll rightmove bottommove;
xywh 192 50 36 12;cc apply button leftmove rightmove;cn "&Apply";
xywh 192 64 36 12;cc help button leftmove rightmove;cn "&Help";
xywh 230 50 36 12;cc ok button leftmove rightmove;cn "OK";
xywh 230 64 36 12;cc cancel button leftmove rightmove;cn "Cancel";
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
NB. y=1 if re-run
wtbar_run=: 3 : 0
rerun=. 1 = {. y
if. rerun do.
  xywh=. wd 'qformx'
  wd 'psel wtbar;pclose'
end.
wd WTBAR
wd 'pn "Toolbar - ',PID,'"'
selecttoolbar=: wd bind ('psel ',wd 'qhwndp')
wd 'setcaption sdef *Definition: id  index  tooltip  _  statushelp'
wtbar_showdef''
if. rerun do.
  wd 'pmovex ',xywh
end.
wd 'pshow;'
)

NB. =========================================================
wtbar_showdef=: 3 : 0
'f s d'=. gettoolbardef TBR
if. # f do.
  TBFN=: f
end.
TBDS=: s
TBDF=: d
wtbar_showtoolbar''
)

NB. =========================================================
wtbar_showtoolbar=: 3 : 0
try.
  dat=. 1!:1 < TBFN
catch.
  sminfo 'Toolbar';'file read error: ',":>TBFN return.
end.
if. -. '.bmp' -: tolower _4 {. TBFN do.
  msg=. 'The Form Editor only supports bitmap toolbar files with extension .bmp.'
  sminfo 'Toolbar';msg return.
end.

bits=. 0 pick getbmphdr dat
if. -. bits e. 4 8 24 do.
  sminfo 'Toolbar';'Only 4, 8 or 24 bit bitmaps supported by Toolbar' return.
end.
BMP=: readbmp TBFN
'rws cls'=. $ BMP
cnt=. cls % 16
if. cnt ~: <.cnt do.
  sminfo 'Toolbar';'Bitmaps should have a width of 16 pixels' return.
end.

wtbar_showbar''
wd 'set tbflat ',":1 e. 'tbstyle_flat' E. TBDS
wd 'setcaption tbname *',TBFN
wd 'set toolbardef *',TBDF
wd 'pas 0 0'
)

NB. =========================================================
wtbar_showbar=: 3 : 0

'rws cls'=. $ BMP
cnt=. cls % 16

NB. ---------------------------------------------------------
wh=. _2 {. 0 ". wd 'qchildxywhx tbbmp'
scl=. <./ wh % cls,rws
'w h'=. <. scl * cls,rws
exp=. (- 0: , }:) <. 0.5 + +/\ rws $ h % rws
bmp=. exp # BMP
exp=. (- 0: , }:) <. 0.5 + +/\ cls $ w % cls
bmp=. exp #"1 bmp

glsel 'tbbmp'
glclear''
glrgb 0 ". wd 'qcolor 15'
glpen 0 0
glbrush''
glrect 0 0,wh
glpixels (0 0, |.$bmp), ,bmp

NB. ---------------------------------------------------------
wh=. _2 {. 0 ". wd 'qchildxywhx tbids'
glsel 'tbids'
glclear''
glrgb 0 ". wd 'qcolor 15'
glpen 0 0
glbrush''
glrect 0 0,wh
glrgb 0 0 0
glfont GFONT
pos=. <. (({.scl) * 8 + 16 * i. cnt) ,. 2
for_i. i. cnt do.
  gltextxy i { pos
  gltext ": i
end.
)

NB. =========================================================
NB.*getbmphdr v read header from bitmap file
NB. returns:  bitsize, rows, columns
getbmphdr=: 3 : 0
toi=. 256&#.@(a.&i.)@(|."1)
dat=. y
bits=. toi 28 29 {dat
if. toi 30 31 32 33{dat do.
  sminfo 'Toolbar';'Compressed format not supported'
  0 return.
end.
'off shdr cls rws'=. toi (10+i.4 4){dat
bits,rws,cls
)

NB. =========================================================
wtbar_apply_button=: 3 : 0
applytoolbardef ''
wtbar_showdef''
wd 'setfocus toolbardef'
)

NB. =========================================================
wtbar_help_button=: 3 : 0
htmlhelp_j_ 'user\form_editor_overview.htm'
)

NB. =========================================================
wtbar_close=: 3 : 0
applytoolbardef ''
wd 'pclose'
)

NB. =========================================================
wtbar_cancel_button=: 3 : 0
wd'pclose'
)

NB. =========================================================
wtbar_tbfile_button=: 3 : 0
while. 1 do.
  j=. '"Bitmap Files(*.bmp)|*.bmp" ofn_filemustexist ofn_nochangedir'
  d=. jpath '~system'
  f=. wd 'mbopen "Select Bitmap File" "',d,'" "" ',j
  break.
end.
if. isempty f do. return. end.
if. TBFN -: f do. return. end.
TBFN=: f
TBR=: readtoolbardef TBFN;TBDS;toolbardef
wtbar_run 1
)

NB. =========================================================
wtbar_tbflat_button=: 3 : 0
TBDS=: ('1'={. tbflat) # 'tbstyle_flat'
)

NB. =========================================================
wtbar_ok_button=: wtbar_close
wtbar_cancel=: wtbar_cancel_button
wtbar_tbbmp_paint=: wtbar_showbar

NB. =========================================================
applytoolbardef=: 3 : 0
TBR=: readtoolbardef TBFN;TBDS;toolbardef
drawpaint''
selecttoolbar ''
)

NB. =========================================================
gettoolbardef=: 3 : 0
if. 0 = # y do. 3 $ <'' return. end.
ind=. ''
txt=. ''
tbr=. cutopen y
tbr=. (tbr i.&> ';') {. each tbr
tbr=. deb each tbr
tbr=. (0 < # &> tbr) # tbr
sty=. ''
for_m. tbr do.
  m=. > m
  x=. m i. ' '
  select. x {. m
  case. 'tbar' do.
    val=. deb 5 }. m
    if. '"' = {.val do.
      val=. }. val
      ndx=. val i. '"'
    else.
      ndx=. val i. ' '
    end.
    file=. ndx {. val
    val=. deb (ndx + 1) }. val
    sty=. deb (val i. ' ') }. val
  case. 'tbarset' do.
    sel=. ' ', deb x }. m
    sep=. (sel = ' ') > ~:/\ sel = '"'
    'id cp sc tt sh'=. 5 {. (sep <;._1 sel) -. each '"'
    if. #id do.
      txt=. txt, addLF id,'  ',sc,'  ',tt,'  _  ',sh
    else.
      txt=. txt, addLF sc
    end.
  case. 'tbarshow' do.
  case. do.
    info 'Unrecognized toolbar command: ',m
  end.
end.
file;sty;txt
)

NB. =========================================================
readtoolbardef=: 3 : 0
'file sty txt'=. y
if. 0 = # txt do. '' return. end.
tbr=. a: -.~ deb each <;._2 txt,LF
if. #sty do.
  sty=. ' ',(":#tbr),' ',sty
end.
r=. <'tbar ',(dquote deb file),sty
for_m. tbr do.
  ind=. ": m_index
  m=. > m
  x=. m i. ' '
  id=. x {. m
  if. _1 ~: _1 ". id do.
    r=. r, <'tbarset "" ',ind, ' ',id
  else.
    m=. deb x }. m
    x=. m i. ' '
    cp=. x {. m
    m=. deb x }. m
    x=. m i. '_'
    tt=. dquote deb x {. m
    sh=. dquote deb (1 + x) }. m
    r=. r, < 'tbarset', ; ' ',each id;ind;cp;tt;sh
  end.
end.
r=. r , <'tbarshow'
; r ,each (<';',LF)
)
