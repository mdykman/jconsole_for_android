NB. xml/sax/writer

require 'xml/sax strings'

coclass 'psaxWriter'

esc=: ('&';'&amp;';'<';'&lt;';'>';'&gt;';'"';'&quot;')&stringreplace
showattrs=: (''"_)`(' ' , ;:^:_1@:(([ , '="' , '"' ,~ esc@])&.>/"1))@.(*@#)

attrs=: [: showattrs attributes_pexpat_^:(0=#@$)

create=: 3 : 0
  wr=: y
  LINE=: LF
  IND=: '  '
)

destroy=: codestroy

ind=: 0&$: : (4 : 'y ,~ IND #~ 0>.x+#I')

startDocument=: 3 : 0
  I=: $0
)

endDocument=: ]

startElement=: ''&$: : (4 : 0)
  write__wr^:({:I) LINE
  write__wr ind^:({:I) '<',y,(attrs x),'>'
  I=: I,1
  F=: 1
)

endElement=: 3 : 0
  if. F do. I=: 1 (<:#I) } I end.
  write__wr^:((-.F)*.{:I) LINE
  write__wr _1 ind^:((-.F)*.{:I) '</',y,'>'
  I=: }:I
  F=: 0
)

characters=: 3 : 0
  if. F do. I=: 0 (<:#I) } I end.
  F=: 0
  write__wr^:({:I) LINE
  write__wr ind^:({:I) esc y
)
