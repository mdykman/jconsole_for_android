NB. J Simple Socket Client
NB. port conew 'jssc'
NB. (port;host;timeout;dodefine) conew 'jssc'
NB. 1200 conew 'jssc'
NB. (1200;'localhost';30000;1) conew 'jssc'
NB. (1200;'192.168.1.3';30000;1) conew 'jssc'
NB. timeout for break recognition
NB. dodefine 0 - avoids defining covers

coclass 'jssc'
require 'socket'
coinsert 'jsocket'

SNDLIM=: 40e3 NB. avoid clogging send buffers

create=:3 : 0
'port host timeout dodefine'=: 4{.(boxopen y),'localhost';5000;1
sk=: {.>sdcheck sdsocket''
sdioctl sk,FIONBIO,1
sdconnect sk;(sdcheck sdgethostbyname host),<port
while. -.sk e. >1{sdcheck sdselect '';sk;'';timeout do. end.
if. dodefine do. define 'cmdlist' call <'' end.
)

read=: 3 : 0
r=. sdcheck sdselect sk;'';'';timeout
if. sk e. >{.r do. ,>sdcheck sdrecv sk,20000 else. '' end.
)

call=: 4 : 0
d=. 3!:1 (<x),y
d=.d,~bigendian 2 ic #d
while. #d do.
 r=. sdcheck sdselect '';sk;'';timeout
 if. sk e. >1{r do.
  if. SNDLIM>:#d do.
   d=. d}.~>sdcheck d sdsend sk,0
  else.
   d=. d}.~>sdcheck (SNDLIM{.d) sdsend sk,0
  end.
 end.
end.
while. 4>#d do. d=. d,read'' end.
len=. _2 ic bigendian 4{.d
d=.4}.d
while. len>#d do. d=. d,read'' end.
d=.3!:2 d
if. 0~:>{.d do. (>1{d) 13!:8 [3 end.
>1{d
)

define=: 3 : 0
''[".each definesub each y
)

definesub=: 3 : 0
a=. '''''',y,'''''call'
y,'=: 3 : ''',a,'<y',LF,':',LF,a,'(<x),<y'''
)

su=: 3 : 0
'su_su' call <y
define 'su_list' call <''
)

destroy=: 3 : 0
sdclose sk
codestroy''
)

bigendian=: |.^:('a'={.2 ic a.i.'a') NB. to flip or not to flip