NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/dgeqrf.ijs' by 'addons/math/lapack/geqrf.ijs'
NB. - replace strings 'dgeqrf' by '(2b0111 & geqrf)', 'dgeqrfQ' by 'geqrf', 'tdgeqrf' by 'tgeqrf', 'testdgeqrf' by 'testgeqrf'

require '~addons/math/lapack/geqrf.ijs'

coclass 'jlapack'

dgeqrf=: 2b0111 & geqrf
dgeqrfQ=: geqrf
tdgeqrf=: tgeqrf
testdgeqrf=: testgeqrf
