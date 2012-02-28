NB. using element character content
NB. selective processing based on element hierarchy position
NB. 06/06/06 Oleg Kobchenko - added jwiki rss

require 'xml/sax format'

saxclass 'prss'
cl=: <;._2

startDocument=: 3 : 0
  S=: ''
  HOST=: ''
)

startElement=: 4 : 0
  S=: S,<y
  if. y-:'item' do. smoutput '' end.
  s2=. _2{.S
  if. s2-:cl'dc:contributor rdf:Description ' do. 
      HOST=: x getAttribute 'wiki:host' end.
)

endElement=: 3 : 0
  S=: }:S
)

characters=: 3 : 0
  s2=. _2{.S
  if. s2-:;:'channel title'       do. smoutput 'Channel: ',y elseif.
      s2-:;:'channel description' do. smoutput fold y elseif.
      s2-:;:'channel pubDate'     do. smoutput 'Date: ',y elseif.
      s2-:;:'item title'          do. smoutput 'Topic: ',y elseif.
      s2-:;:'item description'    do. smoutput fold y elseif.
      s2-:;:'item link'           do. smoutput 'URL: ',y elseif.
      s2-:cl'item dc:date '       do. smoutput 'Date: ',y end.
  s3=. _3{.S
  if. s3-:cl'dc:contributor rdf:Description rdf:value ' do. 
      smoutput 'Contributor: ',y,' at ',HOST end.
)

NB. =========================================================
cocurrent 'base'

TEST3=: 0 : 0
<channel><title>qq</title><pubDate>1/1/2006</pubDate></channel>
)

0 : 0  NB. Test
process_prss_ TEST3
process_prss_ fread jpath '~addons/xml/sax/test/cnn.rss'
process_prss_ fread jpath '~addons/xml/sax/test/jwiki1.rss'
)
