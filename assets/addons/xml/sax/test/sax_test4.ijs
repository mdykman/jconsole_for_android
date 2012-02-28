NB. object oriented sax parser specialization
NB. extract text of specific elements

require 'xml/sax'

saxclass 'psax4'

TAG=: 'test'

startDocument=: 3 : 'PATH=: R=: $0'
endDocument=:   3 : 'R'
startElement=:  4 : 'PATH=: PATH,<y'
endElement=:    3 : 'PATH=: }:PATH'
characters=:    3 : 'if. TAG -: >@{: PATH do. R=: R,<y end.'


NB. =========================================================
cocurrent 'base'

TEST4=: 0 : 0
<body><test>s123</test><test>zz</test><q>z456</q><test>s456</test></body>
)

0 : 0  NB. Test
process_psax4_ TEST4
    TAG_psax4_=: 'td'
process_psax4_ fread jpath '~addons/xml/sax/test/table.xml'
)
