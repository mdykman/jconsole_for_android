NB.cities demo -  windows program

CITIES=: 0 : 0
pc cities closeok qtwd;pn "City Distances";
bin hvh;
xywh 9 9 20 11;cc s0 static;cn "From:";
xywh 35 8 100 101;cc clist combolist ws_vscroll ws_border;
bin zhv;
xywh 6 28 62 36;cc dist groupbox;
xywh 9 39 57 12;cc Kilometers radiobutton;
xywh 9 51 57 11;cc Miles radiobutton group;
bin szv;
xywh 73 28 62 36;cc sort groupbox;
xywh 76 39 57 11;cc Alphabetic radiobutton;
xywh 76 51 57 11;cc Distance radiobutton group;cn "By Distance";
bin szzzv;
xywh 146 8 39 12;cc ok button;cn "OK";
xywh 146 23 39 12;cc cancel button;cn "Cancel";
bin szsz;
pas 6 6;pcenter;
rem form end;
)

cities_run=: 3 : 0
cityread''
wd CITIES
if. IFQT do.  NB. TODO jqt LF bug
  wd 'set clist ',; ('"'&,)&.> BNAMES,&.>'"'
else.
  wd 'set clist *',;BNAMES,&.>LF
end.
wd 'setselect clist ',":(#BNAMES)|.BNAMES i. <'Antwerp'
wd 'set Kilometers 1'
wd 'set Alphabetic 1'
wd 'pshow'
evtloop^:(-.IFJ6)''
)

cities_cancel_button=: wd bind 'pclose'

cities_ok_button=: 3 : 0
ndx=. ".clist_select
if. 0=#ndx do.
  sminfo 'City not found'
  return.
end.
clistmsk=. ndx ~: i.#BNAMES
miles=. ".Miles
bydist=. ".Distance
txt=. cityfmt miles,bydist,ndx
hdr=. ' from ',(>ndx{BNAMES),':'
hdr=. (>miles{'Kilometers';'Miles'),hdr
'City Distances' wdview hdr;txt
)

cities_clist_button=: cities_ok_button
cities_enter=: cities_ok_button

cities=: cities_run
