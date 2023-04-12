--ÇALIŞMA SORGULARI
--Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
SELECT  CompanyName, ContactName, [Address],City, Country
FROM Customers
WHERE Country='Brazil'
ORDER BY CompanyName

--— Brezilya’da olmayan müşteriler
SELECT  CompanyName, ContactName, [Address],City, Country
FROM Customers
WHERE Country!='Brazil'
ORDER BY CompanyName

--— Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
SELECT  CompanyName, Country
FROM Customers
WHERE Country='Spain' OR Country='France' OR Country='Germany'
ORDER BY Country

--–Faks numarasını bilmediğim müşteriler
SELECT  CompanyName
FROM Customers
WHERE Fax IS NULL
ORDER BY CompanyName

--— Londra’da ya da Paris’de bulunan müşterilerim
SELECT  CompanyName, ContactName, [Address],City, Country
FROM Customers
WHERE City='London' OR City='Paris'

--— Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
SELECT  CompanyName, ContactName, [Address],City, Country
FROM Customers
WHERE City='México D.F.' AND ContactTitle='Owner'

--— C ile başlayan ürünlerimin isimleri ve fiyatları
SELECT  ProductName, UnitPrice
FROM Products
WHERE ProductName LIKE 'C%'

--— Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
SELECT  FirstName, LastName, BirthDate
FROM Employees
WHERE FirstName LIKE 'A%'

--— İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
SELECT  CompanyName
FROM Customers
WHERE CompanyName LIKE '%restaurant%'

--— 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
SELECT  ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 50 AND 100

--— 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri
SELECT  OrderID, OrderDate
FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-12-31' 

--Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
SELECT Country, CompanyName
FROM Customers
WHERE Country='Spain' OR Country='France' OR Country='Germany'
ORDER BY Country ASC

--Faks numarasını bilmediğim müşteriler
SELECT CompanyName
FROM Customers
WHERE Fax IS NULL
ORDER BY CompanyName ASC

--Müşterilerimi ülkeye göre sıralıyorum:
SELECT DISTINCT Country, CompanyName
FROM Customers
ORDER BY Country ASC

--Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz:
SELECT ProductName, UnitPrice, UnitsInStock
FROM Products
ORDER BY UnitPrice DESC, UnitsInStock ASC

--1 Numaralı kategoride kaç ürün vardır..?
SELECT COUNT(*) ProductName
FROM Products
WHERE CategoryID=1

--Kaç farklı ülkeye ihracat yapıyorum..?
SELECT COUNT(DISTINCT Country)
FROM Customers

--Bu ülkeler hangileri..?
SELECT DISTINCT Country
FROM Customers

--En Pahalı 5 ürün
SELECT TOP 5 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
SELECT COUNT(*) AS [Toplam Sipariş Sayısı]
FROM Orders
WHERE CustomerID='ALFKI'

--Ürünlerimin toplam maliyeti
SELECT SUM(UnitPrice*Quantity)
FROM [Order Details]

--Şirketim, şimdiye kadar ne kadar ciro yapmış..?
SELECT SUM(UnitPrice*Quantity*(1-Discount)) AS [Toplam Ciro]
FROM [Order Details]

--Ortalama Ürün Fiyatım
SELECT AVG(UnitPrice) [Ortalama Ürün Fiyatı]
FROM Products

--En Pahalı Ürünün Adı
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice=(SELECT MAX(UnitPrice)
FROM Products)

--En az kazandıran sipariş
SELECT TOP 1  OrderID, SUM(UnitPrice*Quantity) AS [En Kârsız Sipariş]
FROM [Order Details]
GROUP BY OrderID
ORDER BY [En Kârsız Sipariş] ASC

--Müşterilerimin içinde en uzun isimli müşteri (harf sayısı)
SELECT TOP 1 CompanyName, LEN(CompanyName) AS [İsim Uzunluğu]
FROM Customers
ORDER BY [İsim Uzunluğu] DESC

--Çalışanlarımın Ad, Soyad ve Yaşları
SELECT FirstName AS [Adı], LastName AS [Soyadı], DATEDIFF(YEAR,BirthDate,GETDATE()) AS Yaşı
FROM Employees

--Hangi üründen toplam kaç adet alınmış..?
SELECT OrderID, SUM(Quantity) AS [Toplam Sipariş Miktarı]
FROM [Order Details]
GROUP BY OrderID
ORDER BY [Toplam Sipariş Miktarı] DESC

--Hangi siparişte toplam ne kadar kazanmışım..?
SELECT OrderID, SUM(Quantity*UnitPrice) AS [Toplam Sipariş Tutarı]
FROM [Order Details]
GROUP BY OrderID
ORDER BY OrderID DESC

--Hangi kategoride toplam kaç adet ürün bulunuyor..?
SELECT CategoryID, COUNT (CategoryID) AS [Toplam Ürün Sayısı]
FROM Products
GROUP BY CategoryID

--1000 Adetten fazla satılan ürünler?
SELECT OrderID, SUM(Quantity) AS [Toplam Sipariş Miktarı]
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity) >1000

