NB. samples of non-OOP use
NB. extended to use attributes and levels

require 'xml/sax/expat'
coinsert 'pexpat'

showattrs=: (''"_)`(;:^:_1@:(([ , '='"_ , ])&.>/"1))@.(*@#)

startElement=: 4 : 0
  smoutput (L#'  '),'(',y,' ',(showattrs attributes x),')'
  L=: L+1
)

endElement=: 3 : 0
  L=: L-1
  smoutput (L#'  '),'(/',y,')'
)

cdcallback=: 3 : 0
  e=. memstr 1{y
  if. 3=#y do. (2{y) startElement e
  else. endElement e end.
  0
)

TEST1=: 0 : 0
<root><test a="11" /><test b="12"><deep c="1" d=""/></test></root>
)

test1=: 3 : 0
  p=. ParserCreate <<0
  SetElementHandler p;(cdcb 3);(cdcb 2)
  L=: 0
  Parse p;y;(#y);1+0
  empty ParserFree p
)


0 : 0  NB. Test
test1 TEST1
test1 fread jpath '~addons/xml/sax/test/chess.xml'
)
