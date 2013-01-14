WHITE=: 0
BLACK=: _1
FREE=: _2

init=: + FREE*0=]

see=: 3 : 'y { _1|.(":&.>1+i.>./,y),<"0 ''?X '''

connect=: 3 : 0     NB. connection matrix for Nurikabe
s=. WHITE<.y
i=. I., (}.=}:) s
j=. I., 0,.~(}."1 = }:"1) s
(+.|:) 1 (<"1 (i+/0,{:$y),j+/0 1)}=i.*/$y
)

tc=: +./ .*~^:(>.@(2&^.)@#)
NB. transitive closure of a reflexive graph

islands=: ~. @ (<@I."1"_) @ tc @ connect
NB. connected components

check=: 3 : 0       NB. 1 iff y is a Nurikabe solution
assert. (y e. BLACK,WHITE) +. 0<y
assert. -. 2 2 (2 2$BLACK)&-:;._3 y
c=. islands y
assert. (#c) = 1++/,0<y
i=. c{&.><,y
n=. #&>i
b=. i = n$&.><BLACK
assert. 1=+/b
assert. b +. *./@(0&<:)&>i
assert. b +. 1 = +/@(0&<)&>i
assert. b +. n = +/&>i
1
)

wf=: 3 : 0          NB. # white cells, # free cells
t=. ,y
m=. (+/0>.t)-+/(0<t)+.t=WHITE
n=. +/t=FREE
m,n
)

comb=: 4 : 0        NB. All size x combinations of i.y
k=. i.>:d=. y-x
z=. (d$<i.0 0),<i.1 0
for. i.x do. z=. k ,.&.> ,&.>/\. >:&.> z end.
; z
)

bf=: 3 : 0          NB. brute force solver
t=. ,y
b=. t=FREE
'm n'=. wf t
t=. ($y) $"1 (t*-.b) +"1 b #^:_1"1 ((i.n) e."1 m comb n){BLACK,WHITE
t {~ (check :: 0:"2 i. 1:) t
)

heuristics=: hendgame @ (hislands @ h2ell @ h22 ^:_) @ h2far

bfh=: bf @ heuristics @ init
NB. brute force with heuristics

h2far=: 3 : 0       NB. set to black cells too far from a numbered cell
i=. ($y)#:I.,_2=y
j=. ($y)#:I.,1<y
b=. (i +/@:|@:-"1/ j) */ .>: (1<y)#&,y
p=. (i.$y) e. ($y)#.b#i
(p*BLACK) + y*-.p
)

neighborhood=: 3 3 ,;._3 [,.([,],[),.[
NB. neighborhood of each atom in y, bordering y by x

h22=: 3 : 0         NB. set to white the free cell of a 2x2 block with 3 black cells
p=. (FREE=y) *. +./"1 (=i.4) e.~ (,/2 2 ,;._3 i.3 3) {"2 1 (BLACK,FREE) i. WHITE neighborhood y
(p*WHITE) + y*-.p
)

NB. If a 2-cell has only two possibilities for a white neighbor,
NB. and the three cells together form an "L",
NB. then set to black the neighbor of the two limbs of the "L".

h2ell=: 3 : 0
k=. #: 12 10 5 3
t=. FREE = (* (2=4{"1]) * (k{BLACK,FREE) e.~ 1 3 5 7{"1 ]) ,/ BLACK neighborhood y
i=. I. -. t-:"1 (9$0)
j=. (k i.(<i;1 3 5 7){t){(-1 _1+n),_1 1+n=. {:$y
p=. (i.$y) e. i+j
(p*BLACK) + y*-.p
)

NB. set to black neighbors of complete white islands
NB. set to white the only free neighbor of an incomplete white island surrounded by blacks
NB. set to black the only free neighbor of a black island, if there is more than one black island
NB. set to black a free cell neighboring >1 numbered white islands
NB. set to x cells of a free island surrounded by x cells

hislands=: 3 : 0
N=. 1 3 5 7 {"1 ,/_1 neighborhood i.$y  NB. neighbors for each cell
t=. islands y                           NB. islands
c=. t{&.><,y                            NB. corresp. colors
n=. (t ,@:{&.> <N) ~.@-.&.> _1,&.>t     NB. neighbors of each island
d=. n{&.><,y                            NB. corresp. colors
s=. (#&>c) (= * 0<]) +/&>c              NB. for white islands, 1 iff complete
y=. BLACK i"_} y [ i=. ;p#n [ p=. w * s [ w=. WHITE<:{.&>c
y=. WHITE i"_} y [ i=. ((p#d)i.&>FREE){&>p#n [ p=. w * s < (FREE e.&>d) * (<:#&>d)=+/@(BLACK&=)&>d
y=. BLACK i"_} y [ i=. ((p#d)i.&>FREE){&>p#n [ p=. (1=+/@(FREE&=)&>d) (* * 1<+/@]) BLACK={.&>c
y=. BLACK i"_} y [ i=. (I.FREE=,y) (e.#[) (-.@~: # ]) ;n#~0<+/&>c
y=. BLACK i"_} y [ i=. ; t #~ f * */@(BLACK&=)&>d [ f=. FREE={.&>c
y=. WHITE i"_} y [ i=. ; t #~ f * WHITE=<./&>d
)

NB. set to black all free cells if no white cells are left
NB. set to white all free cells if # missing white cells equals # free cells

hendgame=: 3 : 0
c=. wf y
(p*i{BLACK,WHITE,FREE) + y*-.p=. (FREE=y)*2>i=. ((0={.c),=/c)i.1
)

NB. apply heuristics and pick a cell that can be colored
NB. the result is (i,j,COLOR), or '' if no hints are available

hint=: 3 : 0
if. -. y -: h=. h2far y do. h ijv y~:h return. end.
if. -. y -: h=. h22 y do. h ijv y~:h return. end.
if. -. y -: h=. h2ell y do. h ijv y~:h return. end.
if. -. y -: h=. hislands y do. h ijv y~:h return. end.
if. -. y -: h=. hendgame y do. h ijv y~:h return. end.
''
)

ijv=: 4 : '(, x {~ <) ($y) #: (?@# { ]) I.,y'
NB. (row,column,value) in x of a cell having value 1 in boolean y
