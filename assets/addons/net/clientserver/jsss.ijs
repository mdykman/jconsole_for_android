NB. J Simple Socket Server
NB. abstract class that must be extended
NB. jsss_template is an example extending class

NB. script is in 3 parts
NB. part 1 defines base
NB. part 2 defines jsss class
NB. part 3 defines jsss defns likely overridden in your server

NB. ******************* part 1 - base locale
NB. base locale routines listens for connections
NB. creates object locale for serving commands
NB. destroys object locales when connection is closed
NB. sdselect wait loop and dispatch of servers

require'socket'
cocurrent 'base'
coinsert copath <'jsocket'

NB. init 1200 NB. default 5000 timeout and temp path aserver.log
NB. init 1200;5000;'c:\log.log'
init=: 3 : 0
'port timeout logfile'=: 3{.(boxopen y),5000;jpath'~temp\jsss.log'
if. #logfile do. ''1!:2<logfile end.
log 'init';0;'0';''
init_jsss_''
servers=: ''
sockets=: ''
sk=: 0 pick sdcheck sdsocket''
sdcheck sdioctl sk,FIONBIO,1
sdcheck sdbind sk;AF_INET;'';port
sdcheck sdlisten sk,1
WAITS=:sk;'';''
smoutput 'server initialized - running select loop now'
run''
)

accept=: 3 : 0
addwait sk;'';''
r=. sdaccept sk
if. 0=>{.r do. addserver (>1{r) conew 'jsss' end.
)

addserver=: 3 : 0
a=.y
log 'start';sk__a;a;''
servers=: servers,a
sockets=: sockets,sk__a
start__a''
addwait sk__a;'';''
)

removeserver=: 3 : 0
a=.y
log 'stop';sk__a;a;''
stop__a''
b=. servers~:a
servers=: b#servers
sockets=: b#sockets
)

addwait=: 3 : 0
WAITS=:~.each WAITS,each y
)

NB. log type;socket;locale;data-text
log=: 3 : 0
if. 0=#logfile do. return. end.
'type socket locale data'=.y
((6{.type),(24{.":6!:0''),(12":socket,0".>locale),' ',data,LF) 1!:3 <logfile
)

run=: 3 : 0
loop=: 1
shutdownflag=: 0
while. loop do.
 r=. sdcheck sdselect WAITS,<timeout
 WAITS=: WAITS-.each r
 s=. (sockets e. ~.;r)#servers NB. ready servers
 if. sk e. ;r do. accept'' end.
 for_x. s do. run__x'' end.
end.
if. shutdownflag do.
 sdclose sk
 for_s. servers do. destroy__s'' end.
 log 'end';0;'0';''
 end_jsss_''
 2!:55''
end.
'loop ended - restart loop by running: run'''''
)

NB. ******************* part 2 - class
NB. each connected socket has its own object locale from the following class

coclass 'jsss'
coinsert 'jsocket'

SNDLIM=: 40e3 NB. avoid clogging send buffers

NB. an abstract class that must be extended
NB. see jsss_template.ijs
NB. tune with sockopt snd/rcv bufsize and app data size for max performance

create=:3 : 0
sk=: y
sdcheck sdioctl sk,FIONBIO,1
data=: ''
senddata=: ''
writeready=: 0
DESTROY=: 0
lasterror=: ''
)

run=: 3 : 0
read''
if. (4<:#data) *. (_2 ic bigendian 4{.data)=_4+#data do. NB. readcomplete
 data=: 4}.data
 t=. 3!:1 cmd data
 data=: ''
 senddata=: t,~bigendian 2 ic #t
end.
write''
if. DESTROY do. destroy'' end.
)

cmd=: 3 : 0
try.
 d=. 3!:2 y
catch.
 error 'bad data'
 return.
end.
try.
 c=. 'cmd_',>{.d
 assert. 3=nc <c
catch.
 error c,' command not defined'
 return.
end.
try.
 if. ('cmd_su_'-:7{.c)*.-.'cmd_su_su'-:c do. assert. su end.
 log__ 'cmd';sk;(coname'');c
 ". 'docmd=:',c
 if. 2=#d do.
  (<0),<docmd >1{d
 elseif. 3=#d do.
  (<0),< (>1{d) docmd >2{d
 elseif. 1=#d do.
   error c,'no arguments'
 elseif. 1 do.
   error c,'too many arguments'
 end.
catch.
 lasterror=:  13!:12''
 error c,' command failed'
 return.
end.
)

read=: 3 : 0
r=.sdrecv sk,20000
er=. sderror c=.>{.r
d=. >1{r
if. er-:'EWOULDBLOCK' do.
elseif. (er-:'ECONNRESET') +. (c=0)*.0=#d do.
 DESTROY=: 1 return.
elseif. c~:0 do. 1+'a'
elseif. 1 do.
data=: data,d
end.
addwait__ sk;'';''
)

write=: 3 : 0
if. 0=#senddata do. return. end.
if. SNDLIM>:#senddata do.
 r=. senddata sdsend sk,0
else.
 r=. (SNDLIM{.senddata) sdsend sk,0
end.
er=. sderror c=.>{.r
if. er-:'EWOULDBLOCK' do.
elseif. er-:'ECONNRESET' do.
 DESTROY=: 1 return.
elseif. c=0 do.
 n=.>1{r
 senddata=: n}.senddata
elseif. 1 do.
 1+'a'
end.
if. #senddata do. addwait__ '';sk;'' end.
)

destroy=: 3 : 0
removeserver__ coname''
sdclose sk
codestroy''
)

error=: 3 : 'log__ ''err'';sk;(coname'''');y'

bigendian=: |.^:('a'={.2 ic a.i.'a') NB. to flip or not to flip

NB. following su (superuser) commands are for admin and debugging
cmd_su_execute=: 3 : '".y'
cmd_su_interrupt=: 3 : 'loop__=:0'
cmd_su_list=: 3 : '4}.each (>(<''cmd_su_'')-:each 7{.each t) #t=.nl_jsss_ 3'
cmd_su_shutdown=: 3 : 'shutdownflag__=: 1[loop__=: 0'
cmd_su_su=: 3 : 'su=: password-:y' NB. password enables su commands

cmd_cmdlist=: 3 : 0 NB. return list of normal commands
d=. 7{."1>t=.nl_jsss_ 3
4}.each t#~('cmd_'-:"1 1 [4{."1 d)*.-.'cmd_su_'-:"1 1 d
)

su=: 0             NB. not super user

NB. ******************* part 3 - likely redefined in your server

password=: 'fubar' NB. password to become superuser

init=: ]   NB. called when server is initialized
end=: ]    NB. called when server is shutdown

start=: ]  NB. called when client locale is created
stop=: ]   NB. called when client locale is destroyed

NB. server methods are defined as cmd_method verbs

NB. create a script that adds server method definitions
NB. and overides default defintions above for password etc.
NB. see jsss_demo for an example that adds some simple server methods

