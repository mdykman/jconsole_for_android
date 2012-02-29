NB. test0

taccess=: 3 : 0
load 'odbc'
load '~system/examples/odbc/access.ijs'
)

tdbase=: 3 : 0
load 'odbc'
load '~system/examples/odbc/dbase.ijs'
)

texcel=: 3 : 0
load 'odbc'
load '~system/examples/odbc/excel.ijs'
)

ttext=: 3 : 0
load 'odbc'
load '~system/examples/odbc/text.ijs'
)

taccess''
dbg 1
dbstops'ddcon'
demo''
