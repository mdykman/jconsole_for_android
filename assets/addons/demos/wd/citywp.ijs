NB.cities demo -  windows program

CITIES=: 0 : 0
pc cities closeok;pn "City Distances";
xywh 9 9 20 11;cc s0 static;cn "From:";
xywh 35 8 100 101;cc clist combolist ws_vscroll ws_border;
xywh 9 39 57 12;cc Kilometers radiobutton;
xywh 9 51 57 11;cc Miles radiobutton group;
xywh 6 28 62 36;cc dist groupbox;
xywh 76 39 57 11;cc Alphabetic radiobutton;
xywh 76 51 57 11;cc Distance radiobutton group;cn "By Distance";
xywh 73 28 62 36;cc sort groupbox;
xywh 146 8 39 12;cc ok button;cn "OK";
xywh 146 23 39 12;cc cancel button;cn "Cancel";
pas 6 6;pcenter;
rem form end;
)

cities_run=: 3 : 0
cityread''
wd CITIES
wd 'set clist *',;BNAMES,&.>LF
wd 'setselect clist ',":(#BNAMES)|.BNAMES i. <'Antwerp'
wd 'set Kilometers 1'
wd 'set Alphabetic 1'	
wd 'pshow'
)

cities_cancel_button=: wd bind 'pclose'

cities_ok_button=: 3 : 0
ndx=. ".clist_select
if. 0=#ndx do.
  wdinfo 'City not found'
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