--Hangi Müşterilerim hiç sipariş vermemiş..? (91 Müşteriden 89’u sipariş vermişti..)
SELECT CompanyName
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders)

--Hangi ürün hangi kategoride..
SELECT CategoryName, ProductName
FROM Categories C INNER JOIN Products P 
ON C.CategoryID=P.CategoryID
ORDER BY CategoryName ASC

--Hangi tedarikçi hangi ürünü sağlıyor ? 
SELECT CompanyName AS Supplier, ProductName AS Product
FROM Suppliers S INNER JOIN Products P
ON S.SupplierID=P.SupplierID
ORDER BY CompanyName ASC
--ya da
SELECT ProductName AS Product, CompanyName AS Supplier
FROM Products P INNER JOIN Suppliers S
ON P.SupplierID=S.SupplierID
ORDER BY ProductName ASC


--Hangi sipariş hangi kargo şirketi ile ne zaman gönderilmiş..?
SELECT CompanyName AS [Shipper Company], OrderID AS [Order], ShippedDate AS [Shipped Date]
FROM Shippers S INNER JOIN Orders O
ON S.ShipperID=O.ShipVia 
ORDER BY CompanyName ASC

--Hangi siparişi hangi müşteri verir..?
SELECT CompanyName AS Customer, OrderID AS [Order]
FROM Customers C INNER JOIN Orders O
ON C.CustomerID=O.CustomerID
ORDER BY CompanyName

--Hangi çalışan, toplam kaç sipariş almış..?
SELECT FirstName + '  '+ LastName AS Employee, COUNT(OrderID) AS [Order Quantity]
FROM Employees E INNER JOIN Orders O
ON E.EmployeeID=O.EmployeeID
GROUP BY  FirstName, LastName
ORDER BY [Order Quantity] DESC

--En fazla siparişi kim almış..?
SELECT TOP 1 FirstName + '  '+ LastName AS Employee, COUNT(OrderID) AS [Order Quantity]
FROM Employees E INNER JOIN Orders O
ON E.EmployeeID=O.EmployeeID
GROUP BY  FirstName, LastName
ORDER BY [Order Quantity] DESC

--Hangi siparişi, hangi çalışan, hangi müşteri vermiştir..?
SELECT CompanyName AS Customer, FirstName + '  '+ LastName AS Employee,  OrderID AS [Order]
FROM Employees E INNER JOIN Orders O
ON E.EmployeeID=O.EmployeeID
INNER JOIN Customers C ON C.CustomerID=O.CustomerID
ORDER BY CompanyName

-- Hangi ürün, hangi kategoride bulunmaktadır..? Bu ürünü kim tedarik etmektedir..?
SELECT CategoryName AS Category, ProductName AS Product, CompanyName AS Supplier
FROM Products P INNER JOIN Categories C
ON P.CategoryID= C.CategoryID
INNER JOIN Suppliers S ON S.SupplierID=P.SupplierID
ORDER BY CategoryName ASC

-- Hangi siparişi hangi müşteri vermiş, hangi çalışan almış, hangi tarihte, hangi kargo şirketi tarafından gönderilmiş hangi üründen kaç adet alınmış, hangi fiyattan alınmış, ürün hangi kategorideymiş 
--bu ürünü hangi tedarikçi sağlamış
SELECT O.OrderID AS [Order Number], C.CompanyName AS Customer, FirstName+ ' ' +LastName AS Employee, RequiredDate AS [Order Date], 
SH.CompanyName AS Shipper, ProductName AS [Product Name], OD.Quantity AS [Order Quantity], OD.UnitPrice AS [Unit Price], 
CT.CategoryName AS [Product Category], SP.CompanyName AS [Supplier Company]
FROM Customers C INNER JOIN Orders O
ON C.CustomerID=O.CustomerID
INNER JOIN Employees E ON O.EmployeeID=E.EmployeeID
INNER JOIN Shippers SH ON O.ShipVia=SH.ShipperID
INNER JOIN [Order Details] OD ON O.OrderID=OD.OrderID
INNER JOIN Products P ON OD.ProductID=P.ProductID
INNER JOIN Categories CT ON P.CategoryID=CT.CategoryID
INNER JOIN Suppliers SP ON P.SupplierID=SP.SupplierID
ORDER BY O.OrderID ASC

--Altında ürün bulunmayan kategoriler
SELECT CategoryName
FROM Products P RIGHT JOIN Categories C 
ON P.CategoryID=C.CategoryID
WHERE P.CategoryID IS NULL
ORDER BY CategoryName

--91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
SELECT CompanyName, OrderID
FROM Orders O RIGHT JOIN Customers C
ON C.CustomerID=O.CustomerID
WHERE O.OrderID IS NULL
ORDER BY CompanyName ASC

--Hangi çalışan şimdiye kadar  toplam kaç sipariş almış..?
SELECT E.FirstName + ' ' +E.LastName AS Employee, SUM(OD.Quantity) AS [Total Order]
FROM Employees E INNER JOIN Orders O
ON E.EmployeeID=O.EmployeeID
INNER JOIN [Order Details] OD ON O.OrderID=OD.OrderID
GROUP BY E.FirstName, E.LastName
ORDER BY E.FirstName ASC