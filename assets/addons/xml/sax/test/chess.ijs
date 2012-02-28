NB. chess -- a more complete example of custom parser
NB. transforms XML chess board into a J character matrix

require 'xml/sax viewmat'

saxclass 'pchess'

COLORS=: ;:'whitepieces blackpieces'
PIECES=: ;:'pawn rook night bishop queen king'
SYMBOLS=: 'PRNBQKprnbqk'

startElement=: 4 : 0
  e=. <y
  if. 2>C=. COLORS i.e do. COLOR=: C*6 return. end.
  if. 6>P=. PIECES i.e do. PIECE=: SYMBOLS{~COLOR+P return. end.
  if. -.'position'-:y  do. return. end.

  r=. <:0".       x getAttribute 'row'
  c=. 'abcdefgh'i.x getAttribute 'column'
  empty BOARD=: PIECE (<r,c) } BOARD
)

startDocument=: 3 : 0
  BOARD=: '. '{~ ~:/~2|i.8
)

endDocument=: 3 : 0
  |.BOARD
)

NB. =========================================================
cocurrent 'base'

0 : 0  NB. Test
process_pchess_ fread jpath '~addons/xml/sax/test/chess.xml'
viewbmp jpath'~addons/xml/sax/test/chess.bmp'
)
