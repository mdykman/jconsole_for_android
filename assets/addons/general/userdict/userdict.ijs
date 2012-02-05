coclass 'juserdict'

tagtags=: ''

NB. =========================================================
loadtags=: 3 : 0
tagtags=: ''
if. 0~:nc <'UserDict_j_' do. return. end.
if. #UserDict_j_ do. parsetags"0 jpath&.> boxopen UserDict_j_ end.
)

NB. parsetags  parse tags as segmented string for memory efficiency
NB. =========================================================
parsetags=: 3 : 0
a=. freads y
if. 2>#a do. EMPTY return. end.
tag=. ; <@(,&({.a.));._2 toJ a
if. 0=#tag do. EMPTY return. end.
if. 0=#tagtags do. tagtags=: ,{.a. end.
tagtags=: tagtags, tag
EMPTY
)

NB. find tags

NB. =========================================================
NB. y string or boxed list of tags
NB. x (default 0)  if x=1 then include partial matches
tagtag=: 0&$: : (4 : 0)
if. 0=#y=. boxxopen y do. 0$0 return. end.
if. 0=#tagtags do. loadtags'' end.
if. 0=#tagtags do. 0$0 return. end.
res=. 0$0
for_t. y do.
  if. 1 -.@e. r=. (({.a.),(>t),(0=x)#{.a.) E. tagtags do. continue. end.
  res=. res, (I.tagtags={.a.) i. I.r
end.
~.res
)

NB. tag name from index
tagtagname=: 3 : 0
'a b'=. (y+i.2){r=. I.tagtags={.a.
(}.a+i.b-a){tagtags
)

NB. tagcp   tag completion
NB. return boxed list of partial matches
NB. =========================================================
tagcp=: 3 : 0
if. 0=#n=. 1 tagtag y do. 0$<'' return. end.
/:~ ~. <@tagtagname"0 n
)

NB. export to z locale
usertagcp_z_=: tagcp_juserdict_
