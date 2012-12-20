NB. menu

WMENU=: 0 : 0
pc wmenu owner;
xywh 1 20 158 11;cc s0 static rightmove;cn "Definition: id caption _  shortcut _ statushelp _ tooltip";
xywh 0 33 253 150;cc menudef editm ws_vscroll rightmove bottommove;
xywh 170 3 40 12;cc apply button leftmove rightmove;cn "&Apply";
xywh 170 17 40 12;cc help button leftmove rightmove;cn "&Help";
xywh 211 3 40 12;cc ok button leftmove rightmove;cn "OK";
xywh 211 17 40 12;cc cancel button leftmove rightmove;cn "Cancel";
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
wmenu_run=: 3 : 0
wd WMENU
wd 'pn "Menu - ',PID,'"'
selectmenu=: wd bind ('psel ',wd 'qhwndp')
wd 'set menudef *',getmenudef MNU
wd 'pshow;'
)

NB. =========================================================
wmenu_apply_button=: 3 : 0
applymenudef ''
wd 'set menudef *',getmenudef MNU
wd 'setfocus menudef'
)

NB. =========================================================
wmenu_help_button=: 3 : 0
htmlhelp_j_ 'user\form_editor_overview.htm'
)

NB. =========================================================
wmenu_close=: 3 : 0
applymenudef ''
wd 'pclose'
)

NB. =========================================================
wmenu_cancel_button=: 3 : 0
wd'pclose'
)

NB. =========================================================
wmenu_ok_button=: wmenu_close
wmenu_cancel=: wmenu_cancel_button

NB. =========================================================
applymenudef=: 3 : 0
new=. readmenudef menudef
if. MNU -: new do. return. end.
MNU=: new
drawpaint''
selectmenu ''
)

NB. =========================================================
getmenudef=: 3 : 0
if. 0 = # y do. '' return. end.
ind=. ''
r=. ''
mnu=. cutopen y
mnu=. (mnu i.&> ';') {. each mnu
for_m. mnu do.
  m=. > m
  x=. m i. ' '
  select. x {. m
  case. 'menu' do.
    txt=. ' ', deb x }. m
    sep=. (txt = ' ') > ~:/\ txt = '"'
    'id cp sc tt sh'=. 5 {. (sep <;._1 txt) -. each '"'
    sel=. id,' ',cp,' _ ',sc,' _ ',tt,' _ ',sh
    sel=. (-. *./\. sel e. ' _') # sel
    r=. r, addLF ind, sel
  case. 'menupop' do.
    r=. r, addLF ind , (x }. m) -. ' "'
    ind=. ind, '  '
  case. 'menupopz' do.
    r=. r, addLF ind, '+'
    ind=. 2 }. ind
  case. 'menusep' do.
    r=. r, addLF ind, '-'
  case. do.
    info 'Unrecognized menu command: ',m
  end.
end.
r
)

NB. =========================================================
readmenudef=: 3 : 0
def=. y
if. 0 = # def do. '' return. end.
ind=. ''
r=. ''
mnu=. a: -.~ deb each cutopen def
for_m. mnu do.
  m=. > m
  if. '+' = {. m do.
    r=. r, <'menupopz'
  elseif. '-' = {. m do.
    r=. r, <'menusep'
  elseif. do.
    x=. m i. ' '
    id=. x {. m
    bal=. deb x }. m
    if. #bal do.
      bal=. 4 {. <;._1 '_', bal
      bal=. dblquote each deb each bal
      r=. r, <'menu ',id,' ',towords bal
    else.
      r=. r,<'menupop ',dblquote id
    end.
  end.
end.
; r ,each (<';',LF)
)
