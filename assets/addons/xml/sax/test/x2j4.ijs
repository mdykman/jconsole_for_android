NB. declarative XML to J transformer
NB. elements and attributes using compact definition

require 'xml/sax/x2j'

x2jclass 'px2j4'

'Items' x2jDefn
  /              :=  table                   : table=: ,:'href';'title';'add';'mod';'visit'
  bookmark       :=  table=: table,h;t;a;m;v : 'h a m v'=: atr'href added modified visited'
  bookmark/title :=  t=: y
)

NB. =========================================================
cocurrent 'base'

TESTX2J4=: 0 : 0
<xbel>
  <title>Bookmarks</title>
  <desc>Bookmarks</desc>
  <folder id="rdf:#$FvPhC3" folded="no">
    <bookmark href="http://www.mozilla.com/products/firefox/central.html">
      <title>Getting Started</title>
    </bookmark>
    <bookmark href="http://fxfeeds.mozilla.com/" modified="1209052290">
      <title>Latest Headlines</title>
    </bookmark>
  </folder>
    <bookmark href="http://www.jsoftware.com/forumsearch" added="1159366136" visited="1207757057">
      <title>Forum Search</title>
    </bookmark>
    <bookmark href="http://www.ubuntu.com/" added="1208996707" visited="1209047897">
      <title>Ubuntu Home Page | Ubuntu</title>
    </bookmark>
</xbel>
)

0 : 0  NB. Test
process_px2j4_ TESTX2J4
)
