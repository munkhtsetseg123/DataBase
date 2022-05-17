use Hotel;
create schema hotel;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

CREATE TABLE Hotel(
hotelNo INT,
hotelname VARCHAR (15),
city VARCHAR (15)
);
INSERT INTO Hotel(hotelNo,hotelname,city)
VALUES (1,'Moonlover','LosAngeles'),
(2,'Mahal','Sanfrancisco'),
(3,'Truesight','NewYork'),
(4,'Little','Sandiego'),
(5,'Dune','Boston'),
(6,'Ramada','Ulaanbator'),
(7,'Capella','Thailand'),
(8,'Oberoi','India'),
(9,'Templehouse','Chine'),
(10,'Theoberoi','India');

CREATE TABLE room(
roomNo INT,
hotelNo INT,
bed VARCHAR (5),
price FLOAT (10),
rooms INT
);
INSERT INTO room(roomNo,hotelNo,bed,price,rooms)
VALUES 
(101,1,'one',400,2),
(102,1,'one',400,2),
(103,1,'two',650,3),
(104,1,'three',950,3),
(105,1,'four',1100,4),
(106,1,'four',1200,5),
(107,1,'four',1250,5),
(201,2,'one',300,1),
(202,2,'two',550,3),
(203,2,'two',550,3),
(204,2,'three',750,3),
(205,2,'three',900,4),
(301,3,'two',200,2),
(302,3,'two',300,3),
(303,3,'three',400,3),
(304,3,'five',700,4),
(401,4,'two',400,2),
(402,4,'two',500,3),
(403,4,'three',800,4),
(404,4,'four',1000,4),
(405,4,'four',1150,5),
(501,5,'two',500,3),
(502,5,'two',500,3),
(503,5,'two',600,4),
(504,5,'three',750,5),
(505,5,'three',850,6),
(601,6,'three',500,3),
(602,6,'three',780,4),
(603,6,'four',1200,6),
(604,6,'four',1300,7),
(605,6,'four',1400,8),
(701,7,'one',500,3),
(702,7,'one',700,4),
(703,7,'two',1000,5),
(704,7,'two',1000,5),
(705,7,'two',1150,6),
(801,8,'three',1200,5),
(802,8,'four',1400,6),
(803,8,'four',1550,7),
(901,9,'two',450,4),
(902,9,'two',500,5),
(903,9,'three',600,5),
(904,9,'four',650,5),
(905,9,'four',750,6),
(906,9,'five',800,6),
(1001,10,'one',150,1),
(1002,10,'one',250,2),
(1003,10,'two',320,2),
(1004,10,'two',400,3),
(1005,10,'two',480,3);

CREATE TABLE booking(
hotelNo INT,
roomNo INT,
guestNo INT,
datefrom DATE,
dateto DATE
);
INSERT INTO booking(hotelNo,roomNo,guestNo,datefrom,dateto)
VALUES (1,106,100,'2021-5-20','2022-11-01'),
(2,204,40,'2021-03-20','2022-11-01'),
(3,302,4,'2021-7-1','2021-11-01'),
(4,401,110,'2021-8-25','2021-11-01'),
(5,501,10,'2021-10-23','2021-11-01'),
(6,603,42,'2021-1-1','2021-11-01'),
(6,604,3,'2021-10-21','2021-11-01'),
(7,703,6,'2021-4-20','2021-11-01'),
(8,802,2,'2021-9-12','2021-11-01'),
(9,905,5,'2021-6-4','2021-11-01'),
(10,1004,1,'2011-4-23','2021-11-01');

CREATE TABLE guest(
guestNo INT,
guestName VARCHAR (20),
guestAddress VARCHAR(20),
guestnumber INT
);
INSERT INTO guest(guestNo,guestName,guestAddress,guestnumber)
VALUES (100,'Lenardo','BayngolDistrict',77515452),
(40,'Dunken','SuhkbaatarDistrict',99864587),
(4,'Mark','Okohama',99110000),
(110,'Edward','Vanquer',99999999),
(10,'Kevin','Chicago',88119999),
(42,'Adam','Mexico',88607054),
(6,'Ursa','28thdistrict',88888888),
(2,'Antony','Glasglow',88181111),
(5,'Devid','Glasglow',99123456),
(1,'Dom','London',88765432),
(3,'Ben','Manheten',886532311);

select* from hotel;
select* from room;
select* from guest;
select* from booking;

/*-----------------------------------------------------------------------------------------------------------------
1. Зочид буудлуудын өрөөний дэлгэрэнгүй мэдээллийг гарга. Үүнд хотын нэр,
буудлын нэр, өрөөний дугаар болон үнийн мэдээллийг гаргаж үнээр нь
эрэмбэлнэ үү.
-----------------------------------------------------------------------------------------------------------------*/
select h.city, h.hotelName, r.roomNo, price
from room r, hotel h
where h.hotelNo=r.hotelNo
order by price;

