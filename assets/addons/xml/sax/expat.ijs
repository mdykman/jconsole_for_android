NB. expat -- xml parser library binding for J
NB.    based on Expat 2.0.0 version 01/11/06 
NB.    http://expat.sourceforge.net/
NB. Mac OS X build: http://www.wsanchez.net/
NB.
NB. 01/19/06 Oleg Kobchenko
NB. 06/06/06 Oleg Kobchenko - j601
NB. 08/05/06 Oleg Kobchenko - scallar results; stop parsing
NB. 12/15/06 Oleg Kobchenko - updated for JAL

require 'dll files strings libpath'
coclass 'pexpat'

ADDONDIR=: '~addons/xml/sax'
IFMACOSX=: UNAME-:'Darwin'

3 : 0''
if. IFGTK do. 'libexpat not supported on JGTK' (13!:8) 10 end.  NB. possible conflict in cdcallback

if. UNAME-:'Linux' do.
  LIB=: > (IFDEF'android') { 'libexpat.so.1';'libexpat.so'
elseif. UNAME-:'Darwin' do.
  LIB=: '/usr/lib/libexpat.dylib'
  if. 0= #1!:0 <LIB do.
     LIB=: '/usr/X11R6/lib/libexpat.dylib'
  end.
elseif. do.
  LN=. 'libexpat',IF64#'64'
  LIB=: jpath ADDONDIR,'/lib/',LN,'.dll'
end.
)

xcdm=: 1 : '(''"'',LIB,''" '',m)&(15!:0)'

ParserCreate=:             'XML_ParserCreate            > x    *c    ' xcdm
ParserFree=:               'XML_ParserFree              > n x        ' xcdm

SetElementHandler=:        'XML_SetElementHandler       > n x  x x   ' xcdm
SetCharacterDataHandler=:  'XML_SetCharacterDataHandler > n x  x     ' xcdm

Parse=:                    'XML_Parse                   > i x  *c i i' xcdm

GetErrorCode=:             'XML_GetErrorCode            > i x        ' xcdm
ErrorString=:              'XML_ErrorString             > x x        ' xcdm
GetCurrentLineNumber=:     'XML_GetCurrentLineNumber    > i x        ' xcdm
GetCurrentColumnNumber=:   'XML_GetCurrentColumnNumber  > i x        ' xcdm

XML_StopParser=:           'XML_StopParser              > i x  i     ' xcdm


SZINT=: IF64{4 8

trim=: ] #~ [: -. [: (*./\. +. *./\) e.&(TAB,CRLF,' ')
memint=: memr@(,&(0,1 ,JINT))
memchr=: memr@(, (0,  ,&JCHAR))
memstr=: memr@(,&(0,_1,JCHAR))

attributes=: 3 : 0
  z=. empty''
  while. p=. memint y do.
    z=. z, (memstr p);memstr memint y+SZINT
    y=. y+2*SZINT
  end.
  z
)

getAttribute=: 4 : 0
  y=. ,y
  while. p=. memint x do.
    if. y-: memstr p do. memstr memint x+SZINT return.end.
    x=. x+2*SZINT
  end.
  _1
)

NB. =========================================================

seterr=: 3 : 0
  if. 3~:#y do. y=. 0;0 0;'' end.
  ('ERRCODE_pexpat_ ERRPOS_pexpat_ ERRMSG_pexpat_')=: y
  empty''
)
seterr''

geterr=: 3 : 0
  code=. GetErrorCode y
  msg=. memstr ErrorString code
  seterr code;(getpos y);msg
)

apperr=: 4 : 0
  if. 1=#x=. boxopen x do. x=. x,<'Application Error' end.
  code=. 0{::x
  msg=. 1{::x
  seterr code;(getpos y);msg
)

error=: 3 : 0
  if. ERRCODE_pexpat_=0 do. '' return. end.
  'xml error ',(":ERRCODE_pexpat_),' at (',(":ERRPOS_pexpat_),'): ',ERRMSG_pexpat_
)

getpos=: 3 : 0
  line=. GetCurrentLineNumber y
  col=. GetCurrentColumnNumber y
  line,col
)
