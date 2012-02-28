NB. declarative XML to J transformer
NB. convert XML document to J structures

require 'xml/sax/x2j'

x2jclass 'px2j1'

'/' x2jElm (3 : 0)    NB. document root (start/end Document)
  root
:
  root=: 0 0$0        NB. a table
)

'row' x2jElm (3 : 0)
  root=: root,row     NB. append to table
:
  row=: ''            NB. a list
)

'row/item' x2jElm (3 : 0)
                      NB. append boxed pair to list
  row=: row,<('name';name),:'value';value
:
  name=: ''
  value=: ''          NB. default to empty
)

'row/item/name'  x2jChar (3 : 'name=: y')
'row/item/value' x2jChar (3 : 'value=: y')

NB. =========================================================
cocurrent 'base'

TESTX2J1=: 0 : 0
<table>
  <row>
    <item><name>Item 1.1</name><value>12.3</value></item>
    <item><name>Item 1.2</name><value>45.6</value></item>
  </row>
  <row>
    <item><name>Item 2.1</name><value>78.9</value></item>
    <item><name>Item 2.2</name><value>67.8</value></item>
  </row>
</table>
)

0 : 0  NB. Test
process_px2j1_ TESTX2J1
)
