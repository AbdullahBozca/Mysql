CREATE TABLE people 
(
    ssn CHAR (9),
    name VARCHAR(50),
    address VARCHAR(80)
);
drop table people;
INSERT INTO PEOPLE VALUES (123456789, 'Mark Star', 'Florida');
INSERT INTO PEOPLE VALUES (234567890, 'Angie Way', 'Virginia');
INSERT INTO PEOPLE VALUES (345678901, 'Marry Tien', 'New Jersey');
INSERT INTO PEOPLE (ssn, address) VALUES (456789012, 'Michigan');
INSERT INTO PEOPLE (ssn, address) VALUES (567890123, 'California');
INSERT INTO PEOPLE (ssn, name) VALUES (567890123, 'California');
SELECT * FROM PEOPLE ;
-- Boş adları "ad daha sonra eklenecek" olarak değiştirin
update people set name='Ad daha sonra eklenecek' where name is null;
-- Boş adresleri 'Adres daha sonra eklenecek' olarak değiştirin
update people set address='Adres daha sonra eklenecek' where address is null;
-- people tablosunda 'Daha sonra eklenecek' tüm boş değerleri değiştirin
update people set name = coalesce(name,'daha sonra eklenecek') ;

-- Create işçi tablosu alanları worker_id,work_name,work_salary şeklindedir.
-- worker_id, worker_id_pk adında primary key sahip olacak
-- İşçiler tablosuna 4 kayıt ekleyin
-- Konsoldaki tabloya bakın
CREATE TABLE worker 
(
    worker_id char(3),
    worker_name VARCHAR(50),
    worker_salary int not null,
     CONSTRAINT worker_id_pk PRIMARY KEY (worker_id)
);
drop table worker;
INSERT INTO WORKER VALUES ('100','Ali can', 1200);
INSERT INTO WORKER VALUES ('102','Veli Han', 2000);
INSERT INTO WORKER VALUES ('103','Ayse Kan', 7000);
INSERT INTO WORKER VALUES ('104', 'Angie Ocean', 8500);
SELECT * FROM WORKER ;
-- Veli Han'ın maaşını en yüksek maaştan yüzde 20 daha azına artırin
UPDATE WORKER
SET worker_salary=(SELECT max(worker_salary) FROM (SELECT *FROM WORKER) AS W )-((SELECT MAX(worker_salary) FROM (SELECT * FROM WORKER )AS V)*0.20)
WHERE worker_name='Veli Han';
-- Ali Can'ın maaşını en düşük maaştan yüzde 30 daha fazla düşürun
update worker SET worker_salary=(SELECT min(worker_salary) FROM (SELECT *FROM WORKER) AS W )-((SELECT min(worker_salary) FROM (SELECT * FROM WORKER )AS V)*0.70) where worker_name='Ali Can';
-- Maaş ortalama maaştan düşükse maaşları 1000 artırın
update worker set worker_salary=worker_salary+1000 where worker_salary<(select avg(worker_salary) from (select * from worker) as m);
-- Maaşın ortalama maaştan az olması durumunda maaşları ortalama maaşa eşit
update worker set worker_salary=(select avg(worker_salary) from (select * from worker) as o) where worker_salary<(select avg(worker_salary) from (select * from worker) as a);

