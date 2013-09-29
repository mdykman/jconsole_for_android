NB. simple project manager and related tools

coclass'jsp'

spinit_z_  =: spinit_jsp_
sp_z_      =: sp_jsp_
spf_z_     =: spf_jsp_
spr_z_     =: spr_jsp_
spd_z_     =: spd_jsp_
speinit_z_ =: speinit_jsp_
spe_z_     =: spe_jsp_
spg_z_     =: spg_jsp_
spgf_z_    =: spgf_jsp_
spx_z_     =: spx_jsp_
spxinit_z_ =: spxinit_jsp_
sprunner_z_=: 3 : '0!:111 y'
sptable_z_ =: sptable_jsp_

sphelp_z_=: 0 : 0
spoverview has additional info

fr - filename or shortname from spr/spd/spg

 spinit fr    set project and load (carried over sessions)
 ctrl+,       load project file
 sp''         load project file
 sp fr        load file
 spr''        list recent files (carried over sessions)
 spf fr       filename
 spd folder   *.ijs in folder 

 speinit win;unix set editors (carried over sessions)
 speinit '"C:\Program Files (x86)\gedit\bin\gedit.exe"';'gedit'
 spe fr       edit file
 spe''        edit project file

 spg'pattern'[;'folder']
 spg''        last pattern and last folder
 spg'abcd'    abcd pattern and last folder
 spgf fr      pattern lines in file

 spxinit fr   set script for managed execution
 ctrl+.       advance
 spx''        advance
 spx 0        status
 spx n        run line n
 spx n m      run lines n through m

 sptable      no boxdraw - e.g., sptable 1!:0<'*'
)

spoverview_z_=: 0 : 0
sp utilties loaded when JHS starts (~addons/ide/jhs/sp.ijs).

Following shows how to use sp by example.

With desktop editor create ~temp/a.ijs and ~temp/b.ijs
each with a few J sentences.

   spinit '~temp/a.ijs' NB. set project file
   ctrl+,               NB. run project file
   spf '~temp/b.ijs'    NB. add to recent files
   spr ''               NB. list recent files
   spf 'b'
   spd '~temp'          NB. list ijs files in folder
   sp  fr               NB. add to recent files and load

spr/spd/spg shortname ease file references.

You can start the editor outside of J or from J.
speinit sets Windows and Unix editor that J will start.
Example assumes you have installed gedit in Windows.

NB.speinit win;unix
   speinit '"C:\Program Files (x86)\gedit\bin\gedit.exe"';'gedit'
   spe ''               NB. edit project file
   spe 'a'              NB. edit shortname a 

Search folder ijs files with grep.
Windows grep.exe is included in JHS package for convenience.

NB.spg pattern;folder
   spg '=:';'~temp'
   spgf fr              NB. search for pattern in file

Managed execution of a script can be useful.
Create ~temp/c.ijs with NB. lines, =: lines, and multiline defns.
   spxinit'~temp/c.ijs' NB. set script for managed execution
   ctrl+.               NB. execute next
   spx 0                NB. status
)

MAXRECENT=: 20 NB. max recent files 
sprecentf=: '~temp/sp/recent.txt'
spspf    =: '~temp/sp/sp.txt'
spspef   =: '~temp/sp/editor.txt'
GREPPERS =: (jpath'~addons/ide/jhs/grep.exe');'grep'

cfile=: 3 : 0
t=. fread y
>(_1-:t){t;''
)

spinit=: 3 : 0
t=. spf y
assert. (fexist t)['must exist'
SPFILE=: t
t fwrite spspf
sp t
)

sp=: 3 : 0
smoutput 'load: ',t=.spf y
load__ t
)

spf=: 3 : 0
if. ''-:y do. SPFILE return. end.
if. +./y e.'~/.' do.
 assert. ('.ijs'-:_4{.y)['not ijs'
 t=. SPFILES
 t=. ~.t,~<y
 t=. (MAXRECENT<.#t){.t
 SPFILES=: t
 (;t,each LF) fwrite sprecentf
 y
 return.
end.
t=. (~.(<SPFILE),(<SPXFILE),SPFILES,SPDFILES,SPGFILES)-.<''
c=. (shorts t)=<,y
if. 0=+/c do.
 assert. 0['not found'
else.
 ,>{.c#t
end.
)

shorts=: 3 : 0
t=. '/',each y
_4}.each(>:>t i:each '/')}.each t
)

spr=: 3 : 0
t=. (~.(<SPFILE),(<SPXFILE),SPFILES)-.<''
sptable (shorts t),.t
)

spd=: 3 : 0
if. ''-:y do. SPDFILES=: '' return. end.
SPDFILES=: (<'/',~y),each (>:#jpath y)}.each {."1 dirtree y,'/*.ijs'
sptable SPDFILES,.~shorts SPDFILES
)

speinit=: 3 : 0
assert. 2=#y['must give windows;unix editors'
EDITX =: >IFUNIX{y
(;LF,~each y) fwrite spspef
i.0 0
)

spe=: 3 : 0
assert. 0~:#EDITX['no editor set - speinit required'
smoutput f=. spf y
if. (UNAME-:'Android') *. 0=isatty 0 do.
  2!:1 'android.intent.action.EDIT';('file://',jpath f);'text/plain'
else.
  fork_jtask_ EDITX,' "',(jpath f),'"',EDITXTAIL
end.
)

spg=: 3 : 0
'-c --include=*.ijs -R -F' spg y
:
if. -.''-:y do.
 select. #a=. boxopen y
 case. 1 do.
  'SPGPATTERN'=: y
 case. 2 do.
  'SPGPATTERN SPGFOLDER'=: a
 case. do. smoutput 'too many args' return.
 end.
