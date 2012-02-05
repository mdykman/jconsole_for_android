NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/dgesv.ijs' by 'addons/math/lapack/gesv.ijs'
NB. - replace strings 'dgesv' by 'gesv', 'tdgesv' by 'tgesv', 'testdgesv' by 'testgesv'

require '~addons/math/lapack/gesv.ijs'

coclass 'jlapack'

dgesv=: gesv
tdgesv=: tgesv
testdgesv=: testgesv
