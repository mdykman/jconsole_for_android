NB. standard windows library
NB.
NB. These definitions are assumed available to other windows programs

NB. wd            main window driver
NB. wde           wd error - as wd but displays error and signals break
NB. wdbox         box wd argument
NB. wdcenter      center form on another
NB. wdclipread    read clipboard
NB. wdclipwrite   write to clipboard
NB. wdfit         ensure form fits in window
NB. wdforms       wd form info
NB. wdget         get values from matrix, e.g. wd'q'
NB. wdhandler     wd handler
NB. wdinfo        information box
NB. wdishandle    if a form handle
NB. wdisparent    if a parent window
NB. wdmove        position window
NB. wdpclose      close parent window
NB. wdqshow       display result of wdq
NB. wdquery       query box
NB. wdreset       reset window driver
NB. wdstatus      put status message on screen
NB. mbopen        cover verb for jpathsep wd mbopen
NB. mbsave        cover verb for jpathsep wd mbsave

18!:4 <'z'

NB. =========================================================
NB.*wd v main window driver, emulator for 11!:0
wd_z_=: 3 : 0"1
wd_droidwd_ y [ WDLOC_droidwd_=: >coname''
)

NB. =========================================================
NB.*wdreset v reset window driver
wdreset=: wd bind 'reset'

NB.*wdclipread v read clipboard
wdclipread=: toJ @ wd bind 'clippaste'

