NB. object oriented sax parser specialization
NB. extended to use text characters

require 'xml/sax'

saxclass 'psax3'

showattrs=: (''"_)`(}.@;@:((',' , [ , '='"_ , ])&.>/"1))@.(*@#)

startDocument=: 3 : 0
  L=: 0
  IGNOREWS=: 1
)

startElement=: 4 : 0
  smoutput (L#'  '),'',y,'(',(showattrs attributes x),') {'
  L=: L+1
)

endElement=: 3 : 0
  L=: L-1
  smoutput (L#'  '),'}'
)

characters=: 3 : 0
  smoutput (L#'  '),y
)

NB. =========================================================
cocurrent 'base'

TEST3=: 0 : 0
<body><p a="11">s123</p>Between<q b="12" c="3">z456</q></body>
)

TEST5=: 0 : 0
<body><p>Case &amp; Co<q c="3&amp;4">z &quot;num&quot;</q></p>5&amp;6</body>
)

0 : 0  NB. Test
process_psax3_ TEST3
process_psax3_ TEST5
process_psax3_ fread jpath '~addons/xml/sax/test/table.xml'
)
