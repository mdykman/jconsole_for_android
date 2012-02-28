NB. sax -- J wrapper for Simple API for XML
NB.    object-oriented wrapper for Expat library
NB.
NB. 01/19/06 Oleg Kobchenko
NB. 06/06/06 Oleg Kobchenko - j601
NB. 08/05/06 Oleg Kobchenko - stop parsing (sax_test4)
NB. 12/15/06 Oleg Kobchenko - updated for JAL

require 'xml/sax/expat'

coclass 'psax'
coinsert 'pexpat'

create=:  3 : 0
  PARSER=: ParserCreate <<0
  IGNOREWS=: 0
  seterr''
  SetElementHandler PARSER;(cdcb 3);(cdcb 2)
  SetCharacterDataHandler^:(-.IF64) PARSER;cdcb 3   NB. crash in linux64
)

destroy=: 3 : 0
  empty ParserFree PARSER
)

parse=: 3 : 0
  'input is not string' assert 2=3!:0 y
  if. 0=Parse PARSER;y;(PARLEN=:#y);0+1 do.
    if. 0-:ERRCODE_pexpat_ do. geterr PARSER end.
    destroy ''
    (assert~ error) 0 end.
)

startDocument=: ]
endDocument=: ]

startElement=: ]
endElement=: ]

characters=: ]

cdcallback=: 3 : 0
  if. 3=#y do.
    if. PARLEN(> *. 0<])2{y do.
      characters^:(*@#) trim^:IGNOREWS memchr/}.y return.end.
    (2{y) startElement memstr 1{y
  else.
    endElement memstr 1{y
  end.
)

process=: 3 : 0
  p=. '' conew >coname''
  startDocument__p''
  parse__p y
  ([ destroy__p) endDocument__p''
)

stop=: 3 : 0
  if. 0=status=. (0-:y)+.0=#y do. y apperr PARSER end.
  XML_StopParser PARSER;status  NB. false=non-resumable, ie exception
)

saxclass_z_=: cocurrent@(3 : 0) f.
  coerase boxopen y
  coclass y
  coinsert 'psax'
  process=: process_psax_ f.
  y
)