/*-----------------------------------------------------------------------------------------------------------------
2. 100-с 300-н үнэтэй өрөөнүүдийг буудлын мэдээллийн хамтаар харуулна уу.
-----------------------------------------------------------------------------------------------------------------*/
select r.*,h.hotelName, h.city
from room r, hotel h 
where r.hotelNo=h.hotelNo and price between 100 and 300; 

/*-----------------------------------------------------------------------------------------------------------------
 3. Хамгийн олон өрөөтэй зочид буудлын мэдээллийг гаргана уу.
-----------------------------------------------------------------------------------------------------------------*/
select  max(r.rooms), h.*
from hotel h , room r
group by h.hotelNo=r.hotelNo;

/*-----------------------------------------------------------------------------------------------------------------
4. Зочид буудал тус бүр хэдэн өрөөтэй болон өрөөнүүдийн хамгийн хямд, их,
дундаж үнийн мэдээллийг харуулна уу.
-----------------------------------------------------------------------------------------------------------------*/
select  hotelNo, sum(rooms) as sumRooms,max(price) as maxPrice,min(price) as minPrice, avg(price) as avgPrice
from room
group by hotelNo;

/*-----------------------------------------------------------------------------------------------------------------
5. Mark гэсэн нэртэй хүний буудалсан буудлын мэдээлэл, өрөөний мэдээллийг
шүүж гаргана уу.
-----------------------------------------------------------------------------------------------------------------*/
select h.*, r.*, g.guestName
from hotel h, room r, guest g, booking b
where  g.guestName="Mark" and g.guestNo=b.guestNo and b.roomNo=r.roomNo and r.hotelNo=h.hotelNo;

/*-----------------------------------------------------------------------------------------------------------------
6. Өнөөдрийн байдлаар зочинтой байгаа өрөөний дугаар, орны тоо, үнэ,
зочны нэр, утасны дугаар болон тухайн өрөө аль хотод байрладаг ямар
нэртэй буудлын өрөө болохыг харуулна уу. NOW() функцийг ашиглана уу.
-----------------------------------------------------------------------------------------------------------------*/
select r.roomNo, r.bed, r.price,g.guestName, h.city, h.hotelName, now() between b.dateFrom and b.dateTo as zochintoi
from hotel h, room r, booking b, guest g
where h.hotelNo=r.hotelNo and r.roomNo=b.roomNo and b.guestNo=g.guestNo;

/*-----------------------------------------------------------------------------------------------------------------
7. Зочинтой өрөөний захиалга дуусах хугацааг хоногоор харуулна уу.
DATEDIFF() функцийг ашиглана уу.
-----------------------------------------------------------------------------------------------------------------*/
SELECT DATEDIFF(b.dateTo, b.dateFrom) AS duusahognoo, b.roomNo, h.hotelName
FROM booking b, hotel h
WHERE b.hotelNo=h.hotelNo;

/*-----------------------------------------------------------------------------------------------------------------
8. Хамгийн их зочинтой зочид буудлын өрөөний мэдээллийг харуулна уу.
-----------------------------------------------------------------------------------------------------------------*/
select r.*, h.*, count(b.guestNo) as maxzochintoi
from booking b, room r, hotel h
where b.roomNo=r.roomNo and h.hotelNo=r.hotelNo and now() between b.dateFrom and b.dateto;

/*-----------------------------------------------------------------------------------------------------------------
9. 300-с бага үнэтэй өрөө шууд захиалах боломжтой буудлуудын мэдээллийг
гаргана уу.
-----------------------------------------------------------------------------------------------------------------*/
SELECT h.hotelName, r.bed, h.city,r.roomNo,r.price, NOW() BETWEEN b.dateFrom AND b.dateTo =0 AS bolomjtoi
FROM hotel h, Room r, booking b, guest g
WHERE h.hotelNo=r.hotelNo AND r.roomNo=b.roomNo
AND b.guestNo=g.guestNo
AND price > 20000;

/*-----------------------------------------------------------------------------------------------------------------
10. Хамгийн удаан хугацаагаар буудалсан зочны дугаар, нэр, буудлын дугаар,
буудал байрлах хот, өрөөний дугаар, үнийн мэдээллийг гаргана уу.
-----------------------------------------------------------------------------------------------------------------*/
SELECT g.guestNo, g.guestName, h.hotelNo, h.city, r.roomNo, r.price, MAX(DATEDIFF(b.dateTo, b.dateFrom))
FROM hotel h, Room r, booking b, guest g
WHERE h.hotelNo=r.hotelNo AND r.roomNo=b.roomNo
AND b.guestNo=g.guestNo;
