NB. declarative XML to J transformer
NB. using compact definition

require 'xml/sax/x2j'

x2jclass 'px2j2'

'Items' x2jDefn
  /              := root              : root=: 0 0$0
  row            := root=: root,row   : row=: ''
  row/item       := row=: row,<('name';name),:'value';value : name=: value=: ''
  row/item/name  := name=: y
  row/item/value := value=: y
)

NB. =========================================================
cocurrent 'base'

TESTX2J2=: 0 : 0
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
process_px2j2_ TESTX2J2
)
