require 'regex'

coclass 'jgtkdocdict'
nameuri=: 4 : 0
y=. y }.~ (#' href="') + 1 i.~ ' href="' E. y
uri=. ({.~ i.&'"') y
name=. _3}. }. (}.~ i:&'>') }:y
if. (0=#name)+.(0=#uri)+.('#'={.uri) do.
  ''
else.
  name,' ',x,'/',uri
end.
)
main=: 3 : 0
s=. ''
if. 0= #r=. ffss jpath '~addons/docs/gtk/', y do. s return. end.
s, /:~ (<'') -.~ ~. (<y) nameuri&.> <;._2 r
)
what=: '<a.*? href="(.*?)".*?>(.*?)</a>'

ffssinit=: 3 : 0
p=. y
FIFCOMP=: rxcomp_jregex_ :: _1: p
if. _1 e. FIFCOMP do.
  smoutput 'Unable to compile regular expression'
  rxfree_jregex_ FIFCOMP
  0
else.
  1
end.
)

ffss=: 3 : 0
fls=. ''
if. fexist a=. jpath y,'/api-index-full.html' do. fls=. fls,<a end.
if. fexist a=. jpath y,'/index-all.html' do. fls=. fls,<a end.
if. 0 e. #fls do. '' return. end.
if. 0=ffssinit what do. '' return. end.
fnd=. ''
while. #fls do.
  txt=. freads fl=. >{.fls
  fls=. }.fls
  if. txt -: _1 do. continue. end.
  fnd=. fnd, fftext toJ txt

end.
rxfree_jregex_ FIFCOMP
fnd
)
fftext=: 3 : 0
txt=. y
z=. ''
'ndx lenx'=. |: FIFCOMP ffmatches txt
if. rws=. #ndx do.
  match=. ({. <@:+ i.@{:)"1 ndx ,. lenx
  z=. ; (<{.a.) ,&.>~"0 match (>@:[ <@:{ ])"0 _ txt
end.
z
)

ffmatches=: 2&{.@{."2 @ rxmatches_jregex_