NB. =========================================================
NB.*wdbox v box wd argument
NB. use this to analyze arguments to wd
NB. in code: whs=whitepace, del=delimiters
wdbox=: 3 : 0
whs=. 8 9 10 13 32{a.
del=. 127{a.
dat=. ' ',y
msk=. ~:/\ dat e. del
mqt=. 2: +./\ 0: , 2: | +/\ @ (=&'"')
mquote=. -. mqt dat
msk=. mquote *. msk
ndx=. 1 i.~ msk < dat='*'
end=. < }. ndx }. dat
dat=. ndx{.dat
msk=. mquote *.(ndx {. msk) < dat e. whs
dat=. (msk <;._1 dat) , end
a: -.~ dat -. each <del
)

NB. =========================================================
NB.*wdcenter v center form on another
NB. form: wdcenter xywh
NB. use this to center a form on another
wdcenter=: 3 : 0
'fx fy fw fh'=. 0&". :: ] y
'sx sy'=. sxy=. 2 {. 0 ". wd 'qm'
'w h'=. sxy <. _2 {. 0 ". wd 'qformx'
x=. 0 >. (sx-w) <. fx + <. -: fw-w
y=. 0 >. (sy-h) <. fy + <. -: fh-h
wd 'pmovex ',": x,y,w,h
)

NB. =========================================================
NB.*wdclipwrite v write to clipboard
wdclipwrite=: 3 : 0
txt=. y
if. L. txt do.
  txt=. }. ; (LF&, @ , @ ": each) txt
else.
  txt=. ": txt
  if. 1 < #$txt do. txt=. }. , LF,"1 txt end.
end.
wd 'clipcopy *',toHOST txt
#txt
)

NB. =========================================================
NB.*wde v as wd but displays error and signals break
wde=: 3 : 0
try. res=. wd y
catch.
  err=. wd 'qer'
  ndx=. >: err i. ':'
  msg=. ndx {. err
  pos=. {.". ndx }. err
  cmd=. (>:j i.';') {. j=. pos}.y
  if. 50 < #cmd do.
    cmd=. (47{.cmd),'...' end.
  wdinfo 'Window Driver';'wd error ',msg,LF,cmd
  wderr=. 13!:8@1:
  wderr ''
end.
)

NB. =========================================================
NB.*wdfit v fit form in window
NB. y is two integers for horizontal and vertical
NB. in each case, the entire form will be shown
NB.
NB. values are:
NB.   0   move the side out of view back into the window
NB.       - typically reduces the form size
NB.   1   move the form so it is all visible
NB.       - typically leaves the form size unchanged
NB.   2   stretch the form to the window
NB.   3   maximize the form to full screen, hiding caption and borders
NB.
NB. an empty argument is treated as 1 1
NB.
NB. wd'qm' - return system metrics:
NB. 0-1 screen width, screen height,
NB. 2-3 x logical unit, y logical unit,
NB. 4-5 cxborder, cyborder,
NB. 6-7 cxfixedframe, cyfixedframe,
NB. 8-9 cxframe, cyframe,
NB. 10-11 cycaption, cymenu,
NB. 12-15 desktop xywh
wdfit=: 3 : 0

'mx my'=. 2{.y,(#y)}.1 1
'x y w h'=. 0 ". wd 'qformx'
'fx fy zx zy yc ym sx sy sw sh'=. 6 }. 0 ". wd 'qm'

select. mx
case. 0 do.
  w=. w - 0 <. sx - x
  x=. x >. sx
  w=. 0 >. w <. sx + sw - x
case. 1 do.
  x=. sx >. x <. (sx+sw) - w
  w=. 0 >. w <. sx + sw - x
case. 2 do.
  x=. sx
  w=. sw
case. 3 do.
  x=. - fx
  w=. sw + 2 * fx
end.

select. my
case. 0 do.
  h=. h - 0 <. sy - y
  y=. y >. sy
  h=. 0 >. h <. sy + sh - y
case. 1 do.
  y=. sy >. y <. (sy+sh) - h
  h=. 0 >. h <. sy + sh - y
case. 2 do.
  y=. sy
  h=. sh
case. 3 do.
  y=. - yc + fy
  h=. sh + yc + 2 * fy
end.

wd 'pmovex ',":x,y,w,h
)

NB. =========================================================
NB.*wdforms v info about all forms
NB.
NB. columns are:
NB.  0 name
NB.  1 handle
NB.  2 locale
NB.  3 type: jijx, jijs or empty
NB.  4 recent use (sequence number)
NB.  5 title
NB.
NB. e.g.
NB.    wdforms''
NB. +-----------+---+--------+----+--+---------------+
NB. |jijs       |100|0       |jijx|10|1.ijx          |
NB. +-----------+---+--------+----+--+---------------+
NB. |projectform|102|jproject|    |8 |Project Manager|
NB. +-----------+---+--------+----+--+---------------+
NB. |jijs       |198|1       |jijs|9 |winlib.ijs     |
NB. +-----------+---+--------+----+--+---------------+
NB. wdforms=: <;._2;._2 @ wd bind 'qpx'
wdforms=: 3 : 0
if. 0=# z=. <;._2;._2 @ wd 'qpx' do. z=. 0 6$<'' end.
z
)

NB. =========================================================
NB.*wdget v get values from matrix, e.g. wd'q'
NB. utility to index 2-column boxed array, e.g. result of wd 'q'
NB. form:  names wdget data
NB. returns items in second column indexed on names in first column
NB. result is boxed if left argument is boxed
NB. e.g. 'sysfocus' wdget wdq
wdget=: 4 : 0
nms=. {."1 y
vls=. {:"1 y
if. L. x do. vls {~ nms i. ,&.>x
else. > vls {~ nms i. <,x
end.
)

SYSPPC=: (<'syschild'),.'ppcnext';'ppcprevious'

NB. =========================================================
NB.*wdhandler v wd handler
NB. runs in form locale
NB. sets global event data: wdq
NB. runs first found of: form_handler, form_event, form_default,
NB. with global event variables from wdq
NB. if debug is off, wraps event handler in try. catch.
NB. catch exits if error message is the last picked up by debug.
wdhandler=: 3 : 0
wdq=: wd 'q'
wd_val=. {:"1 wdq
({."1 wdq)=: wd_val
if. 3=4!:0<'wdhandler_debug' do.
  try. wdhandler_debug'' catch. end.
end.
wd_ndx=. 1 i.~ 3 = 4!:0 [ 3 {. wd_val
if. 3 > wd_ndx do.
  wd_fn=. > wd_ndx { wd_val
  if. 13!:17'' do.
    wd_fn~''
  else.
    try. wd_fn~''
    catch.
      wd_err=. 13!:12''
      if. 0=4!:0 <'ERM_j_' do.
        wd_erm=. ERM_j_
        ERM_j_=: ''
        if. wd_erm -: wd_err do. i.0 0 return. end.
      end.
      wd_err=. LF,,LF,.}.;._2 wd_err
      wdinfo 'wdhandler';'error in: ',wd_fn,wd_err
    end.
  end.
end.
i.0 0
)

NB. =========================================================
NB.*wdinfo v information box
NB. syntax: wdinfo [title;] message
wdinfo=: 3 : 0
'a b'=. _2{. boxopen y
if. 0<Debugwd_droidwd_ do.
  smoutput b return.
end.
if. 2=#$b=. ":b do. b=. }.,LF,.b end.
f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
empty wd 'mb ',(f a),' ',(f b),' mb_iconinformation'
)

NB. =========================================================
NB.*wdisparent v return 1 if a parent window
wdisparent=: boxopen e. <;._2 @ wd bind 'qp'

NB. =========================================================
NB.*wdishandle v return 1 if a window handle
wdishandle=: boxopen e. 1: {"1 wdforms

NB. =========================================================
NB.*wdmove v position window, relative to side of screen
NB. form: [window] wdmove offset
NB.
NB. offset is the xy offset.
NB.   if  >: 0  the offset is from topleft
NB.   if  < 0   the offset is from bottomright (less 1)
NB.
NB. e.g.
NB.     0 0  = topleft
NB.   _1 _1  = bottomright
NB.    5 _11 = 5 from left, 10 from bottom
wdmove=: 3 : 0
'' wdmove y
:
'px py'=. y
'sx sy sw sh'=. 12 13 14 15 { 0 ". wd 'qm'
if. #x do. wd 'psel ',x end.
'x y w h'=. 0 ". wd 'qformx'
if. px < 0 do. px=. sw - w - 1 + px end.
if. py < 0 do. py=. sh - h - 1 + py end.
wd 'pmovex ',": (px+sx),(py+sy),w,h
)

NB. =========================================================
NB.*wdpclose v close parent window
wdpclose=: [: wd :: empty 'psel ' , ,&';pclose'

NB. =========================================================
NB.*wdqshow v display result of wdq
NB. display wdq result - useful for testing forms
wdqshow=: 3 : 0
txt=. (>{."1 wdq),.TAB,.>{:"1 wdq
wdinfo 'wdq';(60 <. {:$txt) {."1 txt
)

NB. =========================================================
NB.*wdquery v query box
NB. form: [opt] wdquery [title;] message
NB.   opt has one or two elements:
NB.    0{  = 0    okcancel          (ok=0 cancel=1)
NB.          1    retrycancel       (retry=0 cancel=1)
NB.          2    yesno             (yes=0 no=1)
NB.          3    yesnocancel       (yes=0 no=1 cancel=2)
NB.          4    abortretryignore  (abort=0 retry=1 ignore=2)
NB.    1{ = default button (0, 1 or 2)
wdquery=: 3 : 0
0 wdquery y
:
msg=. ;:'okcancel retrycancel yesno yesnocancel abortretryignore'
res=. ;:'OK CANCEL RETRY YES NO ABORT IGNORE'
ndx=. 0 1;2 1;3 4;3 4 1;5 2 6
't d'=. 2{.x [ 'a b'=. _2{. boxopen y
if. 2=#$b=. ":b do. b=. }.,LF,.b end.
f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
m=. 'mb ',(f a),' ',(f b),' mb_iconquestion mb_',>t{msg
if. d e. 1 2 do. m=. m,' mb_defbutton',":>:d end.
0 [ wd m
)

NB. =========================================================
NB.*wdselect v selection box
NB. windows selection box
NB.
NB. y is a either:   boxed list of choices
NB.             or:   title ; <boxed list of choices
NB.    if y is empty, closes selection box if open.
NB.
NB. x is optional of up to 3 values (default 0). the second and
NB.    third options are only referenced when the box is created:
NB.   0{ initial selection
NB.   1{ 0=single selection, 1=multiple selection
NB.   2{ 0=close on exit, 1=leave open if selection made
NB.
NB. returns 2 item boxed list:
NB.   0{ 0=cancel, 1=accept
NB.   1{ indices of selections
wdselect=: 3 : 0
0 wdselect y
:
if. 0=#y do.
  empty wd 'psel wdselect;pclose' return.
end.

'n s e'=. 3{.x

if. 2=L.y do. 'hdr sel'=. y
else. hdr=. '' [ sel=. y
end.

'r c'=. $,.>sel
sel=. ;sel ,each LF

'c r'=. (12,5*6>r) + >. 4 8 * >. c,r
c=. 205 <. 80 >. (4*#hdr) >. c
r=. 128 <. r

if. (<'wdselect') e. <;._2 wd 'qp' do.
  wd 'psel wdselect;pn '",hdr,'";'
else.
  wd 'pc wdselect;pn *',hdr
  wd 'xywh 4 4 ',":c,r
  wd 'cc l0 listbox ws_vscroll rightmove bottommove',s#' lbs_multiplesel'
  wd 'setfont l0 ',PROFONT
  wd 'cc e0 editm; setshow e0 0'
  wd 'xywh ',(":14+c),' 6 36 12;cc ok button leftmove rightmove bottommove;cn "OK";'
  wd 'xywh ',(":14+c),' 21 36 12;cc cancel button leftmove rightmove bottommove;cn "Cancel";'
  wd 'pas 4 2;pcenter;'
end.

wd 'set e0 *',sel
wd 'set l0 *',sel
wd (_1 ~: n) # 'setselect l0 ',":n
wd 'setfocus l0'
wd 'pshow'

while. 1 do.
  wdq=. wd 'wait;q'
  ({."1 wdq)=. {:"1 wdq
  done=. (<'cancel') e. systype;syschild
  button=. systype -: 'button'
  ok=. button *. (<syschild) e. ;:'l0 ok enter'
  if. ok +. done do.
    wd (ok *: e)#'pclose'
    ok;".l0_select
    break.
  end.
end.
)

NB. =========================================================
NB.*wdstatus v put status message on screen
NB. write status message on screen
NB.
NB. {title} wdstatus message    - write message
NB.         wdstatus ''         - close message box
NB.
NB. default text size is 1 row of 50 characters.
NB. for a larger size, call wdstatus initially with a message
NB. of the required size (pad with blanks if necessary).
NB. once created, the message box is not resized.
wdstatus=: 3 : 0
'' wdstatus y
:
if. 0 e. $y do.
  empty wd :: [ 'psel status;pclose'
  return.
end.

msg=. y
if. 2=#$msg=. ":msg do. msg=. }.,LF,.msg
else. msg=. toJ (-LF={:msg)}.msg
end.

pn=. (*#x)#'pn ',DEL,x,DEL,';'

if. (<'status') e. <;._2 wd 'qp;' do.
  wd 'psel status;',pn
else.
  size=. |. 0 100 >. 8 4*$];._2 msg,LF
  wd 'pc status closeok;',pn
  wd 'xywh 10 10 ',(":size),';'
  wd 'cc s0 static;'
  wd 'pas 10 10;pcenter;'
end.

wd 'set s0 *',msg
wd 'pshow;'
)

NB. =========================================================
NB. mbopen        cover verb for jpathsep wd mbopen
mbopen=: 3 : 0
jpathsep wd 8 u: 'mbopen ',y
)

NB. =========================================================
NB. mbsave        cover verb for jpathsep wd mbsave
mbsave=: 3 : 0
jpathsep wd 8 u: 'mbsave ',y
)
