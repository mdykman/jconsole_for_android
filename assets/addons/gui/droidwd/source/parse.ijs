NB. parse

wd=: 3 : 0
z=. ''
wdptr0=: 0
while. #y do.
  if. 0<s1=. clws y do.
    wdptr0=: wdptr0 + s1
    y=. s1}. y continue.
  end.
  s=. y e. ';'
  a=. y e. '*'
  q=. 2| +/\ y e. '"'
  d=. 2| +/\ y e. DEL
  s=. s *. -.q+.d
  a=. a *. -.q+.d
  if. (1 e. a) *. 1 e. s do.
    s1=. {.I.s [ a1=. {.I.a
    if. s1<a1 do.
      z=. wd1 s1{.y
      wdptr0=: wdptr0 + 1 + s1
      y=. (1+s1)}. y continue.
    else.
      z=. wd1 y break.
    end.
  elseif. 1 e. s do.
    s1=. {.I.s
    z=. wd1 s1{.y
    wdptr0=: wdptr0 + 1 + s1
    y=. (1+s1)}. y continue.
  elseif. do.
    z=. wd1 y break.
  end.
end.
z
)

wd1=: 3 : 0
if. 0=#y do. '' return. end.
smoutput^:(1<Debugwd) y      NB. echo all cmd
wdptr=: 0 [ wdstr=: y
t=. EMPTY    NB. wd result
if. (<'qer') -.@e.~ cmd=. shiftarg'' do. LASTCMD=: y [ WDERRN=: 0 end.
select. cmd
case. 'beep' do. wdbeep ''
case. 'cc' do. wdcc ''
case. 'clipcopy' do. wdclipcopy ''
case. 'clippaste' do. t=. wdclippaste ''
case. 'cn' do. wdcn ''
case. 'creategroup' do. wdcreategroup ''
case. 'fontdef' do. wdfontdef ''
case. 'mb' do. t=. wdmb ''
case. 'mbcolor' do. t=. ": 51$255
case. 'mbfont' do. t=. wdmbfont ''
case. 'mbopen' do. t=. wdmbopen ''
case. 'mbprinter' do. t=. wdmbprinter ''
case. 'mbsave' do. t=. wdmbsave ''
case. 'menu' do. wdmenu ''
case. 'menupop' do. wdmenupop ''
case. 'menupopz' do. wdmenupopz ''
case. 'menusep' do. wdmenusep ''
NB. case. 'menu' ; 'menupop' ; 'menupopz' ; 'menusep' do. wdmenus wdstr
case. 'msgs' do. wdmsgs ''
case. 'pactive' do. wdpactive ''
case. 'pas' do. wdpas ''
case. 'pc' do. wdpc ''
case. 'pcenter' do. wdpcenter ''
case. 'pclose' do. wdpclose ''
case. 'pgroup' do. wdpgroup ''
case. 'picon' do. wdpicon ''
case. 'pmove' do. wdpmove ''
case. 'pmovex' do. wdpmovex ''
case. 'pn' do. wdpn ''
case. 'psel' do. wdpsel ''
case. 'pshow' do. wdpshow ''
case. 'ptop' do. wdptop ''
case. 'qchildxywh' do. t=. wdqchildxywh ''
case. 'qchildxywhx' do. t=. wdqchildxywhx ''
case. 'qcolor' do. t=. wdqcolor ''
case. 'qd' do. t=. wdqd ''
case. 'qer' do. t=. wdqer ''
case. 'qformx' do. t=. wdqformx ''
case. 'qhwndc' do. t=. wdqhwndc ''
case. 'qhwndp' do. t=. wdqhwndp ''
case. 'qiox' do. t=. wdqiox ''
case. 'qm' do. t=. wdqm ''
case. 'qp' do. t=. wdqp ''
case. 'qprinters' do. t=. wdqprinters ''
case. 'qpx' do. t=. wdqpx ''
case. 'qscreen' do. t=. wdqscreen ''
case. 'qwd' do. t=. wdqwd ''
case. 'rem' do. ''
case. 'reset' do. wdreset ''
case. 'sbar' do. wdsbar ''
case. 'sbarset' do. wdsbarset ''
case. 'sbarshow' do. wdsbarshow ''
case. 'set' do. wdset ''
case. 'setcaption' do. wdsetcaption ''
case. 'setdelete' do. wdsetdelete ''
case. 'setedit' do. wdsetedit ''
case. 'setenable' do. wdsetenable ''
case. 'setfocus' do. wdsetfocus ''
case. 'setfont' do. wdsetfont ''
case. 'setinsert' do. wdsetinsert ''
case. 'setinvalid' do. wdsetinvalid ''
case. 'setlimit' do. wdsetlimit ''
case. 'setlocale' do. wdsetlocale ''
case. 'setmodified' do. wdsetmodified ''
case. 'setreadonly' do. wdsetreadonly ''
case. 'setreplace' do. wdsetreplace ''
case. 'setscroll' do. wdsetscroll ''
case. 'setselect' do. wdsetselect ''
case. 'setshow' do. wdsetshow ''
case. 'setxywh' do. wdsetxywh ''
case. 'setxywhx' do. wdsetxywhx ''
case. 'tbar' do. wdtbar ''
case. 'tbarset' do. wdtbarset ''
case. 'tbarshow' do. wdtbarshow ''
case. 'timer' do. wdtimer ''
case. 'xywh' do. wdxywh ''
case. ,'q' do. t=. wdq ''

NB. new cmd
case. 'rm' do. wdrm ''
case. 'setwrap' do. wdsetwrap ''

NB. TODO cmd
case. ;:'setbkgnd' do. ''
NB. session manager not supported
case. ;:'smcolor smkeywords smsetlog' do. ''  NB. ignore
case. 'sminputlog' do. t=. ''
NB. ole cmd not supported
case. ;:'oleget olegetlic oleinfo' do. t=. ''
case. ;:'oledlg oleenable oleid oleload olemethod olemethodx oleocx olerelease olesave oleset olesetlic' do. ''
NB. other ignored cmd
case. ;:'qhinst qhwndx qkeystate qrtf' do. t=. ''
case. ;:'clipcopyx clippastex pcolor security setcolor setcolwidth setpclip setupdate settabstops tnomsgs wait' do. ''

case. do. seterr 'invalid command : '
end.
if. ((<'qer') -.@e.~ cmd) *. 0~:WDERRN do. 13!:8[3 end.
(EMPTY-:t){::t;''
)
