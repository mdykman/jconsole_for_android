NB. samples of non-OOP use

require 'xml/sax/expat'
coinsert 'pexpat'

TEST1=: 0 : 0
<root><test a="11"/><test b="12"/></root>
)

startElement=: 4 : 0
  smoutput '(',y,')'
)

endElement=: 3 : 0
  smoutput '(/',y,')'
)

cdcallback=: 3 : 0
  elm=. memr (1{y),0,_1,JCHAR
  if. 3=#y do.
    (2{y) startElement elm
  else.
    endElement elm
  end.
)

test1=: 3 : 0
  p=. ParserCreate <<0
  SetElementHandler p;(cdcb 3);(cdcb 2)
  Parse p;TEST1;(#TEST1);0+1
  empty ParserFree p
)


0 : 0   NB. Test
test1 ''
)
