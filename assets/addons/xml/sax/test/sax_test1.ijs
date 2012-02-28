NB. simple object oriented sax parser specialization

require 'xml/sax'

saxclass 'psax1'

startElement=: 4 : 0
  smoutput '[',y,']'
)

endElement=: 3 : 0
  smoutput '[/',y,']'
)

NB. =========================================================
cocurrent 'base'

TEST1=: 0 : 0
<root><test a="11"/><test b="12"/></root>
)

0 : 0  NB. Test
process_psax1_ TEST1
process_psax1_ fread jpath '~addons/xml/sax/test/chess.xml'
)
