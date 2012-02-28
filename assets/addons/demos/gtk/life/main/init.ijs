NB. init
NB.
NB. life rules
NB. For a space that is occupied:
NB.     Each cell with one or no neighbors dies
NB.     Each cell with four or more neighbors dies
NB.     Each cell with two or three neighbors survives.
NB. For a space that is empty:
NB.     Each cell with three neighbors becomes populated.
NB.
NB. Each step is computed as follows:
NB.
NB. STATE=: TRANS {~ #. INDEX { STATE
NB.
NB. Suppose n is the number of cells in the board.
NB. STATE is the ravelled board, a boolean of length n with 1=alive.
NB. INDEX is a n x 9 table of indices that gives the 9 surrounding cells for each cell.
NB. TRANS is a list of length 512=2^9, that gives the new life state for each old value.

require 'gl2'

coclass 'plife'
coinsert 'jgtk jgl2'

SCALE=: 4 NB. each cell takes SCALE pixels
BOARD=: 128 160 NB. rows,cols size of board
PATH=: jpath '~Demos/gtk/demos/gtk/life/lif' NB. path to pattern files
TIMER=: 1 NB. milliseconds
MAXITER=: _ NB. maximum iterations
MAXBUF=: 100 NB. maximum states kept in buffer
MINRUN=: 25 NB. run before timer event

NB. yellow on teal
BOARDCOLOR=: 0 128 128
CELLCOLOR=: 255 255 0
HASBUF=: 0
HWNDP=: 0
FILE=: ''

NB. =========================================================
create=: 3 : 0
if. -.IFGTK do.
  require 'gtk'
  gtkinit_jgtk_''
end.
run 'coerake1'
if. -.IFGTK do.
  gtk_main''
end.
)

NB. =========================================================
destroy=: 3 : 0
cbfree''
codestroy''
)