end.
p=. jpath SPGFOLDER
g=. GREPX,' ',x,' "',SPGPATTERN,'" "',p,'"'
h=. 'grep ',x,' "',SPGPATTERN,'" "',SPGFOLDER,'"'
try. NB. unix grep finding nothing gives interface error???
 t=. <;._2 spawn_jtask_ g
catch.
 t=. ''
end.
i=. t i: each ':'
c=. >".each (>:>i)}.each t
t=. i{.each t
t=. (>:#p)}.each t
t=. (0~:c)#t
c=. (0~:c)#c
s=. \:c
t=. s{t
SPGFILES=: t,~each'/',~each<SPGFOLDER
c=. s{c
t=. (":each<"0 c),.(shorts SPGFILES),.SPGFILES
h,LF,sptable t
)

spgf=: 3 : 0
f=. spf y
t=. GREPX,' -n -F "',SPGPATTERN,'" "',(jpath f),'"'
t=. <;.2 spawn_jtask_ t
i=. t i. each ':'
c=. 4j0":each ".each i{.each t
t=. (>:>i)}.each t
f,LF,;c,each,' ',each t
)

spxinit=: 3 : 0
ev_dot_ctrl_jijx_=: 3 : 'spx__'''''
assert. fexist spf y['must exist'
SPXFILE=: spf y
SEM=: get SPXFILE
SEMN=: 1
status''
i.0 0
)

spx=: 3 : 0
if. -.fexist SPXFILE do. smoutput 'not initialized - do spxinit' return. end.
if. ''-:y do. spx SEMN return. end.
if. 0={.y do. status'' return. end.
d=. SEM
SEM=:get SPXFILE
if. -.d-:SEM do.
 smoutput'warning: file changed!'
 status''
end.
if. 2=#y do.
 if. -.(3!:0[4) e. 1 4 do. smoutput 'not integer line numbers' return. end.
 SEMN=: {.y
 b=. ({:y)<.#SEM
 while. SEMN<:b do.
  spx a
  a=. SEMN
 end.
 i.0 0
 return.
end.

if. (0~:$$y)+.-.(3!:0[4) e. 1 4 do. smoutput 'not integer line number' return. end.
if. y<0 do. smoutput 'not valid line number' return. end.
SEMN=: y
label_top.
if. SEMN>#SEM do. 'end of script' return. end.
ndx=. <:SEMN
d=. >ndx{SEM
if. 0=#d-.' ' do. SEMN=:>:SEMN goto_top. end.
NB. collect : lines
if. iscolon d do.
 c=. (dltb each ndx}.SEM) i. <,')'
 d=. ;LF,~each (ndx+i.>:c){SEM
 ndx=. ndx+c
end.
NB. collect comment lines
if. isnb d do.
 c=. (>(3{.each dltb each ndx}.SEM) -: each <'NB.')i.0
 d=. ;LF,~each (ndx+i.c){SEM
 ndx=. ndx+<:c
end.
NB.! kludge to convert =. tp =:
i=. d i.LF
t=. i{.d
if. (<'=.')e.;:t do.
 d=. (t rplc '=.';'=:'),i}.d
end.
sprunner__ d
SEMN=: 2+ndx
if. (SEMN<#SEMN)*.'NB.'-:3{.dlb d do. goto_top. end.
i.0 0
)

iscolon=: 3 : 0
t=. ;:y
if. (<'define')e.t do. 1 return. end.
NB.! vstar - detect AS '(' at end of line
if. (_2{.i.#t)-:t i.;:'AS ''(''' do. 1 return. end. 
i=. t i. <,':'
(,each':';'0')-:(i+0 1){t,'';''
)

isnb=: 3 : 0
'NB.'-:3{.dltb y
)

get=: 3 : 0
d=. toJ fread y
d=. d,(LF~:{:d)#LF
<;._2 d
)

status=: 3 : 0
smoutput (":SEMN),' of ',(":#SEM),' in  ',SPXFILE
)

sptable=: 3 : 0
0 1 sptable y
:
assert. (32=3!:0 y)*.2=$$y
if. 0=*/$y do. '' return. end.
'rows cols'=. <:x
a=. 9!:6''
t=. {:a.
try.
 9!:7[11#{:a.
 r=. ":y
 m=. 0,~0,}.}:(>:rows*r-:"1[({:$r)#t)
 r=. |:m#r
 m=. 0,~0,}.}:(>:cols*r-:"1[({:$r)#t)
 r=. LF,.~|:m#r
 r=. r rplc t;' '
catch.
end.
9!:7 a
r
)

3 : 0''
try.
if. _1=nc<'initialized' do. 
 1!:5 :: [ <jpath '~temp/sp'
 SPFILE     =: cfile spspf
 SPFILES    =: <;._2 cfile sprecentf
 SPDFILES   =: ''
 SPGFILES  =: ''
 SPGPATTERN =: ''
 SPGFOLDER  =: '~system' 
 SPXFILE    =: ''
 SEMN       =: 0
 t=. cfile spspef
 t=. >(''-:t){t;2#LF
 EDITX      =: >IFUNIX{<;._2 t
 EDITXTAIL  =: >IFUNIX{'';' &'
 GREPX      =: >IFUNIX{GREPPERS
end.
initialized=: 1
catch.
 smoutput'sp initialization failed'
end.
i.0 0
)

0 : 0
bind -s ^E "sp''\n"
bind -s ^R "spx''\n"
editrc fwrite '~home/.editrc'
)

