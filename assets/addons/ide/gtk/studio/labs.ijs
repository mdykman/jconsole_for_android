cocurrent 'jgtkide'
smfocus_jijs_=: 3 : 0
gtk_window_present_with_time window__locTerm,GDK_CURRENT_TIME
)
cb_labs_run_jgtkide_=: 3 : 0
closewindows_jijs_=: 0:
smclose_jijs_=: 0:
smopen_jijs_=: open
smsel_jijs_=: 0:
smselout_jijs_=: 0:
smsetsaved_jijs_=: 0:
smwrite_jijs_=: 0:
tile_jijs_=: 0:
coinsert_jijs_ (,copath) coname''

ndx=. (1{"1 Labs) i. <y
if. ndx=#Labs do. 0 return. end.
labinit_jlab_ jpath (<ndx;2) pick Labs
0
)
lab_msg=: 0 : 0
No labs installed.
Do pacman labs/labs install and try again.

Labs are interactive tutorials and are a good
way to learn J.

Labs are not always current with the latest system
and may run with minor errors that can be ignored.
)
runlabselect=: 3 : 0
if. -.fexist jpath '~addons/labs/labs/lab.ijs' do.
  sminfo (gettext 'Labs');lab_msg
  0 return.
end.
load '~addons/labs/labs/lab.ijs'
t=. 'b' freads '~addons/labs/labs/lablist.txt'
if. t -: _1 do.
  mbinfo (gettext 'Could not read list of labs') return.
end.
t=. a: -.~ deb each t
t=. t #~ (<'NB.') ~: 3 {.each t
t=. <;._1 &> ';' ,each t
Labs_jgtkide_=: t
ids=. <;._1 '/Category:/Lab:/_Select'
cat=. 0{"1 t
ncat=. ~.cat
nms=. 1{"1 t
ndx=. ncat i. cat
callback=: 'cb_labs_run_jgtkide_'
title=. 'Select lab'
header=: 'Select a lab to run.',LF2,'To advance the lab, press Ctrl-J.'
a=. conew 'jgtkpairsel'
MinSize__a=: 600 500
create__a ids;ncat;nms;ndx;callback;title;header
)
runlabselect''
