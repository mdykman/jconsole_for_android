NB. Excel using vtable oleautomation
NB. only works if ms office excel has been installed

require 'tables/wdooo'

cocurrent 'base'

NB. MS Office Excel
test=: 3 : 0
(1!:1 <jpath '~addons/tables/wdooo/test1.xls') 1!:2 <f1=. jpath '~temp/test1.xls'
smoutput f1
p=. '' conew 'wdooo'
try.
  'base temp'=. olecreate__p 'Excel.Application'
  oleget__p base ; 'workbooks'
  wb=. oleid__p temp
  olemethod__p wb ; 'open' ; f1
  oleget__p base ; 'activeworkbook'
  awb=. oleid__p temp
  oleget__p awb ; 'worksheets' ; 1     NB. sheet 1-base
  aws=. oleid__p temp
NB. write string into a cell
  oleget__p aws ; 'range' ; xlcell 3 10
  range=. oleid__p temp
  oleput__p range ; 'numberformat' ; '@'
  oleput__p range ; 'value2' ; 'Ms Excel'
NB. read string
  oleget__p range ; 'value2'
  smoutput olevalue__p temp
  olerelease__p range
NB. write number into a cell
  oleget__p aws ; 'range' ; xlcell 4 10
  range=. oleid__p temp
  oleput__p range ; 'value2' ; 123
  oleput__p range ; 'HorizontalAlignment' ; _4152    NB. xlRight  0xffffefc8
NB. read number
  oleget__p range ; 'value2'
  smoutput olevalue__p temp
  olerelease__p range
NB. write date into a cell
  oleget__p aws ; 'range' ; xlcell 5 10
  range=. oleid__p temp
  oleput__p range ; 'numberformat' ; 'yyyy-mmm-dd'
  oleput__p range ; 'value2' ; (-&36522) 76533        NB. 2007-2-28
NB. read date
  oleget__p range ; 'value2'
  smoutput (+&36522) olevalue__p temp
  olerelease__p range
NB. write number using safearray
  oleget__p aws ; 'range' ; (xlcell 2 12), ':', (xlcell 5 14)
  range=. oleid__p temp
  sa=. '' olesafearray__p i. 3 4
  oleput__p range ; 'value2' ; <<sa
  olevarfree__p sa
NB. read safearray
  oleget__p range ; 'value2'
  smoutput olevalue__p temp
  olerelease__p range
NB. write string using safearray
  oleget__p aws ; 'range' ; (xlcell 2 22), ':', (xlcell 5 24)
  range=. oleid__p temp
  oleput__p range ; 'numberformat' ; '@'
  sa=. '' olesafearray__p 3 4$'cat';'dog  ';'123'   NB. trailing blanks
  oleput__p range ; 'value2' ; <<sa
  olevarfree__p sa
NB. read safearray
  oleget__p range ; 'value2'
  smoutput olevalue__p temp
  olerelease__p range
  if. -.IF64 do.     NB. 64-bit oleautomation does not support safearray of variant ???
NB. write box using safearray of variant
    oleget__p aws ; 'range' ; (xlcell 2 32), ':', (xlcell 5 34)
    range=. oleid__p temp
    sa=. '' olesafearray__p 3 4$'cat';123.45;'tiger'
    oleput__p range ; 'value2' ; <<sa
    olevarfree__p sa
NB. read safearray
    oleget__p range ; 'value2'
    smoutput olevalue__p temp
    olerelease__p range
  end.
NB. save and cleanup
  (olerelease__p ::0:) aws
  VT_BOOL (oleput__p ::0:) base ; 'DisplayAlerts' ; 0
  (olemethod__p ::0:) awb ; 'save'
  (olemethod__p ::0:) awb ; 'close'
  (olerelease__p ::0:) awb
  (olerelease__p ::0:) wb
  (olemethod__p ::0:) base ; 'quit'
  VT_BOOL (oleput__p ::0:) base ; 'DisplayAlerts' ; 1
  (oledestroy__p ::0:) ''
  smoutput 'success'
catch.
  smoutput oleqer__p ''
end.
destroy__p ''
)

xlcell=: 3 : 0
'c r'=. y
c1=. <.c%26 [ c2=. 26|c
' '-.~(c1{' ABCDEFGHI'), (c2{'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), ": 1+r
)

