/* 
  Programmer's Name: Ryan Lawson & Christie Sutton 
  Course: CSCI 3020 Section Number: 090
  Creation Date: 7/19/2017
  E-mail Address:lawsonrc@etsu.edu & zcas69@etsu.edu 
  Project Name: Project 3
*/
insert into paint
select paintid, colorName, colorStyle, colorList, DateIntroduced, Datediscontinued
from bike_shop.paint;

insert into model
select row_number() Over(order by modeltype) modelid,
    modeltype
from bike_shop.modeltype
where modeltype is not null
group by modeltype
order by modeltype;

insert into address
select row_number() Over(order by state, city) addressid,
address,
city,
state,
zipcode,
country
from
(select c.address,
        ci.city,
        ci.state,
        ci.zipcode,
        ci.country
        from bike_shop.customer c
        inner join bike_shop.city ci on
         c.cityid= ci.cityid
        UNION
  select rs.address,
         ci.city,
         ci.state,
         ci.zipcode,
         ci.country
         from bike_shop.retailstore rs
         inner join bike_shop.city ci on
         rs.cityid= ci.cityid
         UNION
   select e.address,
         ci.city,
         ci.state,
         ci.zipcode,
         ci.country
         from bike_shop.employee e
         inner join bike_shop.city ci on
         e.cityid =ci.cityid)
         order by state, city;

insert into part
select componentid,category,manufacturername,description,listprice,estimatedcost
from bike_shop.component
natural join bike_shop.manufacturer;

insert into Customer
select c.CustomerID, c.firstname||' '||c.lastname, c.Phone, a.AddressID 
from bike_shop.Customer c
left join bike_shop.city ci on
c.cityid= ci.CITYID
Left join Address a on
NVL(upper(c.address),'ZZ') =NVL(upper(a.address),'ZZ') and
NVL(upper(ci.city),'ZZ') =NVL(upper(a.city),'ZZ') and
NVL(ci.state,'ZZ')=NVL(a.state,'ZZ');


insert into Store
select rs.StoreID, rs.StoreName,rs.Phone, a.AddressID
from BIKE_SHOP.RETAILSTORE rs
left join bike_shop.city ci on
rs.cityid= ci.CITYID
Left join Address a on
NVL(upper(rs.address),'ZZ') =NVL(upper(a.address),'ZZ') and
NVL(upper(ci.city),'ZZ') =NVL(upper(a.city),'ZZ') and
NVL(ci.state,'ZZ')=NVL(a.state,'ZZ') ;

insert into Employee
select e.EmployeeID, e.Firstname||' '||e.LASTNAME, e.HomePhone, a.AddressID, e.datehired, e.DATERELEASED
from bike_shop.employee e
left join bike_shop.city ci on
e.cityid= ci.CITYID
Left join Address a on
e.address = a.address and
ci.city =a.city and
ci.state=a.state and
ci.zipcode=a.zip and
ci.country = a.country;

insert into bicycle
select bi.serialnumber,mo.modelid,bi.paintid,bi.framesize
from bike_shop.bicycle bi
left join model mo on
bi.modeltype=mo.modelname;

insert into components
select row_number()over(order by bp.serialnumber)componentID,
bp.serialnumber,
bp.employeeID,
p.partID, 
bp.quantity,
p.estimatedcost,
bp.dateinstalled
from bike_shop.bikeparts bp
left join part p on
bp.componentID = p.partID;

insert into purchase
select row_number()over(order by serialnumber) PurchaseID,
serialnumber,
customerid,
storeid,
employeeid,
listprice,
saleprice,
salestax,
shipprice,
orderdate,
startdate,
orderdate
from bike_shop.bicycle;

select count(*) from bicycle;