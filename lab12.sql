use Dreamhome;
use hotel;
select* from hotel;
select*from branch;
select*from staff;
select*from client1;
select*from propertyForrent;
select*from viewing;
select*from registration;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SET SQL_SAFE_UPDATES = 0;
SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 0;


/*-----------------------------------------------------------------------------------------------------------------
1. Бүртгэлийн хүснэгтээс хэн хэнтэй ажилласныг нэг өгүүлбэрээр буюу 1 баганад оруулж
харуулна уу. Жишээ: L.Julie 1 sariin 2-nd London-n salbart K.John-toi ajiljee.
SUBSTRING, CONCAT функцуудыг ашиглана уу.
-----------------------------------------------------------------------------------------------------------------*/
select concat(c.fName," " , c.IName)
from registration r, client1 c
where r.clientNo=c.clientNo and r.dateJoined="2004-01-02" ;

select * 
from registration r, client1 c
where r.clientNo=c.clientNo and r.dateJoined="2004-01-02" ;

select concat(substring(s.IName,1,1),"." , s.fName, " ", month(r.dateJoined) ," sarin ", day(r.dateJoined), "-nd "
, b.city, "-n salbart ", substring(c.IName,1,1), ".", c.fName, "-toi ajiljee." ) as uguulber
from registration r, client1 c, staff s, branch b
where r.clientNo=c.clientNo and r.staffNo=s.staffNo and r.branchNo=b.branchNo and r.dateJoined="2004-01-02";
/*-----------------------------------------------------------------------------------------------------------------
2. StaffInfo хүснэгт үүсгэнэ үү. staffNo, fullName, position, branchAddress, propCount,
clientCount гэсэн багануудтай. Хүснэгтэнд query ашиглан өгөгдөл оруулна уу.
-----------------------------------------------------------------------------------------------------------------*/
select *from staffInfo;
drop table staffInfo;
create table staffInfo
select s.staffNo ,concat(s.fName," ",s.IName)as fullName ,concat(b.city, " ", b.street) as branchAddress, s.position1, count(p.propertyNo) as propCount
from branch b, staff s, propertyforrent p
where p.staffNo=s.staffNo and s.branchNo=b.branchNo
group by p.staffNo;
/*-----------------------------------------------------------------------------------------------------------------
3. B003 салбарын хариуцан ажиллаж байгаа үл хөдлөх хөрөнгийн үнийг 15%-аар
нэмэгдүүлнэ үү.
-----------------------------------------------------------------------------------------------------------------*/
update propertyforrent 
set rent = rent+ rent*0.15
where branchNo = "B003";

/*-----------------------------------------------------------------------------------------------------------------
4. Tony Shaw-н үл хөдлөх хөрөнгийн үнийг 400, ажилтны дугаарыг SA9 болгоно уу.
-----------------------------------------------------------------------------------------------------------------*/
update propertyforrent 
set rent = 400, staffNo = "SA9"
where fName = "Kay" and registration.clientNo=client1.clientNo and registration.staffNo=propertyforrent.staffNo;
/*-----------------------------------------------------------------------------------------------------------------
5. Үл хөдлөх хөрөнгийн үнийг 15%-аар нэмэгдүүлнэ үү.
-----------------------------------------------------------------------------------------------------------------*/
update propertyforrent 
set rent = rent+ rent*0.15;

/*-----------------------------------------------------------------------------------------------------------------
6. Бүртгэлийн хүснэгтэд 4-р сард бүртгэсэн мэдээллийг 5-н сар болгож өөрчилнө үү.
DATE_ADD функцийг ашиглана уу.
-----------------------------------------------------------------------------------------------------------------*/
update registration
set DATEADD=(month, 4, 5);
/*-----------------------------------------------------------------------------------------------------------------
7. Үл хөдлөх хөрөнгийн нөөц хүснэгтээс хариуцах ажилтангүй мэдээллийг устгана уу.
-----------------------------------------------------------------------------------------------------------------*/
delete from propertyforrent 
where staffNo=" ";
/*-----------------------------------------------------------------------------------------------------------------
8. Үл хөдлөх хөрөнгийн нөөц хүснэгтээс 16 Argyll St гудамжинд байрладаг, House төрлийн
орон сууцны мэдээллийг устгана уу.
 -----------------------------------------------------------------------------------------------------------------*/

 delete from propertyforrent 
 where street="16 Argyll St" and type1="flat";
