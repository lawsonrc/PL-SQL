/* 
  Programmer's Name: Ryan Lawson & Christie Sutton 
  Course: CSCI 3020 Section Number: 090
  Creation Date: 7/19/2017
  E-mail Address:lawsonrc@etsu.edu & zcas69@etsu.edu
  Project Name: Project 3
*/
DROP TABLE MODEL CASCADE CONSTRAINTS;
DROP TABLE PAINT CASCADE CONSTRAINTS;
DROP TABLE ADDRESS CASCADE CONSTRAINTS;
DROP TABLE PART CASCADE CONSTRAINTS;
DROP TABLE BICYCLE CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE STORE CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE COMPONENTS CASCADE CONSTRAINTS;
DROP TABLE PURCHASE CASCADE CONSTRAINTS;

Create table Model(
  ModelID           number Primary Key,
  ModelName         VARCHAR2(50)
);

Create table Paint(
  PaintID            VARCHAR2(9) Primary Key,
  ColorName          VARCHAR2(50),
  ColorStyle         VARCHAR2(50),
  ColorList          VARCHAR2(255),
  DateIntroduced     DATE,
  DateDiscontinued   Date
);

Create table Address(
  AddressID          number Primary Key,
  Address            VARCHAR2(50),
  City               VARCHAR2(50),
  State              VARCHAR2(10),
  ZIP                VARCHAR2(10),
  Country             VARCHAR2(50)
);

Create table Part(
  PartID             number Primary Key,
  PartName           VARCHAR2(50),
  ManufacturerName   VARCHAR2(50),
  Description        VARCHAR2(150),
  ListPrice          NUMBER(38,4),
  EstimatedCost      NUMBER(38,4)
);

Create table Bicycle(
  SerialNumber       VARCHAR2(16) Primary Key,
  ModelID            number,
  PaintID            VARCHAR2(9),
  FrameSize          VARCHAR2(5),
  FOREIGN KEY (modelID) REFERENCES Model(ModelID),
  FOREIGN KEY (paintID) REFERENCES Paint(PaintID)
);

Create table Customer(
  CustomerID         VARCHAR2(9) Primary Key,
  CustomerName       VARCHAR2(50),
  Phone              VARCHAR2(50 BYTE),
  AddressID          number,
  FOREIGN KEY (addressID) REFERENCES Address(AddressID)  
);

Create table Store(
  StoreID            VARCHAR2(9) Primary Key,
  StoreName          VARCHAR2(50),
  Phone              VARCHAR2(50 BYTE),
  AddressID          number,
  FOREIGN KEY (addressID) REFERENCES Address(AddressID)
);

Create table Employee(
  EmployeeID         VARCHAR2(9) Primary Key,
  EmployeeName       VARCHAR2(50),
  HomePhone          VARCHAR2(50 BYTE),
  AddressID          number,
  HireDate           DATE,
  ReleaseDate        DATE,
  FOREIGN KEY (addressID) REFERENCES Address(AddressID)
);

Create table Components(
  ComponentID         number Primary Key,
  BicycleSerialNumber VARCHAR2(16),
  EmployeeID          VARCHAR2(9),
  PartID              number,
  Quantity            NUMBER(38,4),
  Cost                NUMBER(38,4),
  DateInstalled       DATE,
  FOREIGN KEY (bicycleSerialNumber) REFERENCES Bicycle(SerialNumber),
  FOREIGN KEY (employeeID) REFERENCES Employee(EmployeeID),
  FOREIGN KEY (partID) REFERENCES Part(PartID)
);

Create table Purchase(
  PurchaseID          VARCHAR2(9) Primary Key,
  BicycleSerialNumber VARCHAR2(16),
  CustomerID          VARCHAR2(9),
  StoreID             VARCHAR2(9),
  EmployeeID          VARCHAR2(9),
  ListPrice           NUMBER(9,2),
  SalesPrice          NUMBER(38,4),
  SalesTax            NUMBER(38,4),
  ShipPrice           NUMBER(38,4),
  OrderDate           DATE,
  StartDate           DATE,
  ShipDate            DATE,
  FOREIGN KEY (bicycleSerialNumber) REFERENCES Bicycle(SerialNumber),
  FOREIGN KEY (customerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (storeID) REFERENCES Store(StoreID),
  FOREIGN KEY (employeeID) REFERENCES Employee(EmployeeID)
);