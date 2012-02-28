NB. object oriented sax parser specialization
NB. extended to use attributes and levels

require 'xml/sax'

saxclass 'psax2'

showattrs=: (''"_)`(' ' , ;:^:_1@:(([ , '='"_ , ])&.>/"1))@.(*@#)

startDocument=: 3 : 0
  L=: 0
)

startElement=: 4 : 0
  smoutput (L#'  '),'[',y,(showattrs attributes x),']'
  L=: L+1
)

endElement=: 3 : 0
  L=: L-1
  smoutput (L#'  '),'[/',y,']'
)

NB. =========================================================
cocurrent 'base'

TEST1=: 0 : 0
<root><test a="11"/><test b="12"/></root>
)

0 : 0  NB. Test
process_psax2_ TEST1
process_psax2_ fread jpath '~addons/xml/sax/test/chess.xml'
)
