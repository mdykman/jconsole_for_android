NB. init

coclass 'plifecfg'
coinsert 'plife'

lf2blank=. 3 : 0
' ' (I. y=LF)} y
)

NoEvents=: 0

Counts=: lf2blank 0 : 0
The undo buffer takes one byte per cell per iteration, e.g. 1 MB for 1024x1024 cells.
Reduce the buffer size for large boards and limited memory.
)

Runs=: lf2blank 0 : 0
The minimum run is the number of steps taken without interruption.
The delay is the time in milliseconds for the interrupt.
For example, set run to 1 and delay to 1000 to step every second.
)

locWin=: ''

NB. =========================================================
create=: 3 : 0
locWin=: COCREATOR
(~.locWin,copath coname'')copath coname''
cfg_run''
)

NB. =========================================================
destroy=: 3 : 0
cbfree''
codestroy''
)

