NB. examples of error processing
NB. Note: there is not specialization of psax here, but
NB.       the same processing will happen in any inherited class

require 'xml/sax'

TERR1=: 0 : 0
<root><test a="11"><test b="12"/></root>
)

TERR2=: 0 : 0
<root><test a="11">
  &<test b="12"/></root>
)

TERR3=: 0 : 0
<root><test a /><test b="12"/></root>
)

TERR4=: 0 : 0
<test a="11" /><test b="12"/></root>
)

0 : 0  NB. Test
3 : 'try. process_psax_ TERR1 catch. smoutput ERRCODE_pexpat_ end.' ''
3 : 'try. process_psax_ TERR1 catch. smoutput ERRMSG_pexpat_ end.' ''
3 : 'try. process_psax_ TERR1 catch. smoutput ERRPOS_pexpat_ end.' ''
3 : 'try. process_psax_ TERR1 catch. smoutput 13!:12 i.0 end.' ''
process_psax_ TERR1
process_psax_ TERR2
process_psax_ TERR3
process_psax_ TERR4
)
