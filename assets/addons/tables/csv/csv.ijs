NB. =========================================================
NB. tables/csv
NB. Read/write comma-separated value data (*.csv) files
NB. Special case of tables/dsv addon.

require 'tables/dsv'

coclass 'pcsv'
coinsert 'pdsv'
NB. =========================================================
NB. Utils for csv

NB. ---------------------------------------------------------
stdpathsep=: '/'&(I.@(e.&'/\')@]})
getfnme=: #~ ([: *./\. '/'&~:)

NB. extcsv v adds '.csv' extension if none present
extcsv=: , ('.csv' #~ '.'&e. < 0 < #)@getfnme@stdpathsep
NB. =========================================================
NB. Converting from csv files/strings to J array

NB. ---------------------------------------------------------
NB.*chopcsv v Convert csv string to list of boxed strings
NB. returns: list of boxed literals
NB. form: chopcsv string
NB. eg: chopcsv '"hello world",4,84.3'
NB. y is: csv delimited string
chopcsv=: (',';'""')&chopstring

NB. ---------------------------------------------------------
NB.*fixcsv v Convert csv data into J array
NB. returns: array of boxed literals
NB. form: fixcsv dat
NB. eg: fixcsv '"hello world",4,84.3',LF,'"Big dig","hello world",4',LF
NB. y is: csv delimited string, rows delimited by LF
fixcsv=: (',';'""')&fixdsv

NB. ---------------------------------------------------------
NB.*readcsv v Reads csv file into a boxed array
NB. returns: array of boxed literals
NB. form: readcsv file
NB. eg: readcsv jpath '~temp/test.csv'
NB. y is: filename of file to read from
readcsv=: (',';'""')&readdsv@extcsv
NB. =========================================================
NB. Converting from J array to csv files/strings

NB. ---------------------------------------------------------
NB.*appendcsv v Appends an array to a csv file
NB. returns: number of bytes appended or _1 if unsuccessful
NB. form: dat appendcsv file[;fd[;sd0[,sd1]]]
NB. eg: (3 2$'hello world';4;84.3;'Big dig') appendcsv jpath '~temp/test.csv'
NB. y is: filename of file to write dat to
NB. x is: a J array
appendcsv=: 4 : 0
  x appenddsv (extcsv y);',';'""'
)

NB. ---------------------------------------------------------
NB.*makecsv v Makes a CSV string from an array
NB. returns: CSV string
NB. form: makecsv array
NB. eg: makecsv  3 2$'hello world';4;84.3;'Big dig'
NB. y is: an array
NB. Arrays are flattened to a max rank of 2.
makecsv=: (',';'""')&makedsv

NB. ---------------------------------------------------------
NB.*writecsv v Writes an array to a csv file
NB. returns: number of bytes written (_1 if write error)
NB.          An existing file will be written over.
NB. form: dat writecsv file
NB. eg: (i.2 3 4) writecsv jpath ~temp/test
NB. y is: filename of file to write dat to
NB. x is: an array to write as csv
writecsv=: 4 : 0
  x writedsv (extcsv y);',';'""'
)
NB. =========================================================
NB. Verbs exported to z locale

appendcsv_z_=:appendcsv_pcsv_
chopcsv_z_=:chopcsv_pcsv_
fixcsv_z_=:fixcsv_pcsv_
makecsv_z_=:makecsv_pcsv_
readcsv_z_=:readcsv_pcsv_
writecsv_z_=:writecsv_pcsv_
