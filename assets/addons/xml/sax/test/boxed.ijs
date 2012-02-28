NB. using elements or attributes to fill boxed table
NB. http://www.jsoftware.com/pipermail/programming/2008-December/013300.html

require 'xml/sax format'

saxclass 'pboxed'

startDocument=: 3 : 0
  S=: ''
  HREF=: ''
  Z=: i.0 2
)
endDocument=: 3 : 'Z' 

startElement=: 4 : 0
  S=: S,<y
  if. y-:'bookmark' do.
      HREF=: x getAttribute 'href' end.
)

endElement=: 3 : 0
  S=: }:S
)

characters=: 3 : 0
  s2=. _2{.S
  if. s2 -: ;:'bookmark title' do. Z=: Z,y;HREF end.
)

NB. =========================================================
cocurrent 'base'

TEST3=: 0 : 0
<?xml version="1.0"?>
<!DOCTYPE xbel PUBLIC "+//IDN python.org//DTD XML Bookmark Exchange Language 1.1//EN//XML" "http://pyxml.sourceforge.net/topics/dtds/xbel-1.1.dtd">
<xbel>
  <title>Bookmarks</title>
  <desc>Bookmarks</desc>
  <folder id="rdf:#$FvPhC3" folded="no">
    <title>Bookmarks Toolbar Folder</title>
    <desc>Add bookmarks to this folder to see them displayed on the Bookmarks Toolbar
    </desc>
    <bookmark href="http://www.mozilla.com/products/firefox/central.html">
      <title>Getting Started</title>
    </bookmark>
    <bookmark href="http://fxfeeds.mozilla.com/" modified="1209052290">
      <title>Latest Headlines</title>
    </bookmark>
  </folder>
    <bookmark href="http://www.jsoftware.com/" added="1146880810" visited="1209017433">
      <title>J Home</title>
    </bookmark>
    <bookmark href="http://www.vector.org.uk/" added="1160402450" visited="1208656644">
      <title>Vector Online | Vector - the array languages</title>
    <desc>The Journal of the British APL Association
    </desc>
    </bookmark>
    <bookmark href="http://www.jsoftware.com/forumsearch" added="1159366136" visited="1207757057">
      <title>Forum Search</title>
    </bookmark>
    <bookmark href="http://www.ubuntu.com/" added="1208996707" visited="1209047897">
      <title>Ubuntu Home Page | Ubuntu</title>
    </bookmark>
</xbel>
)

0 : 0  NB. Test
process_pboxed_ TEST3
)
