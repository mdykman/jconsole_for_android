NB. form

DELKEY=: 29

NB. =========================================================
form_cancel=: 3 : 0
destroy''
)

NB. =========================================================
form_close=: 3 : 0
saveform''
smfocus''
destroy''
)

NB. =========================================================
NB. handle characters
form_g_char=: 3 : 0
if. DELKEY = a.i.{.sysdata do.
  deletecc''
end.
)

NB. =========================================================
form_newcc_button=: newcc_run

NB. =========================================================
form_parent_button=: 3 : 0
wd 'mb parent *set parent styles etc'
)

NB. =========================================================
form_read=: 3 : 0
r=. PDF,'=: 0 : 0',LF
r=. r, form_create 0
r,LF,PFE,LF
)

NB. =========================================================
NB. form_create
NB. create form definition
NB. y = 1 = add closeok and ptop for view
form_create=: 3 : 0
view=. {. y, 0
pst=. PST , view # ' closeok'
r=. deb 'pc ',PID,' ',pst
r=. r,';',(*#PCN) # 'pn "',PCN,'";'
r=. r,LF
r=. r,MNU
r=. r,SBR
r=. r,TBR
r=. r, formcc_create 1
r=. r,'pas ',(":PAS),';'
r=. r, ; ,&';' each ~. POP, view # <'ptop'
r=. r,(*#PMV) # 'pmove ',(":PMV),';'
)

NB. =========================================================
NB. formcc_create
NB. create cc definitions
NB.   y=0  create for form editor display
NB.     1  create final form
formcc_create=: 3 : 0
final=. y
NB. cns=. (CPS ~: IDS) # each CPS
cns=. CPS
cap=. (({."1 CONTROLS) i. CLS) { (5 {"1 CONTROLS),<0
ids=. IDS
if. -. final do.
  if. #ndx=. I. ids e. FORMISIGRAPHS do.
    new=. ndx { ids
    whilst. 1 e. new e. ids do.
      new=. new ,each '0'
    end.
    ids=. new ndx } ids
  end.
end.
dat=. ids,.CLS,.STY,.cns,.cap
ccs=. CCS
grp=. 0
r=. ''
for_i. i.#ids do.
  'd c s n p'=. i { dat
  s=. ws_del s
  select. c
  case. 'button' do.
    s=. s -. (-.final) # <'bs_ownerdraw'
  case. 'radiobutton' do.
    if. grp do.
      s=. s, (<'group') -. s
    else.
      s=. s -. <'group'
    end.
  case. 'isigraph' do.
    c=. final pick 'editm';'isigraph'
  case. 'tab' do.
    c=. final pick 'groupbox';'tab'
  case. 'ocx' do.
    c=. final pick 'editm';'ocx:',n
    n=. ''
  end.
  grp=. c -: 'radiobutton'
  s=. towords s
  s=. (* # s) # ' ',s
  if. p *. #n do.
    n=. 'cn "',n,'";'
  else.
    n=. ''
  end.
  r=. r,'xywh ',": i { ccs
  r=. r,';cc ',d,' ',c,s,';',n,LF
end.
)

NB. =========================================================
form_g_copy=: copyselect
form_g_paste=: pasteselect

form_nctrl_fkey=: form_newcc_button
form_pctrl_fkey=: form_parent_button
form_sctrl_fkey=: saveform
form_tctrl_fkey=: order

NB. =========================================================
selectform=: 3 : 0
wd 'psel ',HWNDP
)

NB. =========================================================
copyselect=: 3 : 0
copybuffer=: SELECT
)

NB. =========================================================
pasteselect=: 3 : 0
if. 0=#copybuffer do. return. end.
for_cp. copybuffer do.
  pastecontrol (cp{CLS),(cp{IDS),(cp{CPS),(<cp{CCS),(cp{STY)
end.
SELECT=: copybuffer=: (-#copybuffer){.i.#IDS
drawpaint''
bufsnap''
1
)

NB. =========================================================
pastecontrol=: 3 : 0
'class id caption ccs sty'=. y
if. 0 = #class do.
  info 'First select a class'
  0 return.
end.
if. 0 = #id do.
  id=. 'cc', class
end.
CCS=: CCS, 6 6 0 0 + ccs
IDS=: IDS, <id
CPS=: CPS, <caption
CLS=: CLS, <class
STY=: STY, <sty
drawpaint''
bufsnap''
1
)

