before_all=: 3 : 0
  require'files'
)

test_add=: 3 : 0
  assert 4 = 2+2
)

test_fexist=: 3 : 0
  assert fexist jpath'~help/index1.htm'
)

ex1_expect=: 'domain error'
test_ex1=: 3 : 0
  2+'2'
)

ig2_ignore=: 1
test_ig2=: 3 : 0
  2+2
)
