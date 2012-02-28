NB. Test tara

Note 'To run all tests:'
  load 'tables/tara'
  load 'tables/tara/test/taratest'
)

cocurrent 'base'

test1=: 3 : 0
bi=. '' conew 'biffbook'               NB. create an workbook
writestring__bi 1 3 ; 'hello world'    NB. write text in a cell: rowcol ; text (rowcol is 0-based)
writestring__bi 'C4' ; 'hello Tara'    NB. cell in "A1" mode
save__bi jpath '~temp/tara1.xls'       NB. save to a file
assert. destroy__bi ''                 NB. destriy workbook object, NOT the Excel file
assert. fexist jpath '~temp/tara1.xls'
 'test1 passed'
)

NB. Row Height and Column Width
test2=: 3 : 0
bi=. '' conew 'biffbook'
l=. 0{sheet__bi              NB. worksheet object
defaultcolwidth__l=. 5       NB. number of characters of first predefined font
NB. set default row height
defaultrowheight__l=. 400    NB. twip
NB. set individual column width
NB. y is firstcol lastcol width(in 1/256 character)
addcolinfo__bi 2 6, 256*10
NB. set individual row height
NB. y is rownumber firstcol lastcol+1 usedefaultheight rowheight(in twip) heightnotmatch ...
addrowinfo__bi 1 0 256 0 1000 1
writestring__bi 1 3 ; 'hello world'
writenumber__bi 'C3' ; o.1
save__bi jpath '~temp/tara2.xls'
assert. destroy__bi ''
assert. fexist jpath '~temp/tara2.xls'
 'test2 passed'
)

NB. Default Font
test3=: 3 : 0
bi=. ('Arial' ; 300) conew 'biffbook'   NB. 15 point
writestring__bi 1 3 ; 'hello world'     NB. row col text
writenumber__bi 2 4 ; o.1               NB. row col number
writestring__bi 3 2 ; ":o.1
save__bi jpath '~temp/tara3.xls'
assert. destroy__bi ''
assert. fexist jpath '~temp/tara3.xls'
 'test3 passed'
)

NB. xf object
test4=: 3 : 0
bi=. ('Courier New' ; 220) conew 'biffbook'  NB. default font
xf=. cxf__bi         NB. current workbook xf object
NB. font
fontname__xf=. 'Lucida Console'  NB. no need to use double quotes (")
fontheight__xf=. 300  NB. twip
fontweight__xf=. 700  NB. 400 normal, 700 bold
fontitalic__xf=. 1    NB. italic
writestring__bi 1 3 ; 'hello world'
NB. font color
fontweight__xf=. 400  NB. 400 normal, 700 bold
fontitalic__xf=. 0
fontcolor__xf=. rgbcolor__bi 0 0 255  NB. blue
writestring__bi 2 4 ; 'hello color'
NB. background color
patterncolor__xf=. rgbcolor__bi 3#16bcc  NB. gray
pattern__xf=. 1                          NB. solid background
writestring__bi 2 2 ; 'background'
save__bi jpath '~temp/tara4.xls'
assert. destroy__bi ''
assert. fexist jpath '~temp/tara4.xls'
 'test4 passed'
)

NB. Number and Date Format
test5=: 3 : 0
bi=. ('Courier New' ; 220) conew 'biffbook'
xf=. cxf__bi                     NB. current workbook xf object
addcolinfo__bi 2 6, 256*12
writenumber__bi 1 3 ; 1234.56
format__xf=. '#,##0.00'          NB. format string
writenumber__bi 2 3 ; 1234.56
format__xf=. '0.00'
writenumber__bi 3 3 ; 1234
NB. subtract 36522 to give Excel date, year 1900 bug ignored
format__xf=. 'dd/mm/yyyy'
writenumber__bi 4 3 ; 74699-36522
NB. another verb for date
writedate__bi 5 3 ; 74699 ; 'd/m/yy'
save__bi jpath '~temp/tara5.xls'
assert. destroy__bi ''
assert. fexist jpath '~temp/tara5.xls'
 'test5 passed'
)

