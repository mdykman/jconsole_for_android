NB. code

FORMEVENTS=: <;._2 (0 : 0)
cancel
close
default
enter
handler
run
)

NB. =========================================================
WCODE=: 0 : 0
pc wcode owner;
xywh 4 7 45 64;cc g0 groupbox;cn "Event type";
xywh 9 18 38 9;cc wccontrol radiobutton;cn "control";
xywh 9 30 38 9;cc wcfkey radiobutton group;cn "fkey";
xywh 9 42 38 9;cc wcform radiobutton group;cn "form";
xywh 9 54 38 9;cc wcorphan radiobutton group;cn "orphan";
xywh 56 7 90 66;cc wclist listbox ws_vscroll;
xywh 151 9 36 12;cc wcclose button;cn "Close";
xywh 151 24 36 12;cc wccode button;cn "Code...";
xywh 151 39 36 12;cc wchelp button;cn "Help";
pas 3 4;pcenter;
rem form end;
)

NB. =========================================================
wcode_run=: 3 : 0
wd WCODE
HCODE=: wd 'qhwndp'
wd 'set wccontrol 1'
'wccontrol wcfkey wcform wcorphan'=: ": each 1 0 0 0
wclist=: ''
wcode_show 0
wd 'pn "Code - ',PID,'"'
wd 'pshow;'
)

NB. =========================================================
wcode_wccode_button=: 3 : 0
smopen FNAME
dat=. smread''
if. '1' e. wccontrol,wcfkey,wcform do.
  dat=. dat, LF, PID,'_',(wclist -. ' '),'=: 3 : 0',LF,')',LF
  smwrite dat
  wcode_show''
  smfocus''
elseif. # j=. wclist -. ' ' do.
  ndx=. 1 i.~ (PID,'_', j) E. dat
  smsetselect ndx,ndx,0
  smfocus
end.
)

NB. =========================================================
wcode_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
wcode_show=: 3 : 0
smopen FNAME
GLOBALS=: globals smread ''
wd 'psel ',HCODE
select. (wccontrol,wcfkey,wcform,wcorphan) i. '1'
case. 0 do.
  wcodelist controlevents''
case. 1 do.
  wcodelist fkeyevents''
case. 2 do.
  wcodelist FORMEVENTS
case. 3 do.
  inc=. FORMEVENTS,(controlevents''),fkeyevents''
  nms=. /:~ GLOBALS -. inc -. each ' '
  wd 'set wclist ',towords dblquote each nms
end.
)

NB. =========================================================
wcode_wchelp_button=: 3 : 0
htmlhelp_j_ 'user\form_editor_overview.htm'
)

NB. =========================================================
wcodelist=: 3 : 0
nms=. y -. each ' '
ndx=. nms index <wclist -. ' '
msk=. nms e. GLOBALS
nms=. msk /:~ (msk { '  ';'') ,each y
wd 'set wclist ',towords dblquote each nms
wd 'setselect wclist ',":ndx
)

NB. =========================================================
wcode_wccontrol_button=: wcode_show
wcode_wcfkey_button=: wcode_show
wcode_wcform_button=: wcode_show
wcode_wcorphan_button=: wcode_show

NB. =========================================================
wcode_wcclose_button=: wcode_cancel=: wcode_close
wcode_wclist_button=: wcode_enter=: wcode_wccode_button

NB. =========================================================
controlevents=: 3 : 0
evt=. (({."1 CONTROLS) i. CLS) { 6{"1 CONTROLS
ctl=. ; (IDS ,each '_') (<@[ ,each ]) each evt
mnu=. <;._2 MNU
msk=. (<'menu ') = 5 {. each mnu
mnu=. 5 }. each msk # mnu
mnu=. (mnu i. &> ' ') {. each mnu
mnu=. mnu ,each <'_button'
~. ctl, mnu
)

NB. =========================================================
fkeyevents=: 3 : 0
f=. 'f' ,each ": each 1 + i.12
r=. f
r=. r, f ,each <' ctrl'
r=. r, f ,each <' shift'
r=. r, f ,each <' ctrlshift'
a=. a. {~ ; (a. i. 'a0') + each i. each 26 10
r=. r, a ,each <' ctrl'
r=. r, a ,each <' ctrlshift'
r=. r -. 'c ctrl';'v ctrl';'x ctrl';'z ctrl'
r ,each <'_fkey'
)
