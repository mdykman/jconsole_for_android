NB. test

cocurrent 'felidae1'

test=: 3 : 0
assert. _1 = cat_index <'cat'
assert. 1 = cat_index <'lion'
assert. 0 = #this_cat _1
assert. 3 = #this_cat 0
assert. 0 = #this_cat #db_name
assert. 0 = #next_cat'' [ current_cat=: _1
assert. 0 = #next_cat'' [ current_cat=: <:#db_name
assert. 1 = >@{. next_cat'' [ current_cat=: 0
assert. 2 = >@{. next_cat'' [ current_cat=: 1
assert. 0 = #previous_cat'' [ current_cat=: _1
assert. 0 = #previous_cat'' [ current_cat=: 0
assert. (<:<:#db_name) = >@{. previous_cat'' [ current_cat=: <:#db_name
smoutput 'success'
EMPTY
)

test ''

cocurrent 'base'
