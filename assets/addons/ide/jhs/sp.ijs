NB. simple project manager and related tools

require'~addons/ide/jhs/jfif.ijs'

coclass'jsp'

spinit_z_  =: spinit_jsp_
sp_z_      =: sp_jsp_
spf_z_     =: spf_jsp_
spr_z_     =: spr_jsp_
spx_z_     =: spx_jsp_
spxinit_z_ =: spxinit_jsp_
sprunner_z_=: 3 : '0!:111 y'
sptable_z_ =: sptable_jsp_
spfind_z_=: find_jfif_

sphelp_z_=: 0 : 0
sp utilties loaded when JHS starts (~addons/ide/jhs/sp.ijs)
sp use of an ijs file adds it to recent
project file and recent are carried over sessions
fr - file / '' for project / recent shortname
 sp  fr       load
 spf fr       filename
 spr ''       recent files
 
 spinit fr    set project and load
 ctrl+,       load project

 spxinit fr   set script for managed execution
 ctrl+.       advance
 spx''        advance
 spx 0        status
 spx n        run line n
 spx n m      run lines n through m

 sptable      remove boxdraw - e.g., sptable 1!:0<'*'
 
 spfind 'maxrecent';'~addons/ide/jhs/*.ijs'
 spfind 'maxrecent';'~addons/ide/jhs/*.ijs';'=:'
 options: name assign =: =. cs nr nl
 cs - case sensitive ; nr - no recursion ; nl - no lines

create ~temp/a.ijs and ~temp/b.ijs each with a few J sentences
   spinit '~temp/a.ijs' NB. set project file
   ctrl+,               NB. run project file
   sp'~temp/b.ijs'      NB. load script
   spr''                NB. list recent
   sp'b'                NB. load b from recent
 
create ~temp/c.ijs with comments, =: lines, and multiline defns
   spxinit'~temp/c.ijs' NB. set managed execution
   ctrl+.               NB. execute next
   spx 0                NB. status
   
It can be productive to have multiple jijx tabs.
 1 for running sentences ; 2 with spr ; 3 with spfind
)

MAXRECENT=: 40 NB. max recent files 
sprecentf=: '~temp/sp/recent.txt'
spspf    =: '~temp/sp/sp.txt'

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

sp=: 3 : 'load__ spf y'

NB. only add .ijs and non temp files
addrecent=: 3 : 0
t=. >(('.ijs'-:_4{.y)*.-.*/(;shorts_jsp_ y)e.'0123456789'){'';y
t=. ~.SPFILES,~<t
t=. (;fexist t)#t
SPFILES=: (MAXRECENT<.#t){.t
(;SPFILES,each LF) fwrite sprecentf
y
)

NB. filename / '' for project / spr shortname
NB. first spr shortname prefix that matches 
NB. error if file does not exist or is not .ijs
NB. file is added to head of of recent
spf=: 3 : 0
if. ''-:y do.
 assert. fexist SPFILE['project must exist'
 r=. SPFILE
elseif. +./y e.'~/.' do.
 r=. y
elseif. 1 do.
 c=. (shorts SPFILES)=<,y
 assert. 0~:+/c['not found in recent'
  r=. ,>{.c#SPFILES
end.
assert. fexist r['must exist'
assert. '.ijs'-:_4{.r['not .ijs'
addrecent r
)

shorts=: 3 : 0
t=. '/',each boxopen y
_4}.each(>:>t i:each '/')}.each t
)

spr=: 3 : 0
addrecent'' NB. brute force cleanup
spopen each SPFILES
i.0 0
)

spopen=: 3 : 0
s=. ;shorts y
t=. (JIJSAPP_jhs_,'?mid=open&path=',jpath y)jhref_jhs_ s
t=. t,(;(1>.20-#s)#<'&nbsp;'),y
jhtml '<div contenteditable="false">',t,'</div>'
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
t=. ,d=. ":y
d=. ($d)$' ' ((t e. 32{.a.)#i.#t)}t
(-.*./"1 d="1 1[' '#~{:$d)#d
)

3 : 0''
try.
if. _1=nc<'initialized' do. 
 1!:5 :: [ <jpath '~temp/sp'
 SPFILE     =: cfile spspf
 SPFILES    =: <;._2 cfile sprecentf
 SPXFILE    =: ''
 SEMN       =: 0
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

