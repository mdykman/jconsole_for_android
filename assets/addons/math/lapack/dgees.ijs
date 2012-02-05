NB. this stub will be removed in future releases
NB. please, update your sources:
NB. - replace string 'addons/math/lapack/dgees.ijs' by 'addons/math/lapack/gees.ijs'
NB. - replace strings 'dgees' by '(2b1110 & gees)', 'tdgees' by 'tgees', 'testdgees' by 'testgees'

require '~addons/math/lapack/gees.ijs'

coclass 'jlapack'

dgees=: 2b1110 & gees
tdgees=: tgees
testdgees=: testgees
