NB. init

require 'gui/gtk'

3 : 0''
if. -.IFGTK do.
  gtkinit_jgtk_''
end.
''
)

coclass 'jwd'
coinsert 'jgtk'

defxywh=: 0 0 20 20

Cparent=: 0            NB. current form
Cchild=: 0             NB. current child
FormList=: 0 3$<0$0    NB. list of top level windows and its children
Cxywh=: defxywh

