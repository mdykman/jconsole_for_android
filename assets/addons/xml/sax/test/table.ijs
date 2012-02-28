NB. using element character content
NB. inter-tag and surrounding whitespace is ignored

require 'xml/sax format'

saxclass 'ptable'

endElement=: 3 : 0
  if. y-:'tr' do. TD=: '' [ TR=: TR,TD end.
)

characters=: 3 : 'TD=: TD,<y'

startDocument=: 3 : 'TR=: empty TD=: i.0 [ IGNOREWS=: 1'
endDocument=: 3 : 'TR'

NB. =========================================================
cocurrent 'base'

TEST4=: 0 : 0
<table><tr>  <td>0 0 </td>  <td> 0 1</td>  </tr>
      <tr>   <td>1 0 </td>  <td> 1 1</td>  </tr></table>
)

0 : 0  NB. Test
process_ptable_ TEST4
process_ptable_ fread jpath '~addons/xml/sax/test/table.xml'
)
