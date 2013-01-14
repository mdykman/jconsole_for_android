NB. controls demos
NB. also:
NB. pc controls closeok
NB. pc controls escclose

Controls=: 0 : 0
pc controls;
rem make nested vertical, horizontal, vertical bins:;
bin vhv;
cc linear radiobutton;
cn "view linear";
cc boxed radiobutton group;
cn "view boxed";
cc tree radiobutton group;
cn "view tree";
bin zv;
cc gross radiobutton;
cc net radiobutton group;
cc paid checkbox;
set boxed 1;
set net 1;
bin z s1 z;
cc names combobox;
set names Bressoud Frye Rosen Wagon;
setselect names 2;
cc list listbox;
set list one "two turtle doves" three "four colly birds" five six seven;
cc entry edit;
set entry 盛大 abc 巨嘴鸟;
cc ted editm;
rem demonstrate bin and child stretch:;
bin h s2;
cc ok button;cn "Push Me";
cc cancel button;cn "Cancel";
setp ok stretch 1;
)

NB. =========================================================
controls_run=: 3 : 0
wd Controls
wd 'set ted *How grand to be a Toucan',LF,'Just think what Toucan do.'
wd 'pmovex 400 10 300 300'
wd 'pshow'
)

NB. =========================================================
controls_close=: 3 : 0
wd 'pclose'
)

showevents_jqtide_ 2
controls_run''
