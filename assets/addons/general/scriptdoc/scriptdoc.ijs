require 'gtkwd print'

coclass 'jscriptdoc'

PATHSEP=: jpathsep '/'
0 : 0

Scripts are documented in comment lines (i.e. lines
beginning with
lines beginning with

The first line of a multi-line comment may be used
for summary documentation of the script.


1. The first line in the script is a comment line describing the script, i.e



2. Global definitions produced by the script are preceded by
one or more comment lines. The first such comment line has
the form:



where type is one of:
        v verb
        a  adverb
        c  conjunction
        n  noun

After this first comment line, all subsequent comment lines
without a break are assumed to be part of the description
for the definition.

The * should not be given after the
a new definition.

Conventionally, the second such line may be a "form" statement
describing the usage of the definition, e.g.

   form:  calendar year [,months]

Other lines include an "example" statement

   example: calendar 1998 5

3. Other
)
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
dlb=: }.~ =&' ' i. 0:
drophead=: ] }.~ #@[ * [ -: #@[ {. ]
extijs=: , ((0: < #) *. [: -. '.'"_ e. ]) # '.ijs'"_
extnone=: {.~ (i.&'.')
jdirname=: (jpath '~install') & drophead
pathname=: 3 : '(b#y);(-.b=.+./\.y=PATHSEP)#y'
partname=: jdirname @ extnone
tolist=: }. @ ; @: (LF&, each)

DEFSEP=: 61#'-'
FILESEP=: 61#'='
SUMMARY=: 0
PTOP=: '0'
PROJHDR=: 'built from project:'
clipfmt=: 3 : 0
CRLF=. LF
if. 0 e. $y do. '' return. end.
t=. 3!:0 y
if. 2=t do.
  y=. ,y,"1 CRLF
elseif. 32<:t do.
  y=. ,&TAB @ ": &.>y
  y=. ;,&CRLF@}: &.><@;"1 y
elseif. 1 do.
  y=. ;,&CRLF @ ": &.><"1 y
  y=. '-' (I. y='_') } y
  y=. TAB (I. y=' ') } y
end.
y
)
docgetscripts=: ''&$: : (4 : 0)
files=. {."1 getscripts_j_ y
b=. fexist &> files
if. 0 e. b do.
  j=. tolist partname each (b=0) # files
  j=. 'file not found: ',LF,LF,j
  sminfo x;j
  _1
else.
  files
end.
)
remcom=: 3 : 0
dat=. 3 }.each y
hdr=. ; 1 {.each dat
(hdr e. ' *') }.each dat
)
scriptdefs=: 3 : 0
file=. 'scriptdefs' docgetscripts y
if. file-:_1 do. return. end.
scriptdef1 'b' fread {.file
)
scriptdef1=: 3 : 0
msk=. 'NB.*'&-: @ (4&{.) &> y
dat=. msk <;.1 y
if. 0=#dat do. '' return. end.
scriptdef2 &> dat
)
scriptdef2=: 3 : 0
msk=. 'NB.'&-: @ (3&{.) &> y
msk=. *./\ msk
dat=. remcom msk#y
if. 0 = #dat do. 4#a: return. end.

top=. dlb 0 pick dat
name=. type=. bal=. ''

if. 0 < ndx=. top i.' ' do.
  name=. ndx {. top
  top=. dlb ndx }.top
  if. 0 < ndx=. top i.' ' do.
    type=. {.ndx {. top
    top=. dlb ndx }. top
  end.
end.

bal=. tolist }.dat

name;type;top;bal
)
scriptdeffmt=: 3 : 0
dat=. y
if. 0=#dat do. '' return. end.
type=. '('&, @ (,&')') each 1{"1 dat
dat=. type 1}"0 1 dat
f=. < @ (1&}.) @ ; @: (' '&, each) @: }:
line1=. f"1 dat
dat=. , (<LF,DEFSEP) ,. line1 ,. {:"1 dat
2 }. ; LF&, each a: -.~ dat
)
scriptdeffmtsum=: 3 : 0
dat=. y
if. 0=#dat do. '' return. end.
hdr=. <"1 (>0{"1 dat) ,. ' ' ,. (>1{"1 dat),. ' '
all=. hdr ,each 2{"1 dat
tolist all
)

scriptdoc=: 3 : 0
SUMMARY scriptdoc y
:
SUMMARY=: x
if. 0 e. # y do. '' return. end.
if. _1=files=. docgetscripts y do. _1 return. end.
SCRIPTFILES=: files
dat=. sdoc_show ''
if. IFQT do.
  wd 'pshow;pactive'
  ''
elseif. 'Android'-:UNAME do.
  dat
elseif. gtkInitDone_jgtk_ do.
  wd 'pshow;pactive'
  evtloop''
  ''
elseif. do.
  dat
end.
)
scriptdoc1=: 3 : 0
dat=. 'b' fread y
hdr=. scripthdrfmt scripthdr1 dat
doc=. scriptspdoc1 dat
def=. scriptdeffmt scriptdef1 dat
('file: ',partname y),LF,LF,hdr,LF,LF,doc,def
)
scriptdocsum=: 3 : 0
dat=. 'b' fread y
hdr=. > {. scripthdr1 dat
def=. scriptdeffmtsum scriptdef1 dat
('file: ',partname y),LF,LF,hdr,LF,LF,def
)
scripthdr=: 3 : 0
file=. 'scripthdr' docgetscripts y
if. file-:_1 do. return. end.
scripthdr1 'b' fread {.file
)
scripthdr1=: 3 : 0
if. 0=#y do. 2$a: return. end.
msk=. 'NB.'&-: @ (3&{.) &> y
blk=. *./ &> e.&'-=' each 4 }.each y
msk=. msk > blk *. 3 < # &> y
msk=. *./\ msk
dat=. remcom msk#y
b=. PROJHDR -: (#PROJHDR) {. > {. dat
dat=. b }. dat
if. #dat do.
  h0=. dlb 0 pick dat
