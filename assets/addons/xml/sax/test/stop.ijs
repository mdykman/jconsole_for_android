NB. interrupt on found data or error
NB. sax_test2 extended to stop parsing.
NB. Note: end element event is still handled

require 'xml/sax'

saxclass 'pstop'

showattrs=: (''"_)`(' ' , ;:^:_1@:(([ , '='"_ , ])&.>/"1))@.(*@#)

startDocument=: 3 : 0
  L=: 0
  V=: 'not found'
)

startElement=: 4 : 0
  smoutput (L#'  '),'[',y,(showattrs attributes x),']'
  if. y-:,'p' do.
    select. x getAttribute 'n'
    case. ,'b' do. stop '' [ V=: x getAttribute 'v'
    case. _1   do. stop 1001;'Attribute "n" missing'
    end.
  end.
  L=: L+1
)

endElement=: 3 : 0
  L=: L-1
  smoutput (L#'  '),'[/',y,']'
)

endDocument=: 3 : 0
  smoutput 'Value of n=b is ',":V
)

NB. =========================================================
cocurrent 'base'

TEST4=: 0 : 0
<body><p n="a" v="11"/><p n="b" v="22"/><p n="c" v="33"/></body>
)
TEST4a=: 0 : 0
<body><p n="a" v="11"/><p n="c" v="33"/></body>
)
TEST4b=: 0 : 0
<body><p n="a" v="11"/><p v="22"/><p n="c" v="33"/></body>
)

0 : 0  NB. Test
process_pstop_ TEST4
process_pstop_ TEST4a
process_pstop_ TEST4b
)
