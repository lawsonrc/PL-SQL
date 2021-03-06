DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE JOBS CASCADE CONSTRAINTS;
DROP TABLE EVENT CASCADE CONSTRAINTS;
DROP TABLE WORKS_EVENT CASCADE CONSTRAINTS;
DROP TABLE PAYMENT CASCADE CONSTRAINTS;
DROP TABLE PHOTO CASCADE CONSTRAINTS;
DROP TABLE PACKAGE CASCADE CONSTRAINTS;
DROP TABLE PHOTO_PACKAGE CASCADE CONSTRAINTS;
DROP TABLE payment_of_customer CASCADE CONSTRAINTS;

CREATE TABLE EMPLOYEE (
  EMPLOYEE_ID   VARCHAR2(8) PRIMARY KEY,
  FNAME     VARCHAR2(50)NOT NULL,
  LNAME      VARCHAR2(50)NOT NULL,
  PHONE         NUMBER(10,0),
  STREET        VARCHAR2(50),
  CITY          VARCHAR2(50),
  STATE         VARCHAR2(2),
  ZIP           VARCHAR2(5),
  TYPE          VARCHAR2(2)
);

CREATE TABLE CUSTOMER (
  CUSTOMER_ID   VARCHAR2(8) PRIMARY KEY,
  FNAME     VARCHAR2(50)NOT NULL,
  LNAME      VARCHAR2(50)NOT NULL,
  PHONE         NUMBER(10,0),
  STREET        VARCHAR2(50),
  CITY          VARCHAR2(50),
  STATE         VARCHAR2(2),
  ZIP           VARCHAR2(5)
);

CREATE TABLE JOBS(
  JOB_ID        VARCHAR2(8)PRIMARY KEY,
  SERV_DESIRED  VARCHAR2(225),
  JOB_LOCATION  VARCHAR2(50),
  JOB_DATE      DATE,
  TIME_OF_JOB   TIMESTAMP,
  JOB_ESTIMATE  NUMBER(6,2),
  TYPE_OF_JOB   VARCHAR2(50),
  FINALIZED     VARCHAR2(1),
  packagepref   varchar2(255),
  CUSTOMER_ID   VARCHAR2(8),
  FOREIGN KEY  (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID)
);

CREATE TABLE EVENT (
  EVENT_ID      VARCHAR2(8) PRIMARY KEY,
  EVENTTYPE     VARCHAR2(50),
  DESCRIPTION   VARCHAR2(150),
  LOCATION_NAME VARCHAR2(50),
  STREET        VARCHAR2(50),
  CITY          VARCHAR2(50),
  STATE         VARCHAR2(2),
  ZIP           VARCHAR2(5),
  JOB_ID        VARCHAR2(8),
  FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID)
);

--Relationship between EMPLOYEE & EVENT
CREATE TABLE WORKS_EVENT (
  EVENT_ID      VARCHAR2(8),
  EMPLOYEE_ID   VARCHAR2(8),
  PRIMARY KEY (EVENT_ID, EMPLOYEE_ID),
  FOREIGN KEY  (EVENT_ID) REFERENCES EVENT (EVENT_ID),
  FOREIGN KEY  (EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID)
);

CREATE TABLE PAYMENT (
  PAYMENT_ID      VARCHAR2(8) PRIMARY KEY,
  PAYMENT_DATE    DATE,
  PAYMENT_AMOUNT  NUMBER(6,2),
  PAYMENT_TYPE    VARCHAR2(50),
  JOB_ID          VARCHAR2(8),
  FOREIGN KEY   (JOB_ID) REFERENCES JOBS (JOB_ID)
);
--eliminates the payment and customer many to many
CREATE TABLE payment_of_customer (
payment_id varchar(8),
customer_id varchar(8),
primary key(payment_id,customer_id),
foreign key (payment_id) references payment(payment_id));


CREATE TABLE PHOTO (
    PHOTO_ID    VARCHAR2(8) PRIMARY KEY,
    DIMENSIONS  VARCHAR2(20),
    DESCRIPTION VARCHAR2(255),
    EVENT_ID    VARCHAR2(8),
  FOREIGN KEY (EVENT_ID) REFERENCES EVENT (EVENT_ID)
);

CREATE TABLE PACKAGE (
  PACKAGE_ID    VARCHAR2(8) PRIMARY KEY,
  APPROVAL      VARCHAR2(1) NOT NULL,
  DESCRIPTION   VARCHAR2(150),
  JOB_ID        VARCHAR2(8),
  FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID) 
);

CREATE TABLE PHOTO_PACKAGE (
  PHOTO_ID      VARCHAR2(8),
  PACKAGE_ID    VARCHAR2(8),
  CONSTRAINT PK_PHOTO_PACKAGE PRIMARY KEY (PHOTO_ID, PACKAGE_ID),
  FOREIGN KEY   (PHOTO_ID) REFERENCES PHOTO (PHOTO_ID),
  FOREIGN KEY   (PACKAGE_ID) REFERENCES PACKAGE(PACKAGE_ID)
);


