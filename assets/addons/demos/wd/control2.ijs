NB. control2.ijs  - edits

RTFFILE=: jpath '~addons/demos/wd/jr4.rtf'

EDITS=: 0 : 0
pc edits;
xywh 5 8 160 67;cc richeditm richeditm;
xywh 8 84 82 12;cc edit edit ws_border es_autohscroll;
xywh 105 84 100 35;cc editm editm ws_border es_autovscroll;
xywh 170 10 5 5;cc brich button;cn "";
xywh 94 86 5 5;cc bedit button;cn "";
xywh 208 86 5 5;cc beditm button;cn "";
pas 6 6;pcenter;
rem form end;
)

wdedits=: wdinfo bind ('edit definition'&;)

edits_run=: 3 : 0
wd EDITS
ITALIC=: 0
SIZE=: 15
wd 'set edit *single line edit box'
wd 'set richeditm *',fread RTFFILE
wd 'pshow;'
)

edits_cancel_button=: wd bind 'pclose'

edits_brich_button=: wdedits bind (0 : 0)
wd 'cc richeditm richeditm;'
wd 'set richeditm *',fread RTFFILE
)

edits_bedit_button=: wdedits bind (0 : 0)
wd 'cc edit edit ws_border es_autohscroll'
)

edits_beditm_button=: wdedits bind (0 : 0)
wd 'cc editm editm ws_border es_autovscroll'
)
