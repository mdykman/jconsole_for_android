NB. fileWriter test

require 'xml/sax/fileWriter'

test=: 3 : 0
  1!:55 :: _1: <jpath fn=. '~temp/fw.txt'
  fw=: fn conew 'pfileWriter'
  write__fw '<!-- begin -->',LF
  write__fw '<doc>',LF
  write__fw '  <node a="b" />',LF
  write__fw '</doc>',LF
  destroy__fw ''
  r=. 1!:1 :: _1: <jpath fn
  1!:55 :: _1: <jpath fn
  r
)

0 : 0
test''
)
