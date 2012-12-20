NB. sms - sm replacements
NB.
NB. note here SMSEL is the form id (form handle, not form name)
NB. use smopen to set SMSEL for a filename
NB. smsel takes a form id argument
NB.
NB. some commands permit invalid SMSEL, e.g. smclose
NB.
NB. definitions:
NB.
NB. FKEYS
NB. SMSEL
NB. getSMSEL
NB.
NB. id2loc
NB. id2name
NB. id2type
NB. name2id
NB.
NB. qsmact
NB. qsmall
NB. qsmallforms
NB. qsmallijs
NB. qsmlastxs
NB. qsmout
NB. qsmsize
NB.
NB. smappend
NB. smclose
NB. smfocus
NB. smfocusact
NB. smfocusout
NB. smgetsel
NB. smmove
NB. smopen
NB. smprompt
NB. smread
NB. smreplace
NB. smsave
NB. smscroll
NB. smsel
NB. smselact
NB. smselout
NB. smsetcmd
NB. smsetselect
NB. smsetsaved
NB. smwrite

coclass 'jijs'

NB. =========================================================
getSMSEL=: 3 : 0
'' return.
if. -. (<SMSEL) e. 1 {"1 wdforms'' do.
  smsel ''
end.
SMSEL
)

NB. =========================================================
NB. id2loc
NB. get locale for given id, empty if not found
id2loc=: 3 : 0
'' return.
fms=. wdforms''
ndx=. (1 {"1 fms) i. boxopen y
if. ndx < #fms do.
  (<ndx;2) { fms
else.
  ''
end.
)

NB. =========================================================
NB. id2names
NB. get names for given ids, empty if not found
id2names=: 3 : 0
0$<'' return.
fms=. wdforms''
ndx=. ,(1 {"1 fms) i. boxxopen y
ind=. I. ndx < #fms
nms=. (#ndx) # <''
for_i. ind do.
  loc=. 2 { (i{ndx) { fms
  nms=. (<SMNAME__loc) i } nms
end.
)

NB. =========================================================
NB. id2name
NB. get name for given id, empty if not found
id2name=: > @ {. @ id2names

NB. =========================================================
NB. get type for given id, empty if not found
id2type=: 3 : 0
'' return.
fms=. wdforms''
ndx=. (1 {"1 fms) i. boxopen y
if. ndx < #fms do.
  > (<ndx;3) { fms
else.
  ''
end.
)

NB. =========================================================
NB. name2id
NB. get form id for a given filename
NB. returns form handle
NB. returns empty if not found
name2id=: 3 : 0
'' return.
fms=. wdforms''
fms=. fms #~ (3 {"1 fms) e. 'jijs';'jijx'
fid=. tolower > y
if. 0 = #fid do. '' return. end.
if. (<fid) e. 1 {"1 fms do. return. end.
for_loc. 2 {"1 fms do.
  if. fid -: tolower SMNAME__loc do.
    1 pick loc_index { fms return.
  end.
end.
''
)

NB. =========================================================
NB. qsmact
NB. return id of active ijs or ijx window
qsmact=: 3 : 0
'' return.
fms=. wdforms''
b=. (3 {"1 fms) e. 'jijs';'jijx'
fms=. b # fms
last=. 0 ". > 4{"1 fms
ndx=. last i. >./last
(<ndx;1) pick fms
)

NB. =========================================================
NB. qsmall
NB. return ids of all session windows (ijx + ijs)
NB. sorted by activity
qsmall=: 3 : 0
0$<'' return.
fms=. wdforms''
msk=. ('jijs';'jijx') e.~ 3 {"1 fms
fms=. msk # fms
(1 {"1 fms) /: 0 ". > 4{"1 fms
)

NB. =========================================================
NB. qsmallforms
NB. return forms of all session windows (ijx + ijs)
NB. sorted by activity
qsmallforms=: 3 : 0
0$<'' return.
fms=. wdforms''
msk=. ('jijs';'jijx') e.~ 3 {"1 fms
fms=. msk # fms
fms /: 0 ". > 4{"1 fms
)

NB. =========================================================
NB. qsmallijs
NB. return ids of all ijs windows
qsmallijs=: 3 : 0
0$<'' return.
fms=. wdforms''
msk=. (<'jijs') = 3 {"1 fms
msk # 1 {"1 fms
)

NB. =========================================================
NB. qsmsize
qsmsize=: 3 : 0
0 0 200 200 return.
wd 'psel ',SMSEL
0 ". wd 'qformx'
)

NB. =========================================================
NB. qsmlastijs
NB. return last ijs, if any
qsmlastijs=: 3 : 0
'' return.
fms=. wdforms''
b=. (3 {"1 fms) e. <'jijs'
if. 0 = +/b do. '' return. end.
fms=. b # fms
last=. 0 ". > 4 {"1 fms
1 pick {. fms \: last
)

NB. =========================================================
NB. qsmlastxs
NB. if window is ijx, return last ijs
NB. if window is ijs, return ijx
qsmlastxs=: 3 : 0
'' return.
fms=. wdforms''
b=. (3 {"1 fms) e. 'jijs';'jijx'
fms=. b # fms
last=. 0 ". > 4 {"1 fms
fms=. fms \: last
if. (<'jijs') = 3 { {. fms do.
  ndx=. (3 {"1 fms) i. <'jijx'
else.
  ndx=. 1
end.
ndx=. ndx <. <: #fms
(<ndx;1) pick fms
)

NB. =========================================================
NB. qsmout
NB. return id of output window
qsmout=: 3 : 0
'' return.
fms=. wdforms''
ind=. (3 {"1 fms) i. <'jijx'
(<ind;1) pick fms
)

NB. =========================================================
NB. smappend v append to SMSEL window
smappend=: 3 : 0
EMPTY return.
txt=. smread ''
smwrite txt,y
)

NB. =========================================================
NB. smclose (no save)
smclose=: 3 : 0
EMPTY return.
getSMSEL''
if. #SMSEL do.
  loc=. id2loc SMSEL
  destroy__loc ''
  smsel ''
end.
)

NB. =========================================================
smfocus=: 3 : 0
EMPTY return.
wd 'psel ',SMSEL
wd 'pactive'
wd 'setfocus e'
)

NB. =========================================================
smfocusact=: smfocus @ smselact
smfocusout=: smfocus @ smselout

NB. =========================================================
smgetsel=: 3 : 0
_1 return.
wd 'psel ',SMSEL
dat=. wd 'qd'
ndx=. ({."1 dat) i. <'e_select'
0 ". 1 pick ndx { dat
)

NB. =========================================================
NB. smopen
NB. select and open file
smopen=: 3 : 0
EMPTY return.
id=. name2id y
if. 0 = #id do.
  a=. conew 'jijs'
  create__a y
else.
  smsel id
  wd 'psel ',SMSEL
end.
wd 'setfocus e'
empty''
)

NB. =========================================================
smmove=: 3 : 0
EMPTY return.
wd 'psel ',SMSEL
wd 'pmovex ',": y
)

NB. =========================================================
NB. smprompt prompt [default]
NB. If default is supplied, it is added to the prompt and is highlighted.
NB.
NB. does smsel of output window
smprompt=: 3 : 0
EMPTY return.
'txt def'=. 2 {. boxxopen y
smsel qsmout''
wd 'psel ',SMSEL
dat=. wd 'qd'
ndx=. ({."1 dat) i. <,'e'
ses=. 1 pick ndx { dat
ses=. ses, (LF ~: _1 {. ses) # LF
ses=. ses,utf8 txt
wd 'set e *',ses,def
wd 'setselect e ',": ((#ses)+0,#def), 1
)

NB. =========================================================
NB. smread returns UTF-16 characters
smread=: 3 : 0
'' return.
readid16 SMSEL
)

NB. =========================================================
smreplace=: 3 : 0
EMPTY return.
wd 'psel ',SMSEL
wd 'setreplace e *',utf8 y
)

NB. =========================================================
NB. save, no prompt
smsave=: 3 : 0
EMPTY return.
getSMSEL''
if. #SMSEL do.
  loc=. id2loc SMSEL
  save__loc 2
end.
)

NB. =========================================================
NB. used to scroll window when opened
smscroll=: 3 : 0
EMPTY return.
wd 'psel ',SMSEL
loc=. id2loc SMSEL
txt=. SMTEXT__loc
if. (y=0) +. 0=#txt do.
  wd 'setselect e 0 0 0' return.
end.
len=. #;.2 ucp txt,LF
pos=. +/ (y <. #len) {. len
wd 'setselect e ',": pos,pos,0
)

NB. =========================================================
NB. smsel
smsel=: 3 : 0
EMPTY return.
empty SMSEL_jijs_=: name2id , > y
)

NB. =========================================================
NB. smselact
NB. select the active window
smselact=: smsel @ qsmact

NB. =========================================================
NB. smselout
NB. select the ijx output window
smselout=: smsel @ qsmout

NB. =========================================================
NB. smsetcmd
NB. smsetcmd n t name sentence
NB. n is 2 to 9 and indicates a function key
NB. t is 0 for no definition, 1 for noisy, 2 for quiet, 3 for silent
NB. name appears on Tool menu (include TAB to put Fn at right)
NB. sentence is passed to J for execution when function key is pressed
NB.
NB. smsetcmd does not update the configuration - for that
NB. use the configuration dialog
NB. this just updates the FKEYS global
smsetcmd=: 3 : 0
EMPTY return.
cmd=. 4 {. y
def=. cmd , FKEYS
FKEYS=: sort (~: {."1 def) # def
)

NB. =========================================================
NB. smsetselect
NB. smsetselect [start end [noscroll] ] ;
NB. Selects text from start to end. If start and end are elided,
NB. then all text is selected. If noscroll is elided or 1, then
NB. the selection is not scrolled into view. If noscroll is 0,
NB. then the selection is scrolled into view.
smsetselect=: 3 : 0
EMPTY return.
wd 'psel ',SMSEL
wd 'setselect e ',": y
)

NB. =========================================================
smsetsaved=: 3 : 0
EMPTY return.
loc=. id2loc SMSEL
IFSAVED__loc=: 1
)

NB. =========================================================
smwrite=: 3 : 0
EMPTY return.
wd 'psel ',SMSEL
wd 'set e *',utf8 y
)
