NB. stringWriter test

require 'xml/sax/stringWriter'

test=: 3 : 0
  sw=: '' conew 'pstringWriter'
  write__sw '<!-- begin -->',LF
  write__sw '<doc>',LF
  write__sw '  <node a="b" />',LF
  write__sw '</doc>',LF
  r=. s__sw
  destroy__sw ''
  r
)

0 : 0
test''
)
