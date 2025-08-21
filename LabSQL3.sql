--แสดงชื่อประเภทสินค้า ชื่อสินค้า และราคาสินค้า
select CategoryName,ProductName,UnitPrice
from Products,Categories
where Products.CategoryID = Categories.CategoryID
order by CategoryName


select CategoryName,ProductName,UnitPrice
from Products JOIN Categories
on Products.CategoryID = Categories.CategoryID

select CategoryName,ProductName,UnitPrice
from Products as P JOIN Categories as C
on P.CategoryID = C.CategoryID

--จงแสดงข้อมูล หมายเลขใบสั่งซื้อ และชื่อบริษัทขนส่งสินค้า
--Cartesian Product
select CompanyName,OrderID
from Orders,Shippers
where Shippers.ShipperID = Orders.ShipVia

--Join Opertor
select CompanyName,OrderID
from Orders JOIN Shippers
ON Shippers.ShipperID = Orders.ShipVia

--ต้องการรหัสสินค้า ชื่อสินค้า บริษัทผู้จำหน่าย ประเทศ
select p.ProductID,p.ProductName,s.CompanyName,s.Country
from Suppliers s Join Products p on s.SupplierID = p.SupplierID

select p.ProductID,p.ProductName,s.CompanyName,s.Country
from Suppliers s,Products p where s.SupplierID = p.SupplierID

--จงแสดงข้อมูลหมายเลขใบสั่งซื้อและชื่อบริษัทขนส่งสินค้าของใบสั่งซื้อหมายเลข 10275
--Cartesian Product
select CompanyName,OrderID
from Orders,Shippers
where Shippers.ShipperID = Orders.ShipVia
AND OrderID = 10275

--Join Opertor
select CompanyName,OrderID
from Orders JOIN Shippers
ON Shippers.ShipperID = Orders.ShipVia
AND OrderID = 10275
