NB. test

cocurrent 'felidae3'

test=: 3 : 0
NB. open database
locfd=: Open_jdb_ jpath '~temp'
locdb=: Open__locfd 'felidae'

assert. 0 = #this_cat <'no cat'
assert. 6 = #this_cat <'lion'
assert. 0 = #next_cat'' [ current_cat=: <'no cat'
assert. 0 = #next_cat'' [ current_cat=: <'tiger'
assert. 'lion' -: >@{. next_cat'' [ current_cat=: <'domestic cat'
assert. 'snow leopard' -: >@{. next_cat'' [ current_cat=: <'lion'
assert. 0 = #previous_cat'' [ current_cat=: <'no cat'
assert. 0 = #previous_cat'' [ current_cat=: <'docmestic cat'
assert. 'domestic cat' -: >@{. previous_cat'' [ current_cat=: <'lion'
assert. 0= delete_cat <'no cat'
assert. 0= delete_cat <'lion'
assert. 0= delete_cat <'lion'
assert. 0= ('lion';'panthera';1;'';'') update_cat <'lion'
smoutput 'success'

destroy__locdb ''
Close_jdb_ locfd
EMPTY
)

test ''

cocurrent 'base'
