NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/ztrtrs.ijs' by 'addons/math/lapack/trtrs.ijs'
NB. - replace string 'ztrtrs' by 'trtrs', 'tztrtrs' by 'ttrtrs', 'testztrtrs' by 'testtrtrs', 

require '~addons/math/lapack/trtrs.ijs'

coclass 'jlapack'

ztrtrs=: trtrs
tztrtrs=: ttrtrs
testztrtrs=: testtrtrs
