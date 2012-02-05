NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/zgerqf.ijs' by 'addons/math/lapack/gerqf.ijs'
NB. - replace strings 'zgerqf' by '(2b1110 & gerqf)', 'zgerqfQ' by 'gerqf', 'tzgerqf' by 'tgerqf', 'testzgerqf' by 'testgerqf'

require '~addons/math/lapack/gerqf.ijs'

coclass 'jlapack'

zgerqf=: 2b1110 & gerqf
zgerqfQ=: gerqf
tzgerqf=: tgerqf
testzgerqf=: testgerqf
