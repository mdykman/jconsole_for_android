NB. test csv addon

Note 'To run all tests:'
  load 'tables/csv'
  load 'tables/csv/test/test_csv'
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
  assert. ''-: makecsv ''
  assert. ''-: fixcsv ''
  assert. ('"a"',LF)-: makecsv 'a'
  assert. ('"a","b","c"',LF,'"d","a","b"',LF)-: makecsv 2 3$'abcd'
  assert. ('4',LF)-:makecsv 4
  assert. 3 5 -: $ fixcsv a
  assert. 4 7 -: $ fixcsv b
  assert. (fixcsv a) -: fixcsv makecsv a1
  assert. a-: makecsv fixcsv a
  assert. (8!:0 a1)-:(',';'') fixdsv (',';'') makedsv fixcsv a
  assert. b1-: makecsv fixcsv b
  assert. (fixcsv b)-: fixcsv makecsv fixcsv b
  assert. -. (makecsv fixcsv b)-: ';' makedsv fixcsv b
  assert. (8!:0 b2)-: fixcsv makecsv b2
  assert. 8 3 -: $fixcsv makecsv 2 4 3$,b2
  nempty=. +/0=,#&> b2
  nwrongtype=. +/0=,(3!:0 each b2) = 3!:0 each makenum fixcsv makecsv b2
  assert. nempty=nwrongtype NB. empty cells change type but not problem
  assert. d -: 0".> fixcsv makecsv d
  assert. (makecsv d1) -: makecsv d
  assert. d -: makenum fixcsv makecsv d
  assert. d -: makenum fixcsv makecsv d1
  assert. 151= #makecsv c1
  assert. 174= #makecsv c2
  assert. 4 7 -: $ fixcsv makecsv c2
  assert. e1-: fixcsv makecsv e1
  a1 writecsv t1
  assert. 1=fexist t1
  assert. (readcsv t1) -: fixcsv a
  d appendcsv t1
  assert. 7 5 -: $readcsv t1
  assert. (readcsv t1) -: fixcsv a, makecsv d
  
  assert. 1 = ferase t1
  
  'test_csv passed'
)

smoutput test''