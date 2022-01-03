/*==================================
	TABLO OLUŞTURMA(CRUD-creat)
  ==================================*/
  drop table student;
  create table student (
  id varchar(4),
  name varchar(25),
  age int
  );
  /* ========================================================= 
                     VERİ GİRİSİ 
===========================================================*/
INSERT INTO student VALUES('1001', 'MEHMET ALİ', 25);
INSERT INTO student VALUES('1002', 'AYSE YILMAZ', 34);
INSERT INTO student VALUES('1003', 'JOHN STAR', 56);
INSERT INTO student VALUES('1004', 'MARY BROWN', 17);

/* ========================================================= 
                     PARÇALI VERİ GİRİŞİ 
===========================================================*/
INSERT INTO student(name, age ) VALUES('SAMET AY',24);
/* ========================================================= 
                     TABLODAN VERİ SORGULAMA 
===========================================================*/
SELECT * FROM STUDENT;
/* ========================================================= 
                     TABLO SİLME (CRUD-DROP)
===========================================================*/
DROP TABLE urunler;

