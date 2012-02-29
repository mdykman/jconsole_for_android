NB. Tests for directory utils

Note 'To run all tests:'
 load 'general/dirutils'
 load 'general/dirutils/test/test_dirutils'
)

BDIR=: <'~temp'
PARENTS=: '/dad';'/mum'
CHILDS=: '/dad/son';'/mum/daughter'
GCHILDS=: '/gdson';'/gddaughter'
DIRS=: BDIR, each PARENTS,CHILDS
n=: #DIRS=: jpath each DIRS

test=: 3 : 0
  'directorie(s) exist already' assert 0=+/ direxist DIRS
  'dir(s) not created' assert n=+/ dircreate DIRS
  'directorie(s) don''t exist' assert n=+/ direxist DIRS
  ]>dirpath@jpath"1 >BDIR, each PARENTS
  ferase |. DIRS
  'directorie(s) still exist' assert 0=+/ direxist DIRS
  ]PATHS=: BDIR ,each ,each/CHILDS,:GCHILDS
  np=. #PATHS=: jpath each PATHS
  nd=. +/;pathcreate each PATHS
  'dir(s) not created' assert np<nd
  ]>DIRS=: dirpath@jpath"1 >BDIR, each PARENTS
  nd2=. +/ferase |. ,DIRS
  'no. dirs erased not same as no. created' assert nd=nd2
  'directorie(s) still exist' assert 0=+/direxist ,DIRS
  
  'test_dirutils passed'
)

smoutput test''
