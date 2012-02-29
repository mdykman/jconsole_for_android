NB. Tests for ziptrees
NB. To run all tests, select all file contents and choose Run|Selection

Note 'To run all tests:'
 load 'arc/ziptrees'
 load 'arc/ziptrees/test/test_ziptrees'
)

SRCDIR=: jpath '~tools'
TRGZIP=: jpath '~temp/toolstree.zip'
TRGDIR=: jpath '~temp/testziptrees'
isMatch=: 'no difference' -: _1 {:: [: <;._2 LF ,~ ]

test=: 3 : 0
'zip file already exists' assert -. fexist TRGZIP
TRGZIP ziptree SRCDIR  NB. zip directory tree
'directory already exists' assert -. direxist TRGDIR
TRGDIR unziptree TRGZIP NB. unzip of zipped directory tree

'Trees are not the same' assert isMatch 1 0 dircompare SRCDIR;TRGDIR

NB. clean up
'zip not erased' assert ferase TRGZIP
'file(s) not erased' assert ferase {."1 dirtree TRGDIR
'dir(s) not erased'  assert ferase |.dirpath TRGDIR
'directory still exists' assert -. direxist TRGDIR

'test_ziptrees passed'
)

smoutput test''
