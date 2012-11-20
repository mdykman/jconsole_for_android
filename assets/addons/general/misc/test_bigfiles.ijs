NB. 	bytes written=.data bappend f						 	append to end
NB. 	data=.bixread f;start0,start1[,len[,dirflag]]			indexed read
NB. 	bytes written=.data bixwrite f;start0,start1[,dirflag] 	indexed write	
NB. 	free space=.bdiskfreespaceex dir						get disk free space
NB. 	free space=.bdiskfreespace drive root					get disk free space (device units)
NB. 	size=.bfsize f											get file size
NB. 	fh=.[mode] bopen filename								open file input or inout
NB.     success=.bclose fh										close open file

load '~/addons/general/misc/bigfiles.ijs'

foo=: 3 : 0
smoutput '   ',y
smoutput ". y
)

F=: jpath '~temp/t1.dat'
'abc ' fwrite F
foo '''hello'' bappend_jbf_ F'
foo 'fread F'
foo 'H=: bopen_jbf_ ''c:/jmisc/extern/wagon/w228.ijs'''
foo 'bixread_jbf_ H;0 3 3'
foo 'bclose_jbf_ H'
foo 'bdiskfreespace_jbf_ ''d:'''
foo 'bdiskfreespaceex_jbf_ ''d:'''
foo 'bfsize_jbf_ ''jpath '~bin/j.exe'''
