NB. wizard

WIZARD=: 0 : 0
pc wizard;
xywh 160 8 38 12;cc next button;cn "Next";
xywh 160 23 38 12;cc back button;cn "Back";
xywh 160 47 38 12;cc cancel button;cn "Cancel";
xywh 6 6 150 75;cc static static;cn "";
xywh 150 91 50 10;cc sizer static;cn "";
pas 6 6;pcenter;
rem form end;
)

wizard_text=: 0 : 0
Text for wizard
)

wizard_run=: 3 : 0
wd WIZARD
NB. initialize form here
wizindex=: wizseq i. <'wizard'
wd'set static *',wizard_text
wd'setenable next ',":wizindex<<:#wizseq
wd'setenable back ',":0<wizindex
wd'setshow sizer 0'
wd 'pshow;'
)

wizard_next_button=: 3 : 0
wizard_close''
wizindex=: >:wizindex
".(>wizindex{wizseq),'_run 0'
)

wizard_back_button=: 3 : 0
wizard_close''
wizindex=: <:wizindex
".(>wizindex{wizseq),'_run 0'
)

wizard_close=: 3 : 0
wd'pclose'
)

wizard_cancel_button=: wizard_close
