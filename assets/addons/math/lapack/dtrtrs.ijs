NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/dtrtrs.ijs' by 'addons/math/lapack/trtrs.ijs'
NB. - replace string 'dtrtrs' by 'trtrs', 'tdtrtrs' by 'ttrtrs', 'testdtrtrs' by 'testtrtrs', 

require '~addons/math/lapack/trtrs.ijs'

coclass 'jlapack'

dtrtrs=: trtrs
tdtrtrs=: ttrtrs
testdtrtrs=: testtrtrs
