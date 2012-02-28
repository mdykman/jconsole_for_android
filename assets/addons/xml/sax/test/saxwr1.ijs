NB. fileWriter test

require 'xml/sax/writer'
require 'xml/sax/stringWriter'
require 'xml/sax/fileWriter'

test=: 3 : 0
  startDocument__y ''
    startElement__y 'doc'
      a=. ,:'qq';'xx'
      a startElement__y 'node'
      endElement__y 'node'

      a=. _2 ]\ cut 'align right style color:blue'
      a startElement__y 'p'
      characters__y 'This is a test'
      endElement__y 'p'
    endElement__y 'doc'
  endDocument__y ''
)

testString=: 3 : 0
  sw=: '' conew 'pstringWriter'
  xw=: sw conew 'psaxWriter'
  test xw
  r=. s__sw
  destroy__sw ''
  destroy__xw ''
  r
)

testFile=: 3 : 0
  1!:55 :: _1: <jpath fn=. '~temp/fw.txt'
  fw=: fn conew 'pfileWriter'
  xw=: fw conew 'psaxWriter'
  test xw
  destroy__fw ''
  destroy__xw ''
  r=. 1!:1 :: _1: <jpath fn
  1!:55 :: _1: <jpath fn
  r
)

0 : 0
testString''
testFile''
)
