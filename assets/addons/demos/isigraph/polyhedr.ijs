NB. polyhedr.ijs
NB.
NB. set IFCLEAR to 0 to overwrite pictures

IFCLEAR=: 1

az=: (3 3$cos`0:`sin`0:`1:`0:`(-@sin)`0:`cos)`:0
az=: +/ .* az f.
el=: (3 3$0:`1:`0:`cos`0:`sin`(-@sin)`0:`cos)`:0
el=: +/ .* el f.

cube=: 3 : 0
vc=. 2 2 2#: i.8
fv=. 6 4$ 0 2 6 4 4 6 7 5 1 5 7 3 0 1 3 2 2 3 7 6 0 4 5 1
(normalize vc);fv
)

NB. normal
normal=: 3 : 0
v=. (1 0}."2 y) - 0 0{"2 y
w=. 1 2&(|."0 1)"2 v
x=. _1 _2&(|."0 1)"2 v
z=. (*/"2 w)-*/"2 x
z % %: +/"1 *: z
)

NB. normalize
NB. normalize vertices to centered at origin and unit radius.
normalize=: 3 : 0
v=. y -"1 (+/ % #) y
v=. v % >./ +/ &. (*:"_) "1 v
clean v
)

NB. tetrahedron
tetrahedron=: 3 : 0
m=: 2 1 o."1 0 o. 0 2 4 % 3
d=: +: _1 o. % +: 1 o. 1r3p1
a=: 1.5 * 1 o. d
vc=: (0 0,a), m,.0
fv=: 4 3 $ 0 3 1 0 1 2 0 2 3 1 3 2
(normalize vc);fv
fv{normalize vc
)

HP=: 50
VP=: 50

POLY=: 0 : 0
pc Poly closeok;pn "Polly Hedron";
xywh 0 0 150 150;cc g0 isigraph;
xywh 0 150 150 10;
cc s0 scrollbar;set s0 0 50 100 4;
xywh 150 0 10 150;
cc s1 scrollbar sbs_vert;set s1 0 50 100 4;
pas 0 0;pcenter;pshow
)

Poly_s0_button=: phs
Poly_s1_button=: pvs

Poly_auto_button=: pauto

pauto=: 3 : 0
v=. 3
h=. 5
wds=. 1&e. @ ('Poly'&E.) @ wd bind 'qp'

while. 1 do.
  HP=: HP+h
  if. (HP<0) +. HP>100 do.
    h=. -h
    HP=: HP++:h
  end.
  VP=: VP+v
  if. (VP<0) +. VP>100 do.
    v=. -v
    VP=: VP++:v
  end.
  if. wds'' do. pshow''
  else. return. end.
end.
)

phs=: 3 : 0
HP=: ".s0
pshow''
)

pvs=: 3 : 0
VP=: ".s1
pshow''
)

pdata=: tetrahedron ''
pcolor=: 255 0 0 , 0 255 0 , 0 0 255 ,: 255 255 0
pscl=: +:@ o.@ (_0.5&+) @ (0.01&*)

pshow=: 3 : 0
dat=. {.@+. (pdata az pscl VP) el pscl HP
nrm=. normal dat
msk=. 0 < 2{"1 nrm
dat=. gscale 2{."1 msk#dat
dat=. ,"2 roundint dat
clr=. msk#pcolor
f=. glpolygon@[ glbrush@glrgb
try.
  if. IFCLEAR do. glclear'' end.
  dat f"1 clr
  glpaint ''
catch. end.
)

3 : 0''
try. wd 'psel Poly;pclose'
catch. '' end.
wd POLY
pshow''
