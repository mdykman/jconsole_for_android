NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/zgesv.ijs' by 'addons/math/lapack/gesv.ijs'
NB. - replace strings 'zgesv' by 'zesv', 'tzgesv' by 'tgesv', 'testzgesv' by 'testgesv'

require '~addons/math/lapack/gesv.ijs'

coclass 'jlapack'

zgesv=: gesv
tzgesv=: tgesv
testzgesv=: testgesv
