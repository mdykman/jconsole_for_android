NB. Script anins2.ijs
NB. by Cliff Reiter variant on the script for the note "CD Labels"
NB. for use by the image3 addon; especially prevare.ijs
NB. Last update, June, 2002
NB. modified for J6.01, Sept 2006

NB. locale for image3 addon
coinsert 'ima3'
coclass 'ima3'

AnIns=:2 : 0
:
imsz=.#x
'r0 r1'=.m
'a0 a1'=.n
i2s=.<:@(*&(2%imsz-1))             NB. image coord to seminormal
nr=.(%r0-r1)"_ * 10&o. - r1"_      NB. normalized radius
na=.(%a1-a0)"_ * 12&o. - a0"_      NB. normaized angle
np=.(nr,na)@+@j.&i2s  f.           NB. normalized polar coordinate function
i=.0
z=.i.0,imsz,2}.$x
while. i<imsz do.
  npc=.(i.imsz) np i
  q=.*./ |: (0&<: *. <:&1)npc
  od=.i{x
  if. 0<+/q do.
    id=. (<"1 <. 0.5+(<:2{.$y)*"1 q#npc){y
    z=.z,id(q#i.imsz)}od
  else.
    z=.z,od
  end.
  i=.>:i
end.
z
)


AnIns2=:2 : 0
:

imsz=.#x
'r0 r1'=.m
'a0 a1'=.n
i2s=.<:@(*&(2%imsz-1))             NB. image coord to seminormal
nr=.(%r0-r1)"_ * 10&o. - r1"_      NB. normalized radius
na=.(%a1-a0)"_ * 12&o. - a0"_      NB. normaized angle
np=.(nr,na)@+@j.&i2s  f.           NB. normalized polar coordinate function
for_i. i. imsz do.
  npc=.(i.imsz) np i
  q=.*./ |: (0&<: *. <:&1)npc
  od=.i{x
  if. 0<+/q do.
    id=. (<"1 <. 0.5+(<:2{.$y)*"1 q#npc){y
    x=.(id(q#i.imsz)}od)i}x
  end.
end.
x
)
