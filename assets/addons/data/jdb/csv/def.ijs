NB. OrderDetails(OrderID,ProductID,UnitPrice,...)
NB.              |       |
NB.              |   Products(ProductID,ProductName,SupplierID,CategoryID,,...)
NB.              |                                  |          |
NB.              |                                  |   Categories(CategoryID,CategoryName,...)
NB.              |                                  |
NB.              |                           Suppliers(SupplierID,CompanyName,ContactName,...)
NB.              |
NB.          Orders(OrderID,CustomerID,EmployeeID,...,ShipVia,...)
NB.                         |          |              |
NB.                         |          |              Shippers(ShipperID,CompanyName,...)
NB.                         |          |
NB.                         |          Employees(EmployeeID,LastName,FirstName,...)
NB.                         |
NB.                         Customers(CustomerID,CustomerName,...)

Create__d 'Customers';0 : 0
  CustomerID     char;
  CompanyName    varchar
  ContactName    varchar
  ContactTitle   varchar
  Address        varchar
  City           varchar
  Region         varchar
  PostalCode     varchar
  Country        varchar
  Phone          varchar
  Fax            varchar
)
Create__d 'Employees';0 : 0
  EmployeeID       int;
  LastName         varchar
  FirstName        varchar
  Title            varchar
  TitleOfCourtesy  varchar
  BirthDate        int
  HireDate         int
  Address          varchar
  City             varchar
  Region           varchar
  PostalCode       varchar
  Country          varchar
  HomePhone        varchar
  Extension        varchar
  Photo            varchar
  Notes            varchar
  ReportsTo        int
)
Create__d 'Shippers';0 : 0
  ShipperID   int;
  CompanyName varchar
  Phone       varchar
)
Create__d 'Orders';0 : 0
  OrderID        int;
  CustomerID     Customers
  EmployeeID     Employees
  OrderDate      int
  RequiredDate   int
  ShippedDate    int
  ShipVia        Shippers
  Freight        float
  ShipName       varchar
  ShipAddress    varchar
  ShipCity       varchar
  ShipRegion     varchar
  ShipPostalCode varchar
  ShipCountry    varchar
)
Create__d 'Suppliers';0 : 0
  SupplierID    int;
  CompanyName   varchar
  ContactName   varchar
  ContactTitle  varchar
  Address       varchar
  City          varchar
  Region        varchar
  PostalCode    varchar
  Country       varchar
  Phone         varchar
  Fax           varchar
  HomePage      varchar
)
Create__d 'Categories';0 : 0
  CategoryID   int;
  CategoryName varchar
  Description  varchar
  Picture      varchar
)
Create__d 'Products';0 : 0
  ProductID        int;
  ProductName      varchar
  SupplierID       Suppliers
  CategoryID       Categories
  QuantityPerUnit  varchar
  UnitPrice        float
  UnitsInStock     int
  UnitsOnOrder     int
  ReorderLevel     int
  Discontinued     char
)
Create__d 'OrderDetails';0 : 0
  OrderID      Orders
  ProductID    Products;
  UnitPrice    float
  Quantity     int
  Discount     float
)

NB. Dates are int
NB. Employees.Notes is Text/Memo
NB. Categories.Picture is Binary
NB. Suppliers.HomePage is Text/Memo
