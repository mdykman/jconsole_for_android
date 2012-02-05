NB.*jodprofile s-- JOD dictionary profile.
NB.
NB. An example JOD profile script. Save this script in
NB.
NB. ~addons/general/jod/
NB.
NB. with the name jodprofile.ijs
NB.
NB. This script  is  executed  after all dictionary  objects have
NB. been created. It  can  be used  to  set up  your default  JOD
NB. working environment.
NB.
NB. WARNING: Do not dpset 'RESETME' if more than one  JOD task is
NB. active. If only one task is active RESETME's prevent annoying
NB. already open  messages that frequently result from forgetting
NB. to close dictionaries upon exiting J.
NB.
NB. Note to  J developers. A shutdown sentence (a line  of J  the
NB. interpretor  executes  before   terminating)  would  be  very
NB. useful.
NB.
NB. author: John D. Baker
NB. email:  bakerjd99@gmail.com

NB. set white space preservation on
9!:41 [ 1

NB. do not reset if you are running more than one JOD instance
dpset 'RESETME'

NB. JOD interface locale 
coclass 'ijod'

NB. following are handy (ijod) locale shortcuts:

NB. project shortcuts - use explicit 
NB. defintions so it's easy to reset the group/suite
ag=: 3 : 'jodg addgrp y'
as=: 3 : '(jods;3) addgrp y'
dg=: 3 : 'jodg delgrp y'
ds=: 3 : '(jods;3) delgrp y'
   
NB. referenced group words not in group
nx=: 3 : '(allrefs  }. gn) -. gn=. grp jodg'
   
NB. words in group using a word
ug=: 3 : 'y usedby }. grp jodg'
   
NB. generate & save load script
sg=: 3 : 'mls jodg [ y'

NB. top (put dictionary) words, groups in revision order
tw=: revo
tg=: 2&revo

NB. run tautology as plaintest - does not stop on nonzero results
rt=: 2&rtt

NB. run macro silently - will show explict smoutput
rs=: 1&rm

NB. short help for group words
hg=: [: hlpnl [: }. grp

NB. short help on put objects in revised order from code:
NB.   hr 4  NB. macro
NB.   hr 2  NB. groups
hr=: 13 : 'y hlpnl }. y revo '''' [ y'

NB. single line explanation for nonwords
NB.  4 slex 'jodregister'  NB. macro
NB.  1 slex 'thistest'     NB. test
slex=: 4 : '(x,8) put y;firstcomment__JODtools x disp y'

NB. regenerate put dictionary word cross references
reref=: 3 : '(n,.s) #~ -.;0{"1 s=.0 globs&>n=.}.revo'''' [ y'

NB. handy cl doc helpers
docscr=: 3 : 'ctl_ajod_ (61;0;0;''NB.'') docct2__UT__JODobj ];._1 LF,y-.CR'
doctxt=: 3 : 'ctl_ajod_ (61;0;0;'''') docct2__UT__JODobj ];._1 LF,y-.CR'

NB. display noun on screen and return noun value
showpass=:] [ 1!:2&2

NB. edit command 
DOCUMENTCOMMAND=: 'showpass pr ''{~N~}'''

NB. examples of JOD session start ups - shows
NB. how to open dictionaries and invoke project macros

NB. set up current project (1 suppress IO, 0 or elided display)
NB. 1 rm 'prjsmughacking' [ smoutput od ;:'smugdev smug utils'
NB. 1 rm 'prjjod' [ smoutput od ;:'joddev jod utils'

NB. current start up
NB. smoutput od ;:'mwecc utils'

cocurrent 'base'
coinsert 'ijod'
