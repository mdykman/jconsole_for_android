before_each=: 3 : 0
  smoutput 'before ',y
)

after_each=: 3 : 0
  smoutput 'after ',y
)

test_rplc=: 3 : 0
  require 'strings'
  assert'zz123' -: 'qq123' rplc 'qq';'zz'
)

test_bad=: 3 : 0
  require 'strings'
  assert'qq123' -: 'qq123' rplc 'qq';'zz'
)

ex2_expect=: 'value error'
test_ex2=: 3 : 0
  dummy 123
)
