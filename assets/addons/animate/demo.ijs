require 'files regex jview'

coclass 'panimdemo'

F=: 0 : 0
pc f;pn "Animation Demos";
xywh 130 16 34 11;cc ok button leftmove rightmove;cn "OK";
xywh 130 34 34 11;cc view button leftmove rightmove;cn "View";
xywh 130 56 34 11;cc close button leftmove rightmove;cn "Close";
xywh 6 16 116 100;cc lst listbox ws_vscroll rightmove bottommove;
xywh 8 6 50 10;cc st1 static;cn "List of demos";
pas 6 6;pcenter;
rem form end;
)

DEMODIR=: _8}.(4!:3''){::~4!:4 <'F_panimdemo_'

create=: 3 : 0
  wd F
  HWND=: wd'qhwndp'
  run''
)

destroy=: 3 : 0
  wd'pclose'
  codestroy ''
)

run=: 3 : 0
  wd 'set lst *',demos''
  wd 'setselect lst 0'
  wd 'pshow'
)

f_ok_button=: 3 : 0
  if. 0 = #sn=. scriptname'' do. '' return. end.
  0!:0 <sn
  src=. fread sn
  cls=. '(?<=coclass '')[^'']*' rxfirst src
  '' conew cls
)

f_view_button=: 3 : 0
  if. 0 = #sn=. scriptname'' do. '' return. end.
  (wdview fread) sn
  empty''
)

scriptname=: 3 : 0
  if. 0 = #lst_select do. '' return. end.
  DEMODIR,'.ijs',~' '(i.~ {. ])lst
)

demos=: 3 : 0
  r=. ''
  for_f. {."1]1!:0<DEMODIR,'*.ijs' do.
    src=. fread DEMODIR,>f
    des=. ('(?<=NB.',' demo - )[^\r\n]*') rxfirst src
    if. 0=#des do. continue. end.
    r=. r,(_4}.>f),' - ',des,LF
  end.
  r
)

f_lst_button=: f_ok_button
f_close_button=: f_close
f_close=: destroy

NB. =========================================================
cocurrent 'base'
'' conew 'panimdemo'

