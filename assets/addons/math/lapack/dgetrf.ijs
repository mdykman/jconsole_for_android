NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/dgetrf.ijs' by 'addons/math/lapack/getrf.ijs'
NB. - replace strings 'dgetrf' by 'getrf', 'tdgetrf' by 'tgetrf', 'testdgetrf' by 'testgetrf'

require '~addons/math/lapack/getrf.ijs'

coclass 'jlapack'

dgetrf=: getrf
tdgetrf=: tgetrf
testdgetrf=: testgetrf
