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

--ต้องการรหัสพนังาน ชื่อพนักงาน รหัสใบสั่งซื้อที่เกี่ยวข้อง เรียงตามลำดับรหัสพนักงาน
select e.EmployeeID,FirstName,OrderID
from Employees as e Join Orders as o on e.EmployeeID = o.EmployeeID
order by EmployeeID

--ต้องการรหัสสินค้า เมือง และประเทศของบริษัทผู้จำหน่าย
select ProductID,City,Country
from Products p Join Suppliers s on p.SupplierID = s.SupplierID

--ต้องการชื่อบริษัทขนส่ง และจำนวนใบสั่งซื้อที่เกี่ยวข้อง
select CompanyName,count(*)
from Shippers as s Join Orders as o on o.ShipVia = s.ShipperID
group by CompanyName

--ต้องการรหัสสินค้า ชื่อสินค้า และจำนวนทั้งหมดที่ขายได้
select p.ProductID,p.ProductName,sum(Quantity) as จำนวนที่ขายได้ทั้งหมด
from Products p Join [Order Details] od ON p.ProductID = od.ProductID
group by p.ProductID,p.ProductName
order by 1

--จงแสดงหมายเลขใบสั่งซื้อ ชื่อบริษัทลูกค้า สถานที่ส่งของ และพนักงานผู้ดูแล
select o.OrderID เลขใบสั่งซื้อ,c.CompanyName ลูกค้า,e.FirstName พนักงาน,o.ShipAddress ส่งไปที่
from Orders o,Customers c,Employees e
where o.CustomerID = c.CustomerID
and o.EmployeeID = e.EmployeeID

select o.OrderID เลขใบสั่งซื้อ,c.CompanyName ลูกค้า,e.FirstName พนักงาน,o.ShipAddress ส่งไปที่
from Orders o
join Customers c on o.CustomerID = c.CustomerID
join Employees e on o.EmployeeID = e.EmployeeID

--ต้องการ รหัสพนักงาน ชื่อพนักงาน จำนวนใบสั่งซื้อที่เกี่ยวข้อง ผลรวมของค่าขนส่งในปี 1996
select e.EmployeeID,FirstName,count(*) as [จำนวน order]
from Employees e join Orders o on e.EmployeeID = o.EmployeeID
where year(OrderDate) = 1996
group by e.EmployeeID,FirstName
order by 3

--ต้องการรหัสสินค้า ชื่อสินค้า ที่ nancy ขายได้ทั้งหมด เรียงตามลำดับสินค้า
select distinct p.ProductID,p.ProductName
from Employees e join Orders o on e.EmployeeID = o.EmployeeID
				 join [Order Details] od on o.OrderID = od.OrderID
				 join Products p on od.ProductID = p.ProductID
where e.FirstName = 'Nancy'
order by ProductID

--ต้องการชื่อบริษัทลูกค้าชื่อ Around the Horn ซื้อสินค้ามาจากประเทศอะไรบ้าง
select distinct s.Country
from Customers c join orders o on c.CustomerID = o.CustomerID
				 join [Order Details] od on o.OrderID = od.OrderID
				 join Products p on od.ProductID = p.ProductID
				 join Suppliers s on s.SupplierID = p.SupplierID
where c.CompanyName = 'Around the Horn'

--บริษัทลูกค้าชื่อ Around the Horn ซื้อสินค้าอะไรบ้าง จำนวนเท่าใด
select p.ProductID,p.ProductName,sum(Quantity) as [sum of Quantity]
from Customers c join orders o on c.CustomerID = o.CustomerID
				 join [Order Details] od on od.OrderID = o.OrderID
				 join Products p on p.ProductID = od.ProductID
where c.CompanyName = 'Around the Horn'
group by p.ProductID,p.ProductName
order by 1

--ต้องการหมายเลขใบสั่งซื้อ ชื่อพนักงาน และยอดขายในใบสั่งซื้อนั้น
select o.OrderID, e.FirstName, 
	   sum((od.Quantity * od.UnitPrice *(1-od.Discount))) as TotalCash
from Orders o join Employees e on o.EmployeeID = e.EmployeeID
			  join [Order Details] od on o.OrderID = od.OrderID
group by o.OrderID, e.FirstName
order by OrderID
