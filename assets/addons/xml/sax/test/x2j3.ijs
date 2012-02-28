NB. declarative XML to J transformer
NB. HTML table using compact definition

require 'xml/sax/x2j'

x2jclass 'px2j3'

'Items' x2jDefn
  /   :=  table             : table=: 0 0$0
  tr  :=  table=: table,row : row=: ''
  td  :=  row=: row,<y
)

NB. =========================================================
cocurrent 'base'

TESTX2J3=: 0 : 0
  <table>
    <tr>
      <td>0 0</td><td>0 1</td><td>0 2</td><td>0 3</td>
    </tr><tr>
      <td>1 0</td><td>1 1</td><td>1 2</td><td>1 3</td>
    </tr><tr>
      <td>2 0</td><td>2 1</td><td>2 2</td><td>2 3</td>
    </tr>
  </table>
)

0 : 0  NB. Test
process_px2j3_ TESTX2J3
)
