use sys;
CREATE TABLE personel
    (
        id int PRIMARY KEY , 
        isim VARCHAR(50), 
        sehir VARCHAR(50), 
        maas int, 
        sirket VARCHAR(20)
        
    );


    INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
    INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
    commit;
    -- ALTER USER ‘root’@‘localhost’ identifield by ‘1234’;
     alter user 'root'@'localhost' IDENTIFIED  by '1234';
   
   
   
   CREATE TABLE bolumler (
      bolum_id   int PRIMARY KEY,
      bolum_isim VARCHAR(14),
      konum      VARCHAR(13)
    );
    
    INSERT INTO bolumler VALUES (10,'MUHASEBE','IST');
    INSERT INTO bolumler VALUES (20,'MUDURLUK','ANKARA');
    INSERT INTO bolumler VALUES (30,'SATIS','IZMIR');
    INSERT INTO bolumler VALUES (40,'ISLETME','BURSA');
    INSERT INTO bolumler VALUES (50,'DEPO', 'YOZGAT');

    CREATE TABLE personel (
      id   int PRIMARY KEY,
      isim VARCHAR(10),
      meslek        VARCHAR(9),
      mudur_id      int,
      maas          int,
      bolum_id      int
    );
    
 
  
    INSERT INTO personel VALUES (7369,'AHMET','KATIP',1111,800,20);
    INSERT INTO personel VALUES (7499,'BAHATTIN','SATISE',1222,1600,30);
    INSERT INTO personel VALUES (7521,'NESE','SATISE',1222,1250,30);
    INSERT INTO personel VALUES (1111,'MUZAFFER','MUDUR',7839,2975,20);
    INSERT INTO personel VALUES (7654,'MUHAMMET','SATISE',1222,1250,30);
    INSERT INTO personel VALUES (1222,'EMINE','MUDUR',7839,2850,30);
    INSERT INTO personel VALUES (1333,'HARUN','MUDUR',7839, 2450,10);
    INSERT INTO personel VALUES (7788,'MESUT','ANALIST',1111,3000,20);
    INSERT INTO personel VALUES (7839,'SEHER','BASKAN',NULL,5000,10);
    INSERT INTO personel VALUES (7844,'DUYGU','SATISE',1222,1500,30);
    INSERT INTO personel VALUES (7876,'ALI','KATIP',1111,1100,20);
    INSERT INTO personel VALUES (7900,'MERVE','KATIP',1222,950,30);
    INSERT INTO personel VALUES (7902,'NAZLI','ANALIST',1111,3000,20);
    INSERT INTO personel VALUES (7934,'EBRU','KATIP',1333,1300,10);
    INSERT INTO personel VALUES (7956,'SIBEL','MIMAR',1333,3300,60);
    INSERT INTO personel VALUES (7933,'ZEKI','MUHENDIS',1333,4300,60);
    
     commit;
     select * from personel;
     select * from bolumler;
     
     CREATE TABLE calisanlar
    (
        id CHAR(4),
        isim VARCHAR(50),
        maas int,
        CONSTRAINT id_pk PRIMARY KEY (id)
    );

    INSERT INTO calisanlar VALUES('1001', 'Ahmet Aslan', 7000);
    INSERT INTO calisanlar VALUES( '1002', 'Mehmet Yılmaz' ,12000);
    INSERT INTO calisanlar VALUES('1003', 'Meryem ', 7215);
    INSERT INTO calisanlar VALUES('1004', 'Veli Han', 5000);
 
    CREATE TABLE aileler
    (
        id CHAR(4),
        cocuk_sayisi VARCHAR(50),
        ek_gelir int,
        CONSTRAINT id_fk FOREIGN KEY (id) REFERENCES calisanlar(id)
    );
    
    INSERT INTO aileler VALUES('1001', 4, 2000);
    INSERT INTO aileler VALUES('1002', 2, 1500);
    INSERT INTO aileler VALUES('1003', 1, 2200);
    INSERT INTO aileler VALUES('1004', 3, 2400);
    
       
    -- 2) Veli Han'ın maaşına %20 zam yapınız.
    UPDATE calisanlar
    SET maas = maas * 1.2
    WHERE isim = 'Veli Han';
   
   -- 3) Maaşı ortalamanın altında olanlara %20 zam yapınız.
    UPDATE calisanlar
    SET maas = maas * 1.2
    WHERE maas <  (SELECT AVG(maas) 
                   FROM (select * from calisanlar)as liste); 
                
    SELECT * FROM calisanlar;
    
    
    -- 4) calisanların isim ve cocuk_sayisi'ni listeyen sorguyu yazınız.
    SELECT isim, (SELECT cocuk_sayisi FROM aileler
                 WHERE calisanlar.id = aileler.id) as cocuk_sayisi
    FROM calisanlar;
    
    -- Alternatif yol
    SELECT isim, cocuk_sayisi FROM calisanlar, aileler
    WHERE calisanlar.id = aileler.id; 
 
        
    -- 5) calisanlar' ın  isim ve toplam_gelir'lerini gösteren bir sorgu yazınız. 
          -- toplam_gelir = calisanlar.maas + aileler.ek_gelir 
    
    SELECT id, isim, (SELECT maas + ek_gelir FROM aileler
                      WHERE calisanlar.id = aileler.id) as toplam_gelir
    FROM calisanlar;
    
    -- Alternatif kısa yol
    SELECT isim,(maas+ek_gelir) as toplam_gelir
    FROM calisanlar, aileler  
    WHERE calisanlar.id = aileler.id;
     
    -- 6) eğer bir ailenin kişi başı geliri 2000 TL den daha az ise o çalışanın
           -- maaşına ek %10 aile yardım zammı yapınız. 
           -- kisi_basi_gelir = toplam_gelir / cocuk_sayisi + 2 (anne ve baba)
    
    UPDATE calisanlar 
    SET maas = maas * 1.1   
    WHERE (SELECT (maas + ek_gelir)/(cocuk_sayisi + 2) FROM aileler
          WHERE calisanlar.id = aileler.id) < 2000;  
    
 select * from calisanlar;
     
    /* ========================== HASTA PROJESI =================================*/   
    
     
    CREATE TABLE hastaneler
    (
        id CHAR(5) PRIMARY KEY,
        isim VARCHAR(50),
        sehir VARCHAR(10),
        ozel CHAR(1)
    );
    
    INSERT INTO hastaneler VALUES('H101', 'ACI MADEM HASTANESI', 'ISTANBUL', 'Y');
    INSERT INTO hastaneler VALUES('H102', 'HASZEKI HASTANESI', 'İSTANBUL', 'N');
    INSERT INTO hastaneler VALUES('H103', 'MEDIKOL HASTANESI', 'IZMIR', 'Y');
    INSERT INTO hastaneler VALUES('H104', 'NEMORYIL HASTANESI', 'ANKARA', 'Y');
    
    CREATE TABLE hastane_bolumler
    (
        bolum_id CHAR(5) PRIMARY KEY,
        bolum_adi VARCHAR(20)
    ); 
    
    INSERT INTO hastane_bolumler VALUES('DHL', 'Dahiliye');
    INSERT INTO hastane_bolumler VALUES('KBB', 'Kulak-Burun-Boğaz');
    INSERT INTO hastane_bolumler VALUES('NRJ', 'Noroloji');
    INSERT INTO hastane_bolumler VALUES('GAST', 'Gastoroloji');
    INSERT INTO hastane_bolumler VALUES('KARD', 'Kardioloji');
    INSERT INTO hastane_bolumler VALUES('PSK', 'Psikiyatri');
    INSERT INTO hastane_bolumler VALUES('GOZ', 'Goz Hastaliklari');
     
    CREATE TABLE hastalar
    (
        kimlik_no CHAR(11) PRIMARY KEY,
        isim VARCHAR(20),
        teshis VARCHAR(30)
    );
    
    INSERT INTO hastalar VALUES('12345678901', 'Ali Can','Gizli Seker');
    INSERT INTO hastalar VALUES('45678901121', 'Ayşe Yılmaz','Hipertansiyon');
    INSERT INTO hastalar VALUES('78901123451', 'Steve Job','Pankreatit');
    INSERT INTO hastalar VALUES('12344321251', 'Tom Hanks','COVID19');
    
    CREATE TABLE hasta_kayitlar
    (
        kimlik_no CHAR(11),
        hast_isim VARCHAR(20),
        hastane_adi VARCHAR(50),
        bolum_adi VARCHAR(20), 
        teshis VARCHAR(30)
    ); 
    
    INSERT INTO hasta_kayitlar VALUES('1111','NONAME','','','');
    INSERT INTO hasta_kayitlar VALUES('2222','NONAME','','','');
    INSERT INTO hasta_kayitlar VALUES('3333','NONAME','','','');
    INSERT INTO hasta_kayitlar VALUES('4444','NONAME','','','');
    INSERT INTO hasta_kayitlar VALUES('5555','NONAME','','','');
   
    
   

    SELECT * FROM hastaneler;
    SELECT * FROM bolumler;
    SELECT * FROM hastalar;
    SELECT * FROM hasta_kayitlar;
  
    
    UPDATE hasta_kayitlar
    SET hast_isim = (SELECT isim FROM hastalar
                    WHERE isim = 'Ali Can'),
                    
        hastane_adi = (SELECT isim FROM hastaneler
                        WHERE id = 'H104'),            
    
        bolum_adi = (SELECT bolum_adi FROM hastane_bolumler
                        WHERE bolum_id = 'DHL'), 
                        
        teshis = (SELECT teshis FROM hastalar
                    WHERE isim  = 'Ali Can'),
                    
        kimlik_no = (SELECT kimlik_no FROM hastalar
                    WHERE isim  = 'Ali Can')
    
    WHERE kimlik_no = '1111';
   
   
    UPDATE hasta_kayitlar
    SET hast_isim = (SELECT isim FROM hastalar
                    WHERE isim = 'Ayşe Yılmaz'),
                    
        hastane_adi = (SELECT isim FROM hastaneler
                        WHERE id = 'H103'),            
    
        bolum_adi = (SELECT bolum_adi FROM hastane_bolumler
                        WHERE bolum_id = 'KBB'), 
                        
        teshis = (SELECT teshis FROM hastalar
                    WHERE isim  = 'Tom Hanks'),
                    
        kimlik_no = (SELECT kimlik_no FROM hastalar
                    WHERE isim  = 'Steve Job')
    
    WHERE kimlik_no = '2222';
   
   	UPDATE hasta_kayitlar
   	
   	SET hast_isim = 'Salvadore Dali',
                    
        hastane_adi = 'John Hopkins',           
    
        bolum_adi = 'Noroloji', 
                        
        teshis = 'Parkinson',
                    
        kimlik_no = '99991111222'
       
    WHERE kimlik_no = '3333';
   
     select * from isciler;
     
     
     