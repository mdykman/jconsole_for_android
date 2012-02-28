NB. test

cocurrent 'felidae2'

test=: 3 : 0
assert. _1 = cat_index <'cat'
assert. 1 = cat_index <'lion'
assert. 0 = #this_cat _1
assert. 4 = #this_cat 0
assert. 0 = #this_cat #db_name
assert. 0 = #next_cat'' [ current_cat=: _1
assert. 0 = #next_cat'' [ current_cat=: <:#db_name
assert. 1 = >@{. next_cat'' [ current_cat=: 0
assert. 2 = >@{. next_cat'' [ current_cat=: 1
assert. 0 = #previous_cat'' [ current_cat=: _1
assert. 0 = #previous_cat'' [ current_cat=: 0
assert. (<:<:#db_name) = >@{. previous_cat'' [ current_cat=: <:#db_name
assert. 0= delete_cat <'lion'
assert. 1= delete_cat <'lion'
assert. 0= ('lion';'panthera';1) update_cat <'lion'
smoutput 'success'
EMPTY
)

test ''

cocurrent 'base'
