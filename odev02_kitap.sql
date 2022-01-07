create table ogrenci(
ogr_no int,
ogr_ad varchar(45),
ogr_soyad varchar(45),
 cinsiyet varchar(45),
sinif varchar(45)
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
select * from ogrenci;



create table kitaplar(
 kitap_no int,
 yazar_no int,
 tur_no  int,
 sayfa_sayisi int
);
INSERT INTO kitaplar VALUES (1,26,3,368);
INSERT INTO kitaplar VALUES (2,6,1,220);
INSERT INTO kitaplar VALUES (3,18,6,311);
INSERT INTO kitaplar VALUES (4,22,4,135);
INSERT INTO kitaplar VALUES (5,10,3,179);
INSERT INTO kitaplar VALUES (6,25,1,242);
INSERT INTO kitaplar VALUES (7,22,3,346);
INSERT INTO kitaplar VALUES (8,28,6,389);
INSERT INTO kitaplar VALUES (9,6,4,259);
INSERT INTO kitaplar VALUES (10,27,2,391);
INSERT INTO kitaplar VALUES (11,19,6,89);
INSERT INTO kitaplar VALUES (12,6,4,265);
INSERT INTO kitaplar VALUES (13,20,6,160);
INSERT INTO kitaplar VALUES (14,27,5,383);
INSERT INTO kitaplar VALUES (15,5,6,188);
select * from kitaplar;
create table islemler(
tur_no int,
tur_adi varchar(45)
);
INSERT INTO islemler VALUES (1,'Dram');
INSERT INTO islemler VALUES (2,'Komedi');
INSERT INTO islemler VALUES (3,'Roman');
INSERT INTO islemler VALUES (4,'Hikaye');
INSERT INTO islemler VALUES (5,'Arastirma');
INSERT INTO islemler VALUES (6,'Fikra');
INSERT INTO islemler VALUES (7,'Deneme');
select * from islemler;
-- Örnek 1: Hangi isimden kaç tane olduğunu bulun.
select ogr_ad, count(ogr_ad) from ogrenci group by ogr_ad;

-- Örnek 2: Sınıflardaki öğrenci sayısını bulun.
 select sinif, count(ogr_no) from ogrenci group by sinif;
 
  
  -- Örnek 3: Her sınıftaki erkek ve kız öğrenci sayısını bulun.(cinsiyet ve sinifa göre grupla)
select cinsiyet,count(cinsiyet) from ogrenci group by cinsiyet;


-- Örnek 4: Her türden kaç ltane kitap olduğunu listeleyiniz.
select tur_adi from islemler
union all
select count(kitap_no) from kitaplar group by tur_no;
 -- Örnek 5: Her türdeki en fazla sayfa sayısı olan kitapları listeleyiniz.
 select tur_adi from islemler
union
 select max(sayfa_sayisi) from kitaplar group by tur_no;
-- Örnek 6: Her türdeki en az sayfa sayısı olan kitapları listeleyiniz.
 select tur_adi from islemler
union
 select min(sayfa_sayisi) from kitaplar group by tur_no;
 -- Örnek 7***: Her türden kaç tane kitap olduğunu listeleyiniz.(Tür isimleri de olsun) (edited) */
select i.tur_adi,count(k.kitap_no) kitap_sayisi from islemler i 
inner join kitaplar k
on i.tur_no=k.tur_no group by i.tur_adi;






