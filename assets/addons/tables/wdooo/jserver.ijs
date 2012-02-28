NB. J using vtable oleautomation

'require'~'tables/wdooo'

cocurrent 'base'

NB. J server
test=: 3 : 0
PATH=. jpath '~addons/tables/wdooo'
smoutput f1
p=: '' conew 'wdooo'
try.
  'base temp'=. olecreate__p 'JDLLServer'
NB. do
  olemethod__p base ; 'Do' ; 'a=: i.3 4'
NB. get
  a=. olevaralloc__p ''
  (VT_BSTR, VT_BYREF+VT_VARIANT) olemethod__p base ; 'Get' ; 'a' ; a
  smoutput olevalue__p a
  olevarfree__p a
NB. set
  b=. '' olesafearray__p i. 2 3
  (VT_BSTR, VT_ARRAY+VT_VARIANT) olemethod__p base ; 'Set' ; 'b' ; <<b
NB.   olevarfree__p b        NB. crash if re-run ?
NB. get
  c=. olevaralloc__p ''
  (VT_BSTR, VT_BYREF+VT_VARIANT) olemethod__p base ; 'Get' ; 'b' ; c
  smoutput ''
  smoutput olevalue__p c
  olevarfree__p c
NB. cleanup
  olemethod__p base ; 'Quit'
  (oledestroy__p ::0:) ''
  smoutput 'success'
catch.
  smoutput oleqer__p ''
end.
destroy__p ''
)

