NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/zgees.ijs' by 'addons/math/lapack/gees.ijs'
NB. - replace strings 'zgees' by 'gees', 'tzgees' by 'tgees', 'testzgees' by 'testgees'

require '~addons/math/lapack/gees.ijs'

coclass 'jlapack'

zgees=: gees
tzgees=: tgees
testzgees=: testgees
