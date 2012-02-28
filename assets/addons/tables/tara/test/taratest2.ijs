NB. ---------------------------------------------------------
NB. Tests for writexlsheets
Note 'To run all tests:'
  load 'tables/tara'
  load 'tables/tara/test/taratest2'
)

NB. Test data
x1=: i.3 5                  NB. int array
x2=: 9 15?.@$0              NB. float array
x3=: <"0 i.12 20            NB. boxed int array
x4=: 4 2$'abcd';'kdisd';'eiij asj' NB. boxed char array
x4a=: 4 2$'abcd';'';'eiij asj' NB. boxed char array with empty
x5=: 4 2$'abcd';54;'eiij';2;4.4 NB. boxed mixed array
x6=: 'No name, single char' NB. literal
x7=: 'data 1';'data 2'      NB. boxed char vector
x8=: 5 8                    NB. int vector
x9=: <"0 ]15.6 12.9 54.33   NB. boxed flt vector
x10=: 'Int array';x1      NB. With sheetnames
x11=: 'Flt array';x2
x12=: 'Box Int array';<x3
x13=: 'Box Chr array';<x4
x14=: 'Box Mix array';<x5
x15=: '';<x1              NB. empty sheetname
x16=: ,.x2;<x3   NB. data column- flt and boxed int arrays
x16a=: ,.x1;<x1  NB. data column- 2 sheets of int arrays 
x17=: (<x9),(<x7),(<x8),(<x5),(<x1),(<x4),x16 NB. data column
x18=: x10 ,: 'Literal';x6
x19=: (x10,x11,x12,x13,x14,:x15)
x20=: (,.5#<''),(4#<''),"1 x3 NB. offset topleft corner by 5 rows and 4 cols
char=: ('per Angusta';'ad Augusta'),~;:'Lorem ipsum dolor sit consectetur'
idx=: 2 2;2 3;2 4;2 5;3 2;3 3;3 5;4 2;4 4;4 5;5 2;5 3;5 4;5 5
x21=: 'Diff Mix array';<(14$char) idx} <"0 i.8 9


fnme=: jpath '~temp/tarawsht'
suff=: '.xls'

NB.Tests
test2=: 3 : 0
  assert. x1 writexlsheets fnme,'1',suff
  assert. x2 writexlsheets fnme,'2',suff
  assert. x3 writexlsheets fnme,'3',suff
  assert. x4 writexlsheets fnme,'4',suff
  assert. x4a writexlsheets fnme,'4a',suff
  assert. x5 writexlsheets fnme,'5',suff
  assert. x6 writexlsheets fnme,'6',suff
  assert. x7 writexlsheets fnme,'7',suff
  assert. x8 writexlsheets fnme,'8',suff
  assert. x9 writexlsheets fnme,'9',suff
  assert. x10 writexlsheets fnme,'10',suff
  assert. x11 writexlsheets fnme,'11',suff
  assert. x12 writexlsheets fnme,'12',suff
  assert. x13 writexlsheets fnme,'13',suff
  assert. x14 writexlsheets fnme,'14',suff
  assert. x15 writexlsheets fnme,'15',suff
  assert. x16 writexlsheets fnme,'16',suff
  assert. x16a writexlsheets fnme,'16a',suff
  assert. x17 writexlsheets fnme,'17',suff
  assert. x18 writexlsheets fnme,'18',suff
  assert. x19 writexlsheets fnme,'19',suff
  assert. x20 writexlsheets fnme,'20',suff
  assert. x21 writexlsheets fnme,'21',suff
  
  NB.? add read tests to check correct contents written
  'taratest2 passed'
)

smoutput test2 ''
