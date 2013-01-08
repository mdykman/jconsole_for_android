9!:1 >.*:+/6!:0 ''                NB. set random seed

free=: ' '                        NB. free square ' ' or '.'

run=: 3 : 0
q=. a:-.~<;._2 y,' '
n=. ".>{.q
q=. }.q
n runc q
)

runc=: 4 : 0                      NB. runs complete history
N=: x
seq=: q=. y
NNN=: N,NN=: N,N
IN4=: i.N4=: N*4
IN=: i.N
IX=: <"1(N,2)$2#IN                NB. indexes for all new rows for a side
BS=: NN$free
ps=: (0,NN)$,BS
sign=: 1
while. #q do.
  sign=: -.sign
  ps=: ps,BS=: ((sign{'XO'),>{.q) Play BS
  q=. }.q
end.
piece=: (-.sign){'XO'
allm=: piece moves BS             NB. calculate all possible moves
alln=: mnames N                   NB. move names corresp. to allm
i.0 0
)

pickrandom=: ?@# { ]
pickmax=: (= >./) # i.@#
pickmove=: 1 : '(pickrandom pickmax y u allm){alln'

Play=: 4 : 0      NB. mv Play board  makes one move. e.g. 'XT1' Play 5 5$' '
'm d'=. 2{.x
i=. <:".2}.x
select. d
case. 'L' do. y i}~m LT i{y
case. 'R' do. y i}~m LT&.|. i{y
case. 'T' do. y j}~m LT j{y [ j=. <a:;i
case. 'B' do. y j}~m LT&.|. j{y [ j=. <a:;i
end.
)

LT=: #@] {. [ , (i.@#@] ~: ] i. free"_) # ]

chrows=: 4 : 0   NB. new row for each left side move
q=. x,. (IN{"0 2 y),. free
i=. q i."1 free
N{."1 (i~:/i.N+2) #"1 q
)

side=: # # ,:                                 NB. make n copies of a board
lmoves=: 4 : '(x chrows q) IX} q=.side y'   NB. left moves
rmoves=: lmoves&.(|."1"_)                     NB. right
tmoves=: lmoves&.(|:"2"_)                     NB. top
bmoves=: rmoves&.(|:"2"_)                     NB. bottom
moves=: lmoves, rmoves, tmoves, bmoves
mnames=: ,/ @: ('LRTB'"_ ,."0 2 ]) @: (":"0) @: >: @: i.

flip=: 'X'&=@[ { 'XO'"_

straight=: +/"1 @: ({:@$ = +/"1 ,"1 +/"2) @: =
evstraight=: straight - flip@[ straight ]

evline=: +/"1 @: (* * 2&^@:|) @: (+/"1 ,"1 +/"2) @: (= - flip@[ = ])

evrepeat=: 4 : '- y e. ((#ps)$''XO''=x)#ps'

dedge=: >: @: (+/~) @: (i. <. i.@-)
count=: +/"1 @: (,"2) @: (dedge@{:@$ *"2 ]) @: =
evcount=: count - flip@[ count ]

ev=: evline + evcount + 1e8"_ * evrepeat + evstraight

ev2a=: flip@[ ([ -@:(>./"1)@:ev moves)"2 ]

ev2=: 4 : 0                    NB. 2-ply search using ev on each ply
p=. x ev y
i=. I.  (_1e6<p)*.p<1e6   NB. look on only if non winner & non loser
q=. (x ev2a i{y) i}p
(*./_1e6>q){q,:p               NB. if q is all bleak, just use p
)
