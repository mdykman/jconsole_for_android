NB. TPC-H Benchmark for decision support OLAP databases

DBPATH=: jpath'~temp'
DBNAME=: 'northwind'
DATA=: jpath'~addons/data/jdb/csv/'
DDL=: DATA,'def.ijs'
TBLS=: ;:'Customers Employees Shippers Orders Suppliers Categories Products OrderDetails'

NB. utilities
num=: 0 ". '0'"_^:(0=#)
isdate=: '-' (e. *. 0<i.~) ]
fmdate=: 8 {. -.&'- :'
showx=: smoutput@". [ smoutput@('   '&,)

NB. =========================================================
NB. build v build TPC-H database
db_build=: 3 : 0
f=. Open_jdb_ y
Drop__f DBNAME
d=. Create__f DBNAME
0!:0 < DDL
d (db_import>)"0 TBLS
destroy__f''
)

db_import=: 4 : 0
cl=. {:"1 ReadCols__x y
d=. ''                  NB. converted data
r=. readcsv DATA,y,'.csv'
for_c. |:r do.
  ct=. c_index { 2 pick cl  NB. col type
  if. ct=<'autoid' do.  NB. foreign key
    fn=. >c_index{4 pick cl
    fc=. >c_index{5 pick cl
    fl=. {:"1 ReadCols__x fn
    fp=. (1 pick fl) i. <fc
    ct=. fp { 2 pick fl
  end.
  select. ct
  case.<'int' do. c=. ([: num fmdate^:isdate) every c
  case.<'float' do. c=. num every c
  case.<'char' do. c=. >c
  case.<'byte' do. c=. ;c
  end.
  d=. d,<c
end.
Insert__x y;<d
i.0 0
)

NB. =========================================================
db_init=: 3 : 0
db_build y
resetall_jdb_''
db_open y
)

NB. =========================================================
db_open=: 3 : 0
f=. Open_jdb_ y
D=: Open__f DBNAME
i.0 0
)

db_close=: 3 : 0
destroy__D ''
)

NB. =========================================================
NB. Smoke Test: db_demo ''  or  run by line: Ctrl+E
db_demo=: (showx;._2) bind (0 : 0)
  load 'csv data/jdb'
  db_init DBPATH
  Reads__D 'from Categories'
  Reads__D 'from Suppliers where Country=UK'
  Reads__D '** from Products where Categories.CategoryName=Beverages'
  Reads__D 'from Products where Suppliers.CompanyName=Exotic Liquids'
  Reads__D 'from Products where UnitPrice<10'
  Reads__D 'Categories.CategoryName from Products where Suppliers.Country=UK'
  Reads__D 'from Customers where Country=UK'
  Reads__D 'from Employees where Country<>UK and HireDate>19930000'
  Reads__D 'from Shippers'
  Reads__D 'from Orders where Customers.Country=UK and Employees.Country=UK and ShipperID=1'
  Reads__D 'from OrderDetails where Customers.Country=UK and Quantity>60'
  Reads__D 'count:count autoid by Country from Suppliers'
  Reads__D 'min:min UnitsInStock,max:max UnitsInStock by Suppliers.Country from Products'
  ReadCols__D'Products'
  db_close''
)
