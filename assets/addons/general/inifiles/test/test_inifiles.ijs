NB. Tests for inifiles

Note 'To run all tests:'
  load 'general/inifiles'
  load 'general/inifiles/test/test_inifiles'
)

loc=. 3 : '> (4!:4 <''y'') { 4!:3 $0'
PATH=. getpath_j_ jpath loc''

INIPATH=: jpath '~temp/test.ini'
NB. copy test.ini to temp folder
INIPATH fwrites~ freads PATH,'test.ini'
'File(s) not found' assert fexist INIPATH;PATH,'test.ini'
freads INIPATH

test=: 3 : 0
  NB. replace `]` with smoutput to display results in session
  
  NB. Test1: test that parseIni and makeIni are inverse of each other
  ]ini1=. parseIni_rgsini_ freads INIPATH
  ini2=. parseIni_rgsini_ makeIni_rgsini_ ini1
  'inis do not match. Test1' assert ini1-:ini2
  
  NB. Test1a: test section names correctly parsed
  snames=. ;:'Control Formats EmptySection User'
  ]res1=. getIniSectionNames_rgsini_ INIPATH
  'section names not correctly parsed. Test1a' assert res1 -: snames
  
  NB. Test2: test different forms of ini input
  ]ini1=. getIniAllSections INIPATH
  ini2=. (freads INIPATH) getIniAllSections ''
  ini3=. (getIniAllSections INIPATH) getIniAllSections ''
  'inis do not match. Test2' assert *./ ini1&-: every ini2;<ini3
  
  NB. Test3: test different forms of ini input
  ]res1=. getIniString 'BrkAtModule';'Control';INIPATH
  res2=. (freads INIPATH) getIniString 'BrkAtModule';'Control'
  res3=. ini1 getIniString 'brkatmodule';'control' NB. names are not case sensitive
  res4=. ini1 getIniString 'BrkAtModule'           NB. section not required if keynames unique
  res5=. ini1 getIniValue 'BrkAtModule'            NB. getIniValue is same as getIniString for literal value
  'results do not match. Test3' assert *./ res1&-: every res5;res4;res2;<res3
  
  NB. Test4: Difference between getIniString and getIniValue
  ]res1=. ini1 getIniString 'Colors'
  ]res2=. ini1 getIniValue 'Colors'
  ]res3=. ini1 getIniValue 'Border'
  res4=. getIniValue 'Border';'formats';INIPATH
  ]res5=. 4+ini1 getIniValue 'Border'
  'results do not match. Test4a' assert res2 -: makeVals res1
  'results do not match. Test4b' assert res3&-: each res4;<_4+res5
  
  NB. Test5: updateIniString and get it again
  newval=. 'Fatal Attraction'
  res1=. updateIniStrings newval;'FavMovie';'User';INIPATH
  res2=. res1 getIniString 'FavMovie'
  'results do not match. Test5a' assert newval-:res2
  newval=. 155 155 155
  res1=. res1 updateIniStrings newval;'Border';'Formats'
  res2=. res1 getIniValue 'Border'
  'results do not match. Test5b' assert newval-:res2
  
  NB. Test6: writeIniString and get it again
  newval=. 'Finding Nemo'
  res1=. writeIniStrings newval;'FavMovie';'User';INIPATH
  res2=. getIniString 'FavMovie';'User';INIPATH
  'results do not match. Test6a' assert newval-:res2
  newval=. 'Black';'White';'RedAllOver'
  res1=. writeIniStrings newval;'colors';'Formats';INIPATH
  res2=. getIniValue 'Colors';'Formats';INIPATH
  'results do not match. Test6b' assert newval-:res2
  
  NB. Test7: update/writeIniString for new key and get it again
  res1=. getIniString 'FavSong';'User';INIPATH
  'results should match. Test7a' assert ''-: res1
  newval=. 'Make the Devil Mad'
  res2=. updateIniStrings newval;'FavSong';'User';INIPATH
  res3=. res2 getIniString 'FavSong';'User'
  'results should match. Test7b' assert newval-:res3
  newval=. 'Not empty now!'
  res2=. writeIniStrings newval;'Here';'EmptySection';INIPATH
  res3=. getIniString 'Here';'EmptySection';INIPATH
  'results should match. Test7c' assert newval-:res3
  
  NB. Test8: write change to new INI file
  INIPATH2=. jpath '~temp/test2.ini'
  ferase INIPATH2
  (INIPATH2,' already exists. Test6c') assert -.fexist INIPATH2
  ini1=. getIniAllSections INIPATH
  newval=. 'Pink Blue Yellow'
  res1=. ini1 writeIniStrings newval;'colors';'Formats';INIPATH2
  res2=. getIniString 'Colors';'Formats';INIPATH2
  res3=. getIniString 'Colors';'Formats';INIPATH
  'results should match. Test8a' assert newval-:res2
  'results should not match. Test8b' assert -.newval-:res3
  
  NB. Work with multiple keynames at once
  ]keys2get=. ('brkatmodule';'control'),('ColoRs';'Formats'),:'Birthdate';'User'
  ]keys2upd8=. ('Mod2';('Pink';'Blue');2006 3 3),.keys2get
  
  ini2=. updateIniStrings keys2upd8,.<INIPATH
  ini3=. ini1 updateIniStrings ('Mod2';'Pink Blue';2006 3 3),.keys2get
  'inis should match. Test9a' assert ini2-:ini3
  
  res1=. ini3 getIniStrings keys2get
  'results should match. Test 9b' assert res1-: makeString_rgsini_ each {."1 keys2upd8
  
  res2=. ini3 getIniValues keys2get
  NB.ini1 <@getIniValue"_ 1 keys2get  NB. alternative format
  NB.ini1 <@getIniValue"_ 0 {."1 keys2get
  'results should match. Test 9c' assert res2-: {."1 keys2upd8
  
  res3=. getIniValues keys2get,.<INIPATH
  'results should not match. Test 9d' assert -.res3-: {."1 keys2upd8
  res4=. writeIniStrings keys2upd8,.<INIPATH
  res5=. getIniValues keys2get,.<INIPATH
  'results should match. Test 9e' assert res5 -: {."1 keys2upd8
  
  'test_inifiles passed'
)

smoutput test''
