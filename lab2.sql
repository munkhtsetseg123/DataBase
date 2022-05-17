Хүснэгт үүсгэх 

CREATE TABLE Branch(
branchNo VARCHAR(20),
street VARCHAR(25),
city VARCHAR(20),
postcode VARCHAR(20)
);
INSERT INTO Branch(branchNo, street, city, postcode)
VALUES("B005","22 Deer Rd","London","SW1 4EH"),
("B007","16 Argyll ST","Aberdeen","AB2 3SU"),
("B003","163 Main St","Glasgow","G11 9QX"),
("B004","32 Manse Rd","Bristol","BS99 1NZ"),
("B002","56 Clover Dr","London","NW10 6Eu");

CREATE TABLE Staff(
staffNo VARCHAR(20),
fName VARCHAR(20),
IName VARCHAR(20),
position1 VARCHAR(20),
sex VARCHAR(1),
DOB DATE,
salary INT,
branchNo VARCHAR(20)
);
INSERT INTO Staff(staffNo,fName,IName,position1,sex,DOB,salary,branchNo)
VALUES ("SL21","John","White","Manager","M","1945-10-01",30000,"B005"),
("SG37","Ann","Beech","Assistant","F","1960-11-10",12000,"B003"),
("SG14","David","Ford","Supervisor","M","1958-3-24",18000,"B003"),
("SA9","Mary","Howe","Assistant","F","1970-2-19",9000,"B007"),
("SG5","Susan","Brand","Manager","F","1940-6-3",24000,"B005"),
("SL41","Julie","Lee","Assistant","F","1965-6-13",9000,"B005");

CREATE TABLE Registration(
clientNo VARCHAR(20),
branchNo VARCHAR(20),
staffNo VARCHAR(20),
dateJoined DATE
);
INSERT INTO Registration(clientNo,branchNo,staffNo,dateJoined)
VALUES ("CR76","B005","SL41","2004-1-2"),
("CR56","B003","SG37","2003-4-11"),
("CR74","B003","SG37","2002-11-16"),
("CR62","B007","SA9","2003-3-7");

CREATE TABLE Viewing (
clientNo VARCHAR(20),
propertyNo VARCHAR(20),
viewDate DATE,
comment1 VARCHAR(20));
INSERT INTO Viewing (clientNo,propertyNo,viewDate,comment1)
VALUES ("CR56","PA14","2004-5-24","too small"),
("CR76","PA14","2004-4-20","too remote"),
("CR56","PG4","2004-5-26",NULL),
("CR62","PG4","2004-5-14","no dining room"),
("CR56","PG36","2004-4-28",NULL);

CREATE TABLE PrivateOwner(
ownerNo VARCHAR(20),
fName VARCHAR(20),
IName VARCHAR(20),
address VARCHAR(30),
telNo INT);
INSERT INTO PrivateOwner(ownerNo,fName,IName,address,telNo)
VALUES("CO46","Joe","Keogh","2 Feergus Dr,Aberdeen AB2 7SX",01224861212),
("CO87","Carol","Farrel","6 AChray St, Glasgow G32 9DX", 01413577419),
("CO40","Tina", "Murphy", "63 Well St, Glasgoe G42", 01419431728),
("CO93","Tony","Shaw", "12 Park Pl, Glasgow G4 0QR",01412257025);

CREATE TABLE Client1 (
clientNo VARCHAR(20),
fName VARCHAR(20),
IName VARCHAR(20),
telNo INT,
prefType VARCHAR(20),
maxRent INT);
INSERT INTO Client1 (clientNo,fName,IName,telNo,prefType,maxRent)
VALUES ("CR76","John","Kay",02077745632,"Flat", 425),
("CR56","Aline","Stewart", 01418481825, "Flat",359),
("CR74","Mike","Ritchie", 01475392178,"House",750),
("CR76","Mike","Ritchie", 01224196720,"Flat", 600);

CREATE TABLE PropertyForRent (
propertyNo VARCHAR(20),
street VARCHAR(20),
city VARCHAR(20),
postcode VARCHAR(20),
type1 VARCHAR(20),
rooms INT,
rent INT,
ownerNo VARCHAR(20),
staffNo VARCHAR(20),
branchNo VARCHAR(20));

INSERT INTO PropertyForRent (propertyNo, street, city, postcode, type1, rooms, rent, ownerNo,
staffNo, branchNo)
VALUES ("PA14", "16Holhead", "Aberdeen", "AB7 5SU","House", 6, 650, "CO46", "SA9", "B007"),
("PL94", "6 Argyll St", "London", "NW2", "Flat",4, 400, "CO87", "SL41", "B005"),
("PG4", "6 Lawrence St", "Glasgow", "G11 9QX", "Flat", 3, 350, "CO40", NULL, "B003"),
("PG36", "2 Manor Rd", "Glasgow", "G11 9QX", "Flat", 3, 375, "CO93","SG37", "B003"),
("PG21", "5 Novar Dr", "Glasgow", "G12", "House",5,600,"CO87", "SG37", "B003"),
("PG16", "5 Novar Dr", "Glasgow", "G12 9AX","Flat",4 , 450,"CO93","SG14","B003");

Асуулт хариулт
/*-----------------------------------------------------------------------------------------------------------------
1. Dream Home компанийн Лондон хот дахь салбарын мэдээллийг гарга.
-----------------------------------------------------------------------------------------------------------------*/
SELECT *
FROM branch
WHERE city="London";
/*-----------------------------------------------------------------------------------------------------------------
2.Dream Home компанийн 1965 оноос өмнө төрсөн эмэгтэй ажилчдын
мэдээллийг гарга.
-----------------------------------------------------------------------------------------------------------------*/
SELECT *
FROM staff
WHERE DOB LIKE "1965%";
/*-----------------------------------------------------------------------------------------------------------------
3.Dream Home компанийн 15000-аас бага цалинтай ажилчдын
мэдээллийг гарга.
-----------------------------------------------------------------------------------------------------------------*/
SELECT*
FROM staff
WHERE salary<15000;

/*-----------------------------------------------------------------------------------------------------------------
4.Үл хөдлөх хөрөнгийн хүснэгтээс зөвхөн байшингийн (house)
-----------------------------------------------------------------------------------------------------------------*/
мэдээллийг гарга.
SELECT *
FROM propertyforrent
WHERE type1="House";

/*-----------------------------------------------------------------------------------------------------------------
5.5 өрөөтэй байшингийн мэдээллийг устга.
-----------------------------------------------------------------------------------------------------------------*/
DELETE FROM propertyforrent WHERE rooms=5;

/*-----------------------------------------------------------------------------------------------------------------
6.Үл хөдлөх хөрөнгө үзсэн хүснэгтийн 2004-05-14 өдрийн мэдээллийг
-----------------------------------------------------------------------------------------------------------------*/
2004-05-10 болгож засварла.
UPDATE viewing
SET viewDate="2004-05-10"
WHERE viewDate="2004-05-14";
