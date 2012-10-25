coclass 'jexpat'

SZI=: IF64{4 8
expat_characterData=: ''

3 : 0''
if. UNAME-:'Linux' do.
  LIB=: 'libexpat.so.1'
elseif. UNAME-:'Android' do.
  LIB=: 'libexpat.so'
elseif. UNAME-:'Darwin' do.
  if. -.fexist LIB=: '/usr/lib/libexpat.dylib' do.
    LIB=: 'libexpat.dylib'
  end.
elseif. UNAME-:'Win' do.
  if. fexist f=. jpath '~install/gtk/bin/libexpat-1.dll' do.
    LIB=: '"', '"',~ f
  else.
    LIB=: 'libexpat-1.dll'
  end.
end.
)

XML_ErrorString=: (LIB, ' XML_ErrorString >', (IFWIN#' +'), ' x x')&(15!:0)
XML_GetCurrentColumnNumber=: (LIB, ' XML_GetCurrentColumnNumber >', (IFWIN#' +'), ' i x')&(15!:0)
XML_GetCurrentLineNumber=: (LIB, ' XML_GetCurrentLineNumber >', (IFWIN#' +'), ' i x')&(15!:0)
XML_GetErrorCode=: (LIB, ' XML_GetErrorCode >', (IFWIN#' +'), ' i x')&(15!:0)
XML_Parse=: (LIB, ' XML_Parse >', (IFWIN#' +'), ' i x *c i i')&(15!:0)
XML_ParserCreate=: (LIB,' XML_ParserCreate >', (IFWIN#' +'), ' x *c')&(15!:0)
XML_ParserFree=: (LIB, ' XML_ParserFree >', (IFWIN#' +'), ' n x')&(15!:0)
XML_SetCharacterDataHandler=: (LIB, ' XML_SetCharacterDataHandler >', (IFWIN#' +'), ' n x x')&(15!:0)
XML_SetElementHandler=: (LIB, ' XML_SetElementHandler >', (IFWIN#' +'), ' n x x x')&(15!:0)
XML_StopParser=: (LIB, ' XML_StopParser >', (IFWIN#' +'), ' i x i')&(15!:0)

XML_FALSE=: 0
XML_TRUE=: 1

XML_STATUS_OK=: 1
XML_STATUS_ERROR=: 0
XML_STATUS_SUSPENDED=: 2
expat_initx=: 0:
expat_start_elementx=: 0:
expat_end_elementx=: 0:
expat_parse_xmlx=: 3 : ' 0;'''';'''' '
expat_parse_xml=: 3 : 0
'' expat_parse_xml y
:
expat_init x
parser=. XML_ParserCreate <<0
f=. [: 15!:13 (IFWIN#'+') , ' x' $~ +:@>:
XML_SetElementHandler parser, (f 3), (f 2)
XML_SetCharacterDataHandler parser, (f 4)

if. XML_STATUS_ERROR = XML_Parse parser; y; (PARLEN=: #y); XML_TRUE do.
  err=. memr 0 _1 2,~ XML_ErrorString XML_GetErrorCode parser
  lncol=. (XML_GetCurrentLineNumber parser), XML_GetCurrentColumnNumber parser
  XML_ParserFree parser
  _1;err;lncol return.
end.

XML_ParserFree parser
expat_parse_xmlx''
)
expat_init=: 3 : 0
expat_characterData=: ''
expat_initx y
EMPTY
)
expat_start_element=: 3 : 0
'data element attribute'=. y
expat_characterData=: ''
elm=. evalbs memr 0 _1 2,~ element
att=. val=. 0$<''
i=. 0
while. pa1=. {.memr 0 1 4,~ attribute+SZI*i do.
  pa2=. {.memr 0 1 4,~ attribute+SZI*i+1
  att=. att, <evalbs memr 0 _1 2,~ pa1
  val=. val, <evalbs memr 0 _1 2,~ pa2
  i=. 2+i
end.
y expat_start_elementx~ elm;att;<val
EMPTY
)

expat_end_element=: 3 : 0
'data element'=. y
expat_characterData=: evalbs dltb (LF,' ',TAB,' ') charsub expat_characterData
expat_end_elementx y
expat_characterData=: ''
EMPTY
)
cdcallback=: 3 : 0
y=. 15!:17''
if. 3=#y do. expat_start_element y
elseif. 2=#y do. expat_end_element y
elseif. 4=#y do. expat_char_data 3{.y
end.
)
expat_char_data=: 3 : 0
'data s len'=. y
expat_characterData=: expat_characterData, memr s,0,len,2
EMPTY
)

subst2=: (_2<\'\"\\\/\b\f\n\r\t')&(i.{(34 92 47 8 12 10 13 9{&.><a.),])"0
hexchars=. 'ABCDEF0123456789abcdef'
dfh=: 16 #. 16 | _6 + hexchars i. ]
subst6=: (8 u:[:u:@dfh 2}.]) ::]^:(6&=@#*.('\'={.)*.'uU'e.~{.@}.)&.>

splitbs=: (0;(0 10#:10*".;._2]0 :0);(a.e.hexchars)+(2*a.='\')+3*a.e.'Uu')&;:
 1.1  1.1  2.1 1.1
 1.0  1.0  2.2 1.0
 3.0  3.0  3.0 4.0
 1.2  1.2  2.2 1.2
 1.2  5.0  2.2 1.2
 1.2  6.0  2.2 1.2
 1.2  7.0  2.2 1.2
 1.2  3.0  2.2 1.2
)
evalbs=: [:; [:subst2 [:subst6 splitbs^:(*@#)
