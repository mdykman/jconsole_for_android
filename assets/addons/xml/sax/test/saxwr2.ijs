NB. using element character content
NB. selective processing based on element hierarchy position
NB. 06/06/06 Oleg Kobchenko - added jwiki rss

require 'xml/sax xml/sax/stringWriter xml/sax/writer format'

saxclass 'psaxwr2'
coinsert 'psaxWriter'

startDocument=: 3 : 0
  IGNOREWS=: 1
  create_psaxWriter_ f. '' conew 'pstringWriter'
  startDocument_psaxWriter_ f. y
)

endDocument=: 3 : 0
  endDocument_psaxWriter_ f. y
  r=. s__wr
  destroy__wr''
  r
)

startElement=: startElement_psaxWriter_ f.
endElement=: endElement_psaxWriter_ f.
characters=: characters_psaxWriter_ f.

NB. =========================================================
cocurrent 'base'

TEST3=: 0 : 0
<channel>
  <title a="1 &quot; 2">qq&lt;<b>a&amp;</b></title>
  <pubDate><b>a</b>1/1/2006<z><q/></z></pubDate>
</channel>
)

0 : 0  NB. Test
process_psaxwr2_ TEST3
process_psaxwr2_ fread jpath '~addons/xml/sax/test/cnn.rss'
process_psaxwr2_ fread jpath '~addons/xml/sax/test/jwiki1.rss'
)