NB. Alignment and Cell Border
test6=: 3 : 0
bi=. ('Courier New' ; 220) conew 'biffbook'
xf=. cxf__bi            NB. current workbook xf object
xf1=. addxfobj__bi xf   NB. clone xf for later use
addcolinfo__bi 0 3, 256*12
horzalign__xf=. 1       NB. 0 general  1 left  2 center 3 left
writestring__bi 0 1 ; 'hello world'
horzalign__xf=. 2
writestring__bi 1 1 ; 'center'
horzalign__xf=. 3
writestring__bi 2 1 ; 'right'
xf1 writestring__bi 2 3 ; 'xf1'   NB. xf1 object as left argument
fontheight__xf=. 300  NB. twip
horzalign__xf=. 2
vertalign__xf=. 1  NB. 0 top  1 center  2 bottom
writestring__bi 3 2 ; 'merge 1'
vertalign__xf=. 2
writestring__bi 4 0 ; 'merge 2'
fontheight__xf=. 220  NB. twip
fontcolor__xf=. rgbcolor__bi 0 0 255  NB. blue
NB. text alignment
horzalign__xf=. 0  NB. general
vertalign__xf=. 2  NB. bottom
NB. cell border
leftlinestyle__xf=. cellborder_thin_biff_
rightlinestyle__xf=. cellborder_medium_biff_
toplinestyle__xf=. cellborder_no_line_biff_
bottomlinestyle__xf=. cellborder_double_biff_
writestring__bi 6 3 ; 'box style'
l=. 0{sheet__bi           NB. worksheet object
mergedcell__l=. 2 4 $ 3 4 2 4 4 5 0 1  NB. 2 sets of merge cells, ( row1 row2 col1 col2)
save__bi jpath '~temp/tara6.xls'
assert. destroy__bi ''
assert. fexist jpath '~temp/tara6.xls'
 'test6 passed'
)

NB. Page Setup
test7=: 3 : 0
bi=. ('Courier New' ; 220) conew 'biffbook'
writestring__bi 0 1 ; 'madam'
writestring__bi 1 2 ; 'i''m'
writestring__bi 2 3 ; 'adam'
writestring__bi 7 3 ; 'please print preview me'
writestring__bi 70 3 ; 'second page'
l=. 0{sheet__bi           NB. worksheet object
leftmargin__l=. 0.67        NB. inch
rightmargin__l=. 0.6299
topmargin__l=. 1.5748
bottommargin__l=. 0.8267
header__l=. 'tara demo'
footer__l=. 'Page &P of &N &F &D'   NB. Page 2 of 10 filename date, other commands see section 6.51
_1 rowrepeat__bi 0 0 2  NB. repeat sheet(0) row 0 to row 2
save__bi jpath '~temp/tara7.xls'
assert. destroy__bi ''
assert. fexist jpath '~temp/tara7.xls'
 'test7 passed'
)

NB. Adding New Worksheet
test8=: 3 : 0
bi=. ('Courier New' ; 220 ; 'first worksheet') conew 'biffbook'  NB. name of first worksheet as the third parameter
writestring__bi 1 3 ; 'total 3 worksheets'
addsheet__bi ''
writestring__bi 1 3 ; 'sheet2'
addsheet__bi 'last sheet'                NB. name of worksheet
writestring__bi 1 3 ; 'last sheet'
NB. switch to sheet1, (sheeti is 0-based)
sheeti__bi=. 0
writestring__bi 2 3 ; 'sheet1'
save__bi jpath '~temp/tara8.xls'
assert. destroy__bi ''
assert. fexist jpath '~temp/tara8.xls'
 'test8 passed'
)

NB. large workbook > 10MB size
test9=: 3 : 0
bi=. ('Courier New' ; 220) conew 'biffbook'
writenumber__bi 0 0 ; i.6000 100
writestring__bi 6000 0 ; < < ("1) 6000 100 7$'ABCDEFGHIJKLMNOPQRSTUVW'
save__bi jpath '~temp/tara9.xls'
assert. destroy__bi ''
assert. fexist jpath '~temp/tara9.xls'
 'test9 passed'
)

NB. Picture
test10=: 3 : 0
bi=. ('Courier New' ; 220) conew 'biffbook'
writestring__bi 0 0 ; 'my picture'
'my comment' writecomment__bi 0 0     NB. comment (note)
(0  4 ; 0  0 ; 1  1) insertimage__bi <jpath '~addons/tables/tara/test/dora.png'  NB. row 0 col 4 scalex 1 scaley 1
(4  0 ; 0  0 ; 2  2) insertimage__bi 1!:1 <jpath '~addons/tables/tara/test/dora.png'  NB. also accepts unboxed raw data
save__bi jpath '~temp/tara10.xls'
assert. destroy__bi ''
assert. fexist jpath '~temp/tara10.xls'
 'test10 passed'
)

NB. Return Excel File as Noun
test11=: 3 : 0
bi=. ('Courier New' ; 220) conew 'biffbook'
writestring__bi 1 3 ; 'hello world'
rc=. save__bi ''
assert. destroy__bi ''
assert. 3584=$rc
assert. 224 16= $ _16]\ a.i. rc
 'test11 passed'
)

smoutput test1''
smoutput test2''
smoutput test3''
smoutput test4''
smoutput test5''
smoutput test6''
smoutput test7''
smoutput test8''
smoutput test9''
smoutput test10''
smoutput test11''
