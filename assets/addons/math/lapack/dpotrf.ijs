NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/dpotrf.ijs' by 'addons/math/lapack/potrf.ijs'
NB. - replace string 'dpotrf' by 'potrf', 'tdpotrf' by 'tpotrf', 'testdpotrf' by 'testpotrf', 

require '~addons/math/lapack/potrf.ijs'

coclass 'jlapack'

dpotrf=: potrf
tdpotrf=: tpotrf
testdpotrf=: testpotrf