/*************************************************************************************************************************************************************************************************/
create table kitap
(
idno int PRIMARY KEY,
yazarno int not null,
turno int not null,
sayfasayisi int not null DEFAULT 0
);
DROP TABLE kitap;
INSERT INTO kitap VALUES (1,26,3,368);
INSERT INTO kitap VALUES (2,6,1,220);
INSERT INTO kitap VALUES (3,18,6,311);
INSERT INTO kitap VALUES (4,22,4,135);
INSERT INTO kitap VALUES (5,10,3,179);
INSERT INTO kitap VALUES (6,25,1,242);
INSERT INTO kitap VALUES (7,22,3,346);
INSERT INTO kitap VALUES (8,28,6,389);
INSERT INTO kitap VALUES (9,6,4,259);
INSERT INTO kitap VALUES (10,27,2,391);
INSERT INTO kitap VALUES (11,19,6,89);
INSERT INTO kitap VALUES (12,6,4,265);
INSERT INTO kitap VALUES (13,20,6,160);
INSERT INTO kitap VALUES (14,27,5,383);
INSERT INTO kitap VALUES (15,5,6,188);
create table islemler
(
turno int PRIMARY KEY,
kitap_turu varchar(10) NOT NULL
);
INSERT INTO islemler VALUES (1,'Dram');
INSERT INTO islemler VALUES (2,'Komedi');
INSERT INTO islemler VALUES (3,'Roman');
INSERT INTO islemler VALUES (4,'Hikaye');
INSERT INTO islemler VALUES (5,'Arastirma');
INSERT INTO islemler VALUES (6,'Fikra');
INSERT INTO islemler VALUES (7,'Deneme');
create table ogrenci
(
ogrno int PRIMARY KEY,
ograd VARCHAR(10) NOT NULL,
ogrsoyad VARCHAR(10) NOT NULL,
cinsiyet VARCHAR(1) NOT NULL,
sinif VARCHAR(3) DEFAULT''
);
INSERT INTO ogrenci VALUES (1,'ahmet','cansever','e','10a');
INSERT INTO ogrenci VALUES (2,'niyazi','sevinc','e','11b');
INSERT INTO ogrenci VALUES (3,'ismail ','sevinc','e','10b');
INSERT INTO ogrenci VALUES (4,'kenan','emin','e','9a');
INSERT INTO ogrenci VALUES (5,'sema','bakir','k','9b');
INSERT INTO ogrenci VALUES (6,'beyda','kara','k','9c');
INSERT INTO ogrenci VALUES (7,'betül','coskun','k','11a');
INSERT INTO ogrenci VALUES (8,'sema','rüzgar','k','9c');
INSERT INTO ogrenci VALUES (9,'fadime','dönmez','k','9a');
INSERT INTO ogrenci VALUES (10,'riza','koc','e','10b');
INSERT INTO ogrenci VALUES (11,'beyza','kabak','k','10b');
INSERT INTO ogrenci VALUES (12,'deniz','akcakaya','e','11a');
INSERT INTO ogrenci VALUES (13,'kemal','karapinar','e','11a');
INSERT INTO ogrenci VALUES (14,'derya','yilbur','k','10c');
INSERT INTO ogrenci VALUES (15,'filiz','akat','k','10a');
INSERT INTO ogrenci VALUES (16,'niyazi','dönmez','e','11a');
INSERT INTO ogrenci VALUES (17,'sema','sekmen','k','10b');

-- ---------------------------------------------
-------- Örnek 1: Hangi isimden kaç tane olduğunu bulun.
select ograd, count(ograd) from ogrenci group by ograd;

-------- Örnek 2: Sınıflardaki öğrenci sayısını bulun
select sinif,count(ograd) from ogrenci group by sinif;
-------- Örnek 3: Her sınıftaki erkek ve kız öğrenci sayısını bulun.(cinsiyet ve sinifa göre grupla)
select sınıf, cinsiyet from ogrenci group by sinif,cinsiyet;
-------- Örnek 4: Her türden kaç tane kitap olduğunu listeleyiniz.
SELECT 
    i.kitap_turu, COUNT(k.turno) kitap_sayisi
FROM
    islemler i
        INNER JOIN
    kitap k ON i.turno = k.turno
GROUP BY i.kitap_turu;

-------- Örnek 5: Her türdeki en fazla sayfa sayısı olan kitapları listeleyiniz.

SELECT 
    i.kitap_turu, MAX(k.sayfasayisi) sayfa_sayisi
FROM
    islemler i
        JOIN
    kitap k ON i.turno = k.turno
GROUP BY i.kitap_turu;
-------- Örnek 6: Her türdeki en az sayfa sayısı olan kitapları listeleyiniz.

SELECT 
    i.kitap_turu, MIN(k.sayfasayisi) sayfa_sayisi
FROM
    islemler i
        JOIN
    kitap k ON i.turno = k.turno
GROUP BY i.kitap_turu;
-------- Örnek 7***: Her türden kaç tane kitap olduğunu listeleyiniz.(Tür isimleri de olsun)
SELECT 
    i.kitap_turu, COUNT(k.turno) kitap_sayisi
FROM
    islemler i
        INNER JOIN
    kitap k ON i.turno = k.turno
GROUP BY i.kitap_turu;  