else.
  h0=. 'No file description available'
end.
h1=. tolist }.dat
h0;h1
)
scriptspdoc1=: 3 : 0
if. 0=#y do. '' return. end.
f=. e.&('SCRIPTDOC';"1 0 '=:';'=.') @ (2&{.)
b=. f @ (;: :: <) &> y
if. 1 e. b do.
  dat=. (1 + b i. 1) }. y
  LF ,~ tolist (dat i. <',)') {. dat
else. '' end.
)
scripthdrfmt=: 3 : 0
dat=. y
if. 0=#dat do. 'no header description found' return. end.
tolist dat -. a:
)
scriptlist=: 3 : 0
if. 0 e. # y do. '' return. end.
if. _1-:files=. docgetscripts y do. return. end.
txt=. {. @ scripthdr &> files
x=. ,&(' ') @ partname
fnm=. x each cutopen y
fnm ,. txt
)
xdoc=: 3 : 0
0 xdoc y
:
if. #y do. y=. y,PATHSEP -. {:y end.
x=. scriptlist 1 dir y,'*.ijs'
dat=. (x }. each {."1 x) ,. }."1 x
clipwrite clipfmt dat
dat
)
scriptdoc_z_=: scriptdoc_jscriptdoc_
SDOC=: 0 : 0
pc sdoc closeok qtwd;pn "scriptdoc";
xywh 5 1 54 10;cc sum checkbox;cn "Summary";
xywh 162 1 31 10;cc ptop checkbox leftmove rightmove;cn "&Top";
xywh 198 1 32 10;cc printer button leftmove rightmove;cn "Printer";
xywh 232 1 32 10;cc print button leftmove rightmove;cn "Print";
xywh 266 1 32 10;cc cancel button leftmove rightmove;cn "Close";
xywh 0 12 300 250;cc view editm ws_border ws_vscroll es_autovscroll rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)

SDOCQT=: 0 : 0
pc sdoc closeok qtwd;pn "scriptdoc";
bin vh;
xywh 5 1 54 10;cc sum checkbox;cn "Summary";
xywh 162 1 31 10;cc ptop checkbox leftmove rightmove;cn "&Top";
xywh 198 1 32 10;cc printer button leftmove rightmove;cn "Printer";
xywh 232 1 32 10;cc print button leftmove rightmove;cn "Print";
xywh 266 1 32 10;cc cancel button leftmove rightmove;cn "Close";
bin z;
xywh 0 12 300 250;cc view editm ws_border ws_vscroll es_autovscroll rightmove bottommove;
bin z;
pas 0 0;pcenter;
rem form end;
)
sdoc_run=: 3 : 0
if. wdisparent 'sdoc' do.
  wd 'psel sdoc'
  return.
end.
wd IFQT{::SDOC;SDOCQT
if. 0~: 4!:0 <'FIXFONT_z_' do. font=: IFUNIX{::'"Lucida Console" 10' ; ('Android'-:UNAME){::'mono 10';IFQT{::'monospace 10';'Droid Sans Mono 10' else. font=: FIXFONT_z_ end.
wd 'setfont view ',font
wd 'set sum ',":SUMMARY
wd 'set ptop ',PTOP
wd 'ptop ',PTOP
)
sdoc_close=: 3 : 0
wd 'psel sdoc'
wd 'psel sdoc;pclose'
)
sdoc_cancel_button=: sdoc_close
sdoc_show=: 3 : 0
if. SUMMARY=0 do.
  txt=. scriptdoc1 each SCRIPTFILES
  sep=. LF,FILESEP,LF
  dat=. (#sep) }. tolist sep&, each txt
else.
  txt=. scriptdocsum each SCRIPTFILES
  sep=. LF,FILESEP,LF
  dat=. (#sep) }. tolist sep&, each txt
end.
if. IFQT +. 'Android'-.@-:UNAME do.
  gui=. 0
  if. IFQT do.
   gui=. 1
  elseif. gtkInitDone_jgtk_ do.
   gui=. 1
  end.
  if. gui *. 200000 <: #dat do.
    dat=. (200000{.dat),LF,'...'
  end.
end.

if. ('Android'-:UNAME)>IFQT do.
  dat, LF
elseif. -.gui do.
  dat, LF
elseif. do.
  sdoc_run''
  wd 'set view *',dat
end.
)

sdoc_clip_button=: 3 : 0
clipwrite view
)
sdoc_printer_button=: 3 : 0
wd 'mbprinter'
''
)
sdoc_print_button=: 3 : 0
print_jprint_ view
''
)
sdoc_ptop_button=: 3 : 0
wd 'ptop ',PTOP=: ptop
)
sdoc_sum_button=: 3 : 0
SUMMARY=: ". sum
sdoc_show''
)