/*-----------------------------------------------------------------------------------------------------------------
1.Зочид буудлын захиалгын мэдээллийг нэг өгүүлбэрт оруулж харуул.  Жишээ: Бат"Улаанбаатар" зочид буудлын 45000 үнэтэй "
VIP"  өрөөнд2020-10-01-нд буудаллажээ.
 -----------------------------------------------------------------------------------------------------------------*/
 Select concat(g.guestName, " " , h.hotelName, " zochid buudlin ", r.price, " unetei ", r.roomNo, " uruund ", b.dateFrom, "-nd buudaljee.")
 from booking b, hotel h, guest g, room r
 where b.guestNo=g.guestNo and b.hotelNo=h.hotelNo and b.roomNo=r.roomNo;

/*-----------------------------------------------------------------------------------------------------------------
2.Зочид буудлуудын хамгийн хямд үнэтэй, шууд захиалахболомжтойөрөөнүүдиййн мэдээллийг шүүжхаруулнауу.
 -----------------------------------------------------------------------------------------------------------------*/
select *
from room 
where roomNo not in (select roomNo from booking
						where now() not between dateFrom and dateTo);
/*-----------------------------------------------------------------------------------------------------------------
3.Хамгийн цөөн тоогоор захиалга авсан зочид буудлын өрөөний  мэдээллийгүнийгньөсөхөөрэрэмбэлжгарганауу.
 -----------------------------------------------------------------------------------------------------------------*/
 select* 
 from room 
 where roomNo in (select roomNo from booking 
					where hotelNo= (select hotelNo from booking
					group by hotelNo
					having count(roomNo) <=all(select count(roomNo) from booking 
					group by hotelNo)));
 
 
/*-----------------------------------------------------------------------------------------------------------------
4.Зочид буудал бүрийн сүүлийн3сарын хугацаанд буудалласан зочдын  мэдээллийг харуул.
 -----------------------------------------------------------------------------------------------------------------*/
SELECT DISTINCT guest.* FROM guest 
INNER JOIN booking ON guest.guestNo = booking.guestNo 
WHERE DATE_ADD(booking.dateFrom, INTERVAL -3 MONTH) < NOW() AND booking.dateFrom < NOW(); 
/*-----------------------------------------------------------------------------------------------------------------
5.Зочид буудал бүрт хамгийн олон удаа буудалласан 1, 1 зочнымэдээллийгхаруулнауу.
 -----------------------------------------------------------------------------------------------------------------*/
 SELECT guest.*, booking.hotelNo FROM guest 
INNER JOIN booking ON guest.guestNo = booking.guestNo 
WHERE guest.guestNo IN (SELECT guestNo FROM booking 
GROUP BY hotelNo 
HAVING COUNT(hotelNo) >= ALL (SELECT COUNT(hotelNo) FROM booking 
GROUP BY guestNo)) 
GROUP BY booking.hotelNo; 

/*-----------------------------------------------------------------------------------------------------------------
6.Зочид буудлын нөөц хүснэгт үүсгэж мэдээллийг хуулж оруулах query  бичнэүү.
 -----------------------------------------------------------------------------------------------------------------*/
 create table HotelBackup as 
 select* from hotel;
/*-----------------------------------------------------------------------------------------------------------------
7.HotelInformation гэсэн хүснэгт үүсгэж query-ээр тохирох  өгөгдлүүдийгоруулнауу. HotelInformation(HotelNo, HotelName,  
RoomCount, MaxPrice, MinPrice, AvgPrice,City)
 -----------------------------------------------------------------------------------------------------------------*/
 create table HotelInformation as
 select h.hotelNo, h.hotelName, count(r.roomNo) as roomNo, max(r.price) as maxPrice, min(r.price) as MinPrice, avg(r.price)
 as avgPrice, h.city 
 from hotel h, room r
 where h.hotelNo=r.hotelNo;
/*-----------------------------------------------------------------------------------------------------------------
8.Чингис зочид буудлын өрөөний үнийг0.2 хувиарнэмэгдүүлнэүү.
 -----------------------------------------------------------------------------------------------------------------*/
update room
set price = price +price*0.2
where hotelNo = (Select hotelNo From hotel
					where hotelName = "Dune")
