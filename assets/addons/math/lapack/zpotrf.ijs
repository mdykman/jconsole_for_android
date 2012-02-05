NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/zpotrf.ijs' by 'addons/math/lapack/potrf.ijs'
NB. - replace string 'zpotrf' by 'potrf', 'tzpotrf' by 'tpotrf', 'testzpotrf' by 'testpotrf', 

require '~addons/math/lapack/potrf.ijs'

coclass 'jlapack'

zpotrf=: potrf
tzpotrf=: tpotrf
testzpotrf=: testpotrf
