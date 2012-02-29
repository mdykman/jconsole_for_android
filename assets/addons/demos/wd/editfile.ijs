NB. edit file demo

NB. set up files -----------------------------------------
NB. this creates the files when the demo is loaded

FILEA=: 'filea.txt'
FILEB=: 'fileb.txt'
FILEC=: 'filec.txt'

'this is the text for file A' fwrite FILEA
'THIS IS THE TEXT FOR FILE B' fwrite FILEB
'This is the text for: C' fwrite FILEC

FILES=: FILEA;FILEB;FILEC

NB. form definitions ---------------------------------------
EDITFILE=: 0 : 0
pc editfile;
sbar 1;
sbarset editbar 50 "";
sbarshow;
xywh 7 13 40 10;cc label static;cn "Select file:";
xywh 7 21 37 57;cc FileList listbox;
xywh 52 22 158 87;cc FileText editm ws_border ws_vscroll es_autovscroll rightmove bottommove;
xywh 99 4 34 12;cc open button rightmove;cn "Open";
xywh 137 4 34 12;cc save button rightmove;cn "Save";
xywh 175 4 34 12;cc cancel button rightmove;cn "Cancel";
pas 6 6;pcenter;
rem form end;
)

FORMNAME=: 'Edit File'

editfile_run=: 3 : 0
wd EDITFILE
wd 'pn *',FORMNAME
wd 'set FileList *',;FILES,each LF
displayfile 0
wd 'pshow;'
)

editfile_cancel_button=: 3 : 0
'' if. 2 ~: savefile 1 do. wd 'pclose;' end.
)

editfile_open_button=: 3 : 0
select=. {.".FileList_select
if. FILENDX=select do.
  wdinfo FORMNAME;'File is already open: ',FILENAME
else.
  if. 2 ~: savefile 1 do. displayfile select end.
end.
)

editfile_FileList_button=: editfile_open_button

editfile_save_button=: 3 : 0
if. OLDTEXT -: FileText do.
  wdinfo FORMNAME;'Text has not changed: ', FILENAME
else.
  savefile 0
end.
)

NB. displayfile fileindex
displayfile=: 3 : 0
FILENDX=: y
FILENAME=: FILENDX pick FILES
OLDTEXT=: fread FILENAME
wd 'set FileText *',OLDTEXT
displayselect''
)

NB. display current selection
displayselect=: 3 : 0
wd 'setselect FileList ',":FILENDX
wd 'set editbar *Open File: ',FILENAME
wd 'sbarshow 1'
)

NB. savefile - save current file if changed
NB. returns 0=saved or text not changed, 1=not saved, 2=cancelled
NB. y=0 no prompt
NB.    1 prompt to save
savefile=: 3 : 0
if. OLDTEXT -: FileText do. 0 return. end.
if. y do.
  res=. 3 wdquery FORMNAME;'Text has changed: ',FILENAME,LF,LF,'OK to save it?'
  if. res=1 do. wdinfo FORMNAME;'Not saved: ',FILENAME end.
  if. res e. 1 2 do.
    displayselect''
    res return.
  end.
end.
FileText fwrite FILENAME
OLDTEXT=: FileText
wdinfo FORMNAME;'Text saved to: ',FILENAME
0
)

editfile_run''
