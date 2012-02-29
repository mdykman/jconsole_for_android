NB.*jodsourcesetup   s--  creates  and   loads   JOD  development
NB. dictionaries from JOD dumps.
NB.
NB. This   script   creates   and  loads   the  JOD   development
NB. dictionaries (joddev,  jod, utils).  To run this  script  the
NB. following must hold:
NB.
NB. verbatim:
NB.
NB. 0) J 6.0x/7.0x must be installed on Windows or Linux.
NB.
NB. 1) The JOD addon must be installed. Use JAL to install
NB.    general/jod
NB.
NB. 2) The JODSOURCE addon must be installed. Use JAL to install
NB.    general/jodsource
NB.
NB. 3) The JFILES addon must be installed. Use JAL to install
NB.    data/jfiles
NB.
NB. 4) The ZIP FILES addon must be installed. Use JAL to install
NB.    arc/zip
NB.
NB.      WARNING: the arc/zip addon currently (11dec19) only works
NB.      on 32bit systems. See The JOD Page at:
NB.
NB.      http://bakerjd99.wordpress.com/the-jod-page/
NB.
NB.      For instructions on loading these dictionaries
NB.      without using this script.
NB.    
NB. 5) The directory c:\jod\j701\ (win) or /home/{$HOME}/jod/j701/ (linux)
NB.    must be empty.
NB.
NB. 6) No JOD dictionaries with names (joddev, jod, utils) exist.
NB.
NB. author:  John D. Baker
NB. created: 2011may24
NB. changes: -----------------------------------------------------
NB. 11dec19 added note about arc/zip failure on 64 bit systems

require 'files task regex dir'

cocurrent 'base'
coclass tmploc_AAAtrash999_=: 'AAAtrash999' [ coerase <'AAAtrash999'
coinsert 'ijod'

NB. retains string before first occurrence of (x)
beforestr=:] {.~ 1&(i.~)@([ E. ])

NB. returns result of linux/unix commands as text string
host=:[: 2!:0 '('"_ , ] , ' || true)'"_

NB. make a directory (1 success, 0 failure)
makedir=:1!:5 ::0:

NB. writes a list of bytes to file
write=:1!:2 ]`<@.(32&>@(3!:0))

setupjodsource=: 3 : 0

NB.*setupjodsource  v--  creates  and   loads   JOD  development
NB. dictionaries from JOD dumps.
NB.
NB. monad:  setupjodsource uuIgnore

if. -.fexist jpath '~addons/general/jod/jmaster.ijf' do.
  smoutput 'ERROR: JOD addon is not installed' return.
elseif. -.fexist jodzip=. jpath '~addons/general/jodsource/jodsource.zip' do.
  smoutput 'ERROR: JODSOURCE addon is not installed' return.
elseif. -.fexist jpath '~addons/arc/zip/zfiles.ijs' do.
  smoutput 'ERROR: ZIP FILES addon is not installed' return.
end.

NB. jfiles became an addon in J7
if. -.IFJ6 do.
  if. -.fexist jpath '~addons/data/jfiles/jfiles.ijs' do.
    smoutput 'ERROR: JFILES addon is not installed' return.
  end.
end.

require 'arc/zip/zfiles'
require 'general/jod'

NB. JOD source dictionaries in reverse path order
dicts=. ;:'utils jod joddev'
if. 1 e. dicts e. od '' do.
  smoutput 'ERROR: some JOD development dictionaries exist' return.
elseif.  0 e. (dicts ,&.> <'.ijs') e. {."1 zdir jodzip do.
  smoutput 'ERROR: missing dump scripts' return.
end.

jodroot=. '/jod/'
if. IFWIN do. jodroot=. 'c:',jodroot 
else. 
  jodroot=. (LF -.~ host 'echo $HOME'),jodroot 
end.

jversion=. '/' beforestr 9!:14 ''
joddevdir=. jodroot,jversion,'/'

if. 0 = #1 dir jodroot do.
  makedir <jodroot
  ('JOD root directory') write jodroot,'jodroot.txt'
  makedir <joddevdir
  smoutput 'JOD root directory created: ',joddevdir
else.
  smoutput 'ERROR: nonempty JOD root directory -> ',jodroot return.
end.

NB. create dictionaries
smoutput newd (0{dicts),(joddevdir,;0{dicts);'utilities dictionary'
smoutput newd (1{dicts),(joddevdir,;1{dicts);'jod source code dictionary'
smoutput newd (2{dicts),(joddevdir,;2{dicts);'jod development dictionary'

NB. extract and run dictionary dump scripts
tmppath=. jpath '~temp/'
tmpdump=. tmppath,'dump.ijs'

for_dict. dicts do.
  dict=. ;dict
  smoutput 'Loading: ',dict
  NB. WARNING: replace with manual unzipping
  NB. in case of (zread) failure 
  dumpdat=. zread (dict,'.ijs');jodzip
  (toHOST dumpdat) write tmpdump
  NB. insure dictionary path order
  od |.(>:dict_index){.dicts [ 3 od ''
  NB. load dump script
  0!:0 <tmpdump
  NB. insure we remain in working locale
  cocurrent tmploc_AAAtrash999_
  NB. regenerate cross references
  tmprefs=. 0 globs&> }. revo ''
  smoutput 'Cross references generated: ',dict
end.

smoutput 'SUCCESS: registered JOD dictionaries' [ 3 od ''
smoutput 4 od ''
)

setupjodsource 0

cocurrent 'base'
coerase <tmploc_AAAtrash999_
