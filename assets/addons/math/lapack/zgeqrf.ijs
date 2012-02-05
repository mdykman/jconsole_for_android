NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/zgeqrf.ijs' by 'addons/math/lapack/geqrf.ijs'
NB. - replace strings 'zgeqrf' by '(2b0111 & geqrf)', 'zgeqrfQ' by 'geqrf', 'tzgeqrf' by 'tgeqrf', 'testzgeqrf' by 'testgeqrf'

require '~addons/math/lapack/geqrf.ijs'

coclass 'jlapack'

zgeqrf=: 2b0111 & geqrf
zgeqrfQ=: geqrf
tzgeqrf=: tgeqrf
testzgeqrf=: testgeqrf
