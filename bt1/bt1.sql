create database products_manager;
use products_manager;

create table Products (
id int primary key auto_increment,
productCode varchar(25),
productName varchar(25) not null,
productPrice double,
productAmount int,
productDescription varchar(255),
productStatus bit
);

insert into Products (Id, productCode, productName, productPrice, productAmount, productDescription, productStatus)
values (id, "P1", "rice", 10.0, 3, "no", 1),
       (id, "P2", "potato", 20.0, 3, "no", 1),
       (id, "P3", "tomato", 15.0, 3, "no", 1),
       (id, "P4", "corn", 16.9, 3, "no", 1),
	   (id, "P5", "peanut", 9.1, 3, "no", 1);
       
insert into Products (Id, productCode, productName, productPrice, productDescription, productStatus)
values (id, "P1", "rice", 10.0, "no", 1);

#Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
alter table products add index idx_Composite (productName, productPrice);

#Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
alter table products add unique idx_products(productCode);

#Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
EXPLAIN select * from products where productName = "corn";

#Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view Products_view as
select productCode, productName, productPrice, productStatus
from Products
where productAmount is not null
with check option;

#Tiến hành sửa đổi view
update Products_view
set productName = "banana"
where productCode = "p5";

#Tiến hành xoá view
drop view Products_view;

#Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
Delimiter //
Create Procedure allrecordsProducts()
    BEGIN
    Select * from Products;
    END//
DELIMITER ;
call allrecordsProducts();

#Tạo store procedure thêm một sản phẩm mới
Delimiter //
Create Procedure addrecordsProducts( id int,
                                     pCode varchar(25),
                                     pName varchar(25),
                                     pPrice double,
                                     pAmount int,
                                     pDescription varchar(255),
                                     pStatus bit)
    BEGIN
    insert into  Products (Id, productCode, productName, productPrice, productAmount, productDescription, productStatus)
    value ( id , pCode, pName, pPrice, pAmount , pDescription , pStatus );
    END//
DELIMITER ;
call addrecordsProducts(7, "p7", "mango", 10.15, 4, "no", 1);

#Tạo store procedure sửa thông tin sản phẩm theo id
Delimiter //
Create Procedure editProducts( in pid int,
                                  in pCode varchar(25),
                                  in pName varchar(25),
                                  in pPrice double,
                                  in pAmount int,
                                  in pDescription varchar(255),
                                  in pStatus bit)
    BEGIN
    update Products
    set productCode = pCode,
        productName = pName,
        productPrice = pPrice,
        productAmount = pAmount,
        productDescription = pDescription,
        productStatus = pStatus
	where Id = pid;
    END//
DELIMITER ;
drop procedure editProducts;
call editProducts(7, "p5", "mango1", 10.1, 6, "no", 1);

#Tạo store procedure xoá sản phẩm theo id
Delimiter //
Create Procedure deleteProductsById(in pid int)
    begin
    delete from Products where Id = pid;
    end//
DELIMITER ;
call deleteProductsById(7);