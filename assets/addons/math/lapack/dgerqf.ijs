NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/dgerqf.ijs' by 'addons/math/lapack/gerqf.ijs'
NB. - replace strings 'dgerqf' by '(2b1110 & gerqf)', 'dgerqfQ' by 'gerqf', 'tdgerqf' by 'tgerqf', 'testdgerqf' by 'testgerqf'

require '~addons/math/lapack/gerqf.ijs'

coclass 'jlapack'

dgerqf=: 2b1110 & gerqf
dgerqfQ=: gerqf
tdgerqf=: tgerqf
testdgerqf=: testgerqf
