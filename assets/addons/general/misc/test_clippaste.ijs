NB. ========================================================
NB. Test script for clippaste.ijs

load '~addons/general/misc/clippaste.ijs'

t0=:''
t1=:'a'
t1u=: 1 1$<,t1
tv=:'This is a test.'
tvu=: 1 1$<,tv
tm=:3# ,:tv
tmu=:3 1$<"1 tm
tem=:<"1 tm
temu=:1 3$tem
tfu=: ,<7 u: 68 58 92 82 92 230 178 146 230 156 137 229 149 143 233 161 140{a.
tf4=:'c:\this';'c:\is';'c:\a';'c:\tst'

test=: 3 : 0
assert 0~:setcliptext t0
assert t0-:getclip''
assert t0-:getcliptext''
assert 0-:getclipfiles''
assert 0~: setcliptext t1
assert t1u-:clipunfmt getclip''
assert t1u-:clipunfmt getcliptext''
assert 0-:getclipfiles''
assert 0~:setcliptext tv
assert tvu-:clipunfmt getclip''
assert tvu-:clipunfmt getcliptext''
assert 0-:getclipfiles''
assert 0~:setcliptext tm
assert tmu-:clipunfmt getclip''
assert tmu-:clipunfmt getcliptext''
assert 0-:getclipfiles''
assert 0~:setcliptext tem
assert temu-:clipunfmt getclip''
assert temu-:clipunfmt getcliptext''
assert 0-:getclipfiles''
assert 0~:setclipfiles tfu
assert tfu-:getclipfiles''
assert tfu-:getclip''
assert 0=getcliptext''
assert 0~:setclipfiles tf4
assert tf4-:getclipfiles''
assert tf4-:getclip''
assert 0=getcliptext''
)


