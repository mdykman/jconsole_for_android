NB. This script illustrates a simple form that provides
NB. an edit field for a global variable NAME
NB.
NB. When the form is run, the value of NAME is written
NB. to the form's edit field. The user can update the
NB. field as required.
NB.
NB. When the OK button is pressed, the form is closed
NB. and the global value of NAME is updated.
NB.
NB. When the Cancel button is pressed, the form is closed
NB. but the global value of NAME is not updated.

NAME=: 'Jemima PuddleDuck'

EDITNAME=: 0 : 0
pc editname;
xywh 5 5 80 11;cc name edit ws_border;
xywh 92 5 35 12;cc OK button;
xywh 92 20 35 12;cc Cancel button;
pas 6 6;pcenter;
rem form end;
)

NB. this creates and initializes the form:
editname=: 3 : 0
wd EDITNAME
wd 'set name *',NAME
wd 'pshow'
)

NB. this handles the Cancel button:
editname_Cancel_button=: wd bind 'pclose'

NB. this handles the OK button:
editname_OK_button=: 3 : 0
NAME=: name
wd 'pclose'
)

NB. run the form:
editname''
