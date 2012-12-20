
cocurrent 'base'

WFORM=: 'pc wform;',LF,'rem form end;',LF
temp=. jpath '~temp/base.ijs'

f=. jpath '~Public/gui/wdclass/formedit/base.ijs'
s=. jpath '~Public/gui/wdclass/formedit/allcontrols.ijs'
s=. jpath '~Public/gui/wdclass/formedit/simple.ijs'
load s

NB. d=. 'NB. base',LF,LF,'WFORM=: 0 : 0',LF,WBUTTONS,')',LF
d=. 'NB. base',LF,LF,'WFORM=: 0 : 0',LF,WFORM,')',LF
d fwrites temp

locFM_z_=: temp conew 'jformedit'
NB. start_jpm_''
NB. smoutput showdetail_jpm_ 'drawcontrols';locFM
NB. smoutput showdetail_jpm_ 'drawradiobutton';locFM
