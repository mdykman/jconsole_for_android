NB. test tables/dsv addon

Note 'To run all tests:'
  load 'tables/dsv'
  load 'tables/dsv/test/test_dsv'
)

NB. =========================================================
NB. create nouns for testing

NB. simple numeric
d=: 4 5?.@$ 200
d1=: <"0 d

NB. All literal
a=: 0 : 0
"15","Es","45","1.231","75"
"90","Rs are dumb","","3.443","150"
"165","MTe","195","23354.398","225"
)

a2=: 0 : 0
15,Es,45,1.231,75
90,Rs are dumb,,3.443,150
165,MTe,195,23354.398,225
)

a3=: 0 : 0
"15"BiB"Es"BiB"45"BiB"1.231"BiB"75"
"90"BiB"Rs are dumb"BiB""BiB"3.443"BiB"150"
"165"BiB"MTe"BiB"195"BiB"23354.398"BiB"225"
)

a4=: 0 : 0
"15""Es""45""1.231""75"
"90""Rs are dumb""""3.443""150"
"165""MTe""195""23354.398""225"
)

a5=: 0 : 0
15Es451.23175
90Rs are dumb3.443150
165MTe19523354.398225
)

aa1=: ' ,one,  ''two,   ''''three'''',four'','''',''Ron''''s Stuff'','
aa2=: (,' ');'one';'  two,   ''three'',four';'';'Ron''s Stuff';''

NB. columns of same type & empty fields
p=. ,: 15;'Es';45;1.231;75
p=. p, 90;'Rs are dumb';'';3.443;150
a1=: p, 165;'MTe';195;23354.398;225

NB. columns of mixed type
b=: 0 : 0
1,"The big, black dog",R,3.221,Lolly,6,7
8,"likes to",W,3.400,A,13,14
15,eat,T,,,20,21
22,"juicy, 'red' bones",I,91991.300,CAT,27,28
)

NB.
b1=: 0 : 0
"1","The big, black dog","R","3.221","Lolly","6","7"
"8","likes to","W","3.400","A","13","14"
"15","eat","T","","","20","21"
"22","juicy, 'red' bones","I","91991.300","CAT","27","28"
)

NB. string delimiter within fields
p=. ,: 1 ;'The "big, black" dog';'R';3.221;'Lolly';6;7
p=. p, 8 ;'likes to';'W';3.400;'A';13;14
p=. p, 15;'eat';'T';'';'';20;21
b2=: p, 22;'juicy, ''red'' bones';'I';91991.300;'CAT';27;28

NB. rational, complex and boxed datatypes
p=. ,: 1;'The big, black dog';'R';3.221;'Lolly';'M';7
p=. p, 8;'';'W';(<3 4 3.3);'A';13;14
p=. p, 4r5;'eat';'T';'';39.3;20;21
c1=: p, 3j4;'juicy, ''red'' bones';'I';91991.3;'CAT';27;28

c2=: ((<<"0 i.3 2),(<3j4 2j6),< i.2 3) (1 0;3 0;1 1)}c1

NB. unicode
p=. <4 u: 27794 26377 21839 38988
p=. p,< 4 u: 215 + i.10
p=. p,< 4 u: 920 + i. 7
e1=: 3 4$p

t1=: jpath '~temp/eraseme1.pls'

ferase t1

NB. =========================================================
NB. verb for testing
test=: 3 : 0
  assert. ''-: joindsv ''
  assert. ''-: delimitarray ''
  assert. ''-: chopstring ''
  assert. ('"a"')-: delimitarray <'a'
  assert. ('a,b,c',LF,'d,a,b',LF)-: ',' delimitarray <"0 ]2 3$'abcd'
  assert. aa2 -: (',';'''') chopstring aa1
  assert. aa2 -: (',';'''') chopstring (',';'''') delimitarray aa2
  assert. (,'4')-:delimitarray <4
  assert. ('4',LF)-:makedsv <4
  assert. 3 5 -: $ (',';'""') fixdsv a
  assert. 4 7 -: $ (',';'""') fixdsv b
  assert. ((',';'""')fixdsv a)-:fixdsv delimitarray a1
  assert. a2-: ',' delimitarray (',';'""') fixdsv a
  assert. a3-: ('BiB';'"') makedsv (',';'""') fixdsv a
  assert. a4-: ('';'"') makedsv (',';'""') fixdsv a
  assert. a5-: ('';'') makedsv (',';'"') fixdsv a
  assert. (8!:0 a1)-:('|';'"')fixdsv '|' makedsv ',' fixdsv a
  assert. b1-:(',';'""') delimitarray (',';'""')fixdsv b
  assert. ((',';'""') fixdsv b)-: fixdsv delimitarray (',';'""') fixdsv b
  assert. -. (delimitarray fixdsv b)-: ';' delimitarray fixdsv b
  assert. ((',';'""') fixdsv b)-: (';';'""') fixdsv ';' delimitarray (',';'""') fixdsv b
  assert. (8!:0 b2)-: fixdsv delimitarray b2
  assert. 8 3 -: $ fixdsv delimitarray 2 4 3$,b2
  nempty=. +/0=,#&> b2
  nwrongtype=. +/0=,(3!:0 each b2) = 3!:0 each makenum fixdsv delimitarray b2
  assert. nempty=nwrongtype NB. empty cells change type but not problem
  assert. d -: 0".> fixdsv delimitarray <"0 d
  assert. (delimitarray d1) -: delimitarray <"0 d
  assert. d -: makenum fixdsv delimitarray d1
  assert. 151= #delimitarray c1
  assert. 174= #delimitarray c2
  assert. 4 7 -: $(';';'<>') fixdsv (';';'<>') delimitarray c2
  assert. e1-: (';';'<>') fixdsv (';';'<>') delimitarray e1
  a1 writedsv t1
  assert. 1=fexist t1
  assert. (readdsv t1) -: (',';'""') fixdsv a
  d appenddsv t1
  assert. 7 5 -: $readdsv t1
  assert. (readdsv t1) -: ((',';'""') fixdsv a), 8!:0 d
  d writedsv t1;'|'
  assert. (freads t1) -: '|' makedsv d
  assert. ('|' readdsv t1) -: fixdsv makedsv d
  b2 writedsv t1;'|';'<>'
  assert. (freads t1) -: ('|';'<>') makedsv b2
  assert. (('|';'<>') readdsv t1) -: fixdsv makedsv b2
  
  assert. 1 = ferase t1
  
  'test_dsv passed'
)

smoutput test''
