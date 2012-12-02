NB. control2.ijs  - edits

NB. use markup language for gtklabel instead of real richeditm
RTFFILE=: jpath '~addons/demos/wd/jr4.rtf'

EDITS=: 0 : 0
pc edits;
xywh 5 8 160 67;cc richeditm static;
xywh 8 84 82 12;cc edit edit ws_border es_autohscroll;
xywh 105 84 100 35;cc editm editm ws_border es_autovscroll;
xywh 170 10 5 5;cc brich button;cn "";
xywh 94 86 5 5;cc bedit button;cn "";
xywh 208 86 5 5;cc beditm button;cn "";
pas 6 6;pcenter;
rem form end;
)

wdedits=: sminfo bind ('edit definition'&;)

edits_run=: 3 : 0
wd EDITS
ITALIC=: 0
SIZE=: 15
wd 'set edit *single line edit box'
c=. wdqhwndc 'richeditm'
j4r=. '<span font="Arial Black 32" fgcolor="red">J Release 7</span>'
if. 'Android'-.@-:UNAME do.
  gtk_label_set_markup_jgtk_ c ; j4r
end.
wd 'pshow;'
)

edits_cancel_button=: wd bind 'pclose'

edits_brich_button=: wdedits bind (0 : 0)
wd 'cc richeditm richeditm;'
hc=. wdqhwndc 'richeditm'
j4r=. '<span font="Arial Black 32" fgcolor="red">J Release 7</span>'
if. 'Android'-.@-:UNAME do.
  gtk_label_set_markup_jgtk_ hc ; j4r
end.
)

edits_bedit_button=: wdedits bind (0 : 0)
wd 'cc edit edit ws_border es_autohscroll'
)

edits_beditm_button=: wdedits bind (0 : 0)
wd 'cc editm editm ws_border es_autovscroll'
)
