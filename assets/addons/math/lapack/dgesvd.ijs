NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/dgesvd.ijs' by 'addons/math/lapack/gesvd.ijs'
NB. - replace strings 'dgesvd' by 'gesvd', 'tdgesvd' by 'tgesvd', 'testdgesvd' by 'testgesvd'

require '~addons/math/lapack/gesvd.ijs'

coclass 'jlapack'

dgesvd=: gesvd
tdgesvd=: tgesvd
testdgesvd=: testgesvd
