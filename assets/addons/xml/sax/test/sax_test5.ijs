NB. object oriented sax parser specialization
NB. text characters accumulated, with entities

require 'xml/sax'

saxclass 'psax5'

showattrs=: (''"_)`(}.@;@:((',' , [ , '='"_ , ])&.>/"1))@.(*@#)

startDocument=: 3 : 0
  L=: 0
  IGNOREWS=: 0
  C=: ''
)

startElement=: 4 : 0
  dump''
  smoutput (L#'  '),'',y,'(',(showattrs attributes x),') {'
  L=: L+1
)

endElement=: 3 : 0
  dump''
  L=: L-1
  smoutput (L#'  '),'}'
)

characters=: 3 : 0
  C=: C,y
)

dump=: 3 : 0
  if. #C do. smoutput (L#'  '),C end.
  C=: ''
)

NB. =========================================================
cocurrent 'base'

TEST5=: 0 : 0
<body><p>Case &amp; Co<q c="3&amp;4">z &quot;num&quot;</q></p>5&amp;6</body>
)

0 : 0  NB. Test
process_psax5_ TEST5
process_psax5_ fread jpath '~addons/xml/sax/test/table.xml'
)
