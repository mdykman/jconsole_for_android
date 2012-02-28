NB. zip addon test - Select all. Press Ctrl+E

load '~addons/arc/zip/zfiles.ijs'

ADDONDIR=. jpath '~addons/arc/zip'
DIR=. jpath '~temp'
ferase DIR&, &.> '/arcziptest.zip';'/arcziptest1.zip'

(DIR,'/arcziptest.zip') fcopynew ADDONDIR,'/test/test.zip'

fexist DIR,'/arcziptest.zip'
zdir DIR,'/arcziptest.zip'
zdir '*.txt';DIR,'/arcziptest.zip'

zsize 'test2.txt';DIR,'/arcziptest.zip'
zexist 'other/test3.txt';DIR,'/arcziptest.zip'
zinfo 'other/';DIR,'/arcziptest.zip'
ztype 'other/';DIR,'/arcziptest.zip'

zread 'test2.txt';DIR,'/arcziptest.zip'
#zread 'test2.txt';DIR,'/arcziptest.zip'

'one' zwrite 'test1.txt';DIR,'/arcziptest1.zip'
'two123' zwrite 'test2.txt';DIR,'/arcziptest1.zip'
zdir DIR,'/arcziptest1.zip'

32{. F=. fread ADDONDIR,'/zfiles.ijs'
F zwrite 'test1.ijs';DIR,'/arcziptest1.zip'

'' zwrite 'folder/';DIR,'/arcziptest1.zip'
'three' zwrite 'folder/test3.txt';DIR,'/arcziptest1.zip'
zdir DIR,'/arcziptest1.zip'
32{.zread 'test1.ijs';DIR,'/arcziptest1.zip'

zgetcomment DIR,'/arcziptest1.zip'
'test123'zsetcomment DIR,'/arcziptest1.zip'
zgetcomment DIR,'/arcziptest1.zip'
ferase DIR,'/arcziptest1.zip'

zread 'test1.ijs';DIR,'/arcziptest.zip'
zscript 'test1.ijs';DIR,'/arcziptest.zip'
names''
TEST

zinfo 'other';DIR,'/arcziptest.zip'     NB. empty result
0=#zinfo 'other';DIR,'/arcziptest.zip'
ZERR_zfiles_
zsize 'bogus';DIR,'/arcziptest.zip'
zread 'bogus';DIR,'/arcziptest.zip'
NB. zscript 'bogus';DIR,'/bogus.zip'
