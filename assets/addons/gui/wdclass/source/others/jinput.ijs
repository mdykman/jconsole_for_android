NB. provides jinput form
NB.
NB. methods:
NB. create
NB.
NB. calls input_result on completion

require 'droidwd gtkwd'

coclass 'jinput'

NB. =========================================================
NB.*create v create input form
NB. form: create prompt [;default_entry [;title]]
NB. on OK calls input_result in creator locale

create=: a_run

destroy=: codestroy

A=: 0 : 0
pc a dialog owner;
xywh 4 11 162 10;cc prompt static rightmove;cn "";
xywh 3 23 162 12;cc edit edit ws_border es_autohscroll rightmove;
xywh 175 9 38 12;cc ok button leftmove rightmove;cn "OK";
xywh 175 23 38 12;cc cancel button leftmove rightmove;cn "Cancel";
pas 4 5;pcenter;
rem form end;
)

NB. =========================================================
a_run=: 3 : 0
'p d t'=. 3{. boxopen y
wd A
wd 'pn *',t,(0=#t)#'Input'
wd 'set prompt *',p
wd 'set edit *',d
wd 'setfocus edit'
wd 'pshow;'
)

NB. =========================================================
a_close=: 3 : 0
wd'pclose'
destroy''
)

NB. =========================================================
a_cancel_button=: a_close
a_edit_button=: a_ok_button

NB. =========================================================
NB. OK close, enables and selects our owner
a_ok_button=: 3 : 0
wd 'pclose'
try. input_result__COCREATOR edit catch. end.
destroy''
)
