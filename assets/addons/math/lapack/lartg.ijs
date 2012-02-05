NB. lartg   generates a plane rotation

coclass 'jlapack'

NB. =========================================================
NB.*lartg v generates a plane rotation of 2-vector:
NB.         [  cs  sn  ]     [ f ]     [ r ]
NB.         [  __      ]  .  [   ]  =  [   ]   where cs**2 + |sn|**2 = 1
NB.         [ -sn  cs  ]     [ g ]     [ 0 ]
NB.
NB. Syntax:
NB.   'cs sn r'=. lartg (f,g)
NB. where
NB.   (f,g) - 2-vector to rotate
NB.   cs sn - representation of 2-by-2 rotation matrix
NB.   r     - representation of rotated 2-vector (r 0)
NB.
NB. if:
NB.   'cs sn r'=. lartg (f , g)
NB. then
NB.   (r , 0) -: G1 mp (f , g)
NB.   (r , 0) -: (f , g) mp G2
NB.   (0 , r) -: G2 mp (g , f)
NB.   (0 , r) -: (g , f) mp G1
NB. where
NB.   G1=. 2 2 $ cs , sn , (- + sn) , cs
NB.   G2=. |: G1

lartg=: (3 : 0) " 1

y=. z2d y
ic=. iscomplex y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dlartg' ,: 'zlartg'

'f g'=. y
cs=. dzero
sn=. r=. zero

arg=. 'f;g;cs;sn;r'

(cutarg arg)=. routine call , each ". arg

cs , sn , r
)

NB. =========================================================
NB.*tlartg v test lartg

tlartg=: 3 : 0
match=. matchclean;;
smoutput 'cs sn r'=. lartg y
G=. 2 2 $ cs , sn , (- + sn) , cs
smoutput z=. (r,0) match clean G mp y
0 pick z
)

NB. =========================================================
NB. test suite:

testlartg=: 3 : 0
*./ tlartg"1 [ ((7^2^2) , 2) $, (,"0/~) , (j."0/~) _2e5 _2 _2e_5 0 2e_5 2 2e5
)
