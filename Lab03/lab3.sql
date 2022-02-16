create schema lab01;

create table lab01.uczestnik ( id_uczestnik int, nazwisko varchar(50), imie varchar(50) ) ;
create table lab01.kurs ( id_kurs int, id_grupa int, id_nazwa int, termin varchar(50) ) ;
create table lab01.wykladowca ( id_wykladowca int, nazwisko varchar(50), imie varchar(50) ) ;
create table lab01.kurs_opis ( id_kurs int, opis varchar(50) ) ;
create table lab01.uczest_kurs ( id_uczest int, id_kurs int ) ;
create table lab01.wykl_kurs ( id_wykl int, id_kurs int ) ;

alter table lab01.kurs add primary key (id_kurs) ;
alter table lab01.uczestnik add primary key (id_uczestnik) ;
alter table lab01.wykladowca add primary key (id_wykladowca) ;
alter table lab01.kurs_opis add primary key (id_kurs) ;
alter table lab01.uczest_kurs add primary key (id_uczest, id_kurs) ;
alter table lab01.wykl_kurs add primary key (id_wykl, id_kurs) ;

alter table lab01.uczest_kurs add foreign key (id_uczest) references lab01.uczestnik ( id_uczestnik) ;
alter table lab01.uczest_kurs add foreign key (id_kurs) references lab01.kurs ( id_kurs) ;
alter table lab01.wykl_kurs add foreign key (id_kurs) references lab01.kurs ( id_kurs) ;
alter table lab01.wykl_kurs add foreign key (id_wykl) references lab01.wykladowca ( id_wykladowca) ;
alter table lab01.kurs add foreign key (id_nazwa) references lab01.kurs_opis ( id_kurs) ;



ALTER TABLE "USER"."lab01"."uczest_kurs" DROP CONSTRAINT "uczest_kurs_id_kurs_fkey";

ALTER TABLE "USER"."lab01"."wykl_kurs" DROP CONSTRAINT "wykl_kurs_id_kurs_fkey";

ALTER TABLE ONLY "USER"."lab01"."kurs" ALTER COLUMN "id_grupa" TYPE INTEGER, ALTER COLUMN "id_grupa" SET NOT NULL;

ALTER TABLE ONLY "USER"."lab01"."kurs" ALTER COLUMN "id_nazwa" TYPE INTEGER, ALTER COLUMN "id_nazwa" SET NOT NULL;

ALTER TABLE "USER"."lab01"."kurs" DROP COLUMN "termin";

ALTER TABLE "USER"."lab01"."kurs" ADD COLUMN "termin_rozpoczecia" DATE NOT NULL;

ALTER TABLE "USER"."lab01"."kurs" ADD COLUMN "termin_zakonczenia" DATE NOT NULL;

ALTER TABLE "USER"."lab01"."kurs" DROP CONSTRAINT "kurs_pkey";

ALTER TABLE "USER"."lab01"."kurs" ADD PRIMARY KEY ("id_grupa","id_kurs");

ALTER TABLE "USER"."lab01"."uczest_kurs" ADD COLUMN "id_grupa" INTEGER NOT NULL;

ALTER TABLE "USER"."lab01"."uczest_kurs" DROP CONSTRAINT "uczest_kurs_pkey";

ALTER TABLE "USER"."lab01"."uczest_kurs" ADD PRIMARY KEY ("id_uczest","id_grupa","id_kurs");

ALTER TABLE "USER"."lab01"."wykl_kurs" ADD COLUMN "id_grupa" INTEGER NOT NULL;

ALTER TABLE "USER"."lab01"."wykl_kurs" DROP CONSTRAINT "wykl_kurs_pkey";

ALTER TABLE "USER"."lab01"."wykl_kurs" ADD PRIMARY KEY ("id_wykl","id_grupa","id_kurs");

ALTER TABLE "USER"."lab01"."uczest_kurs" ADD CONSTRAINT "uczest_kurs_id_kurs_fkey"
FOREIGN KEY ("id_kurs", "id_grupa")
REFERENCES "USER"."lab01"."kurs" ("id_kurs", "id_grupa")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "USER"."lab01"."wykl_kurs" ADD CONSTRAINT "wykl_kurs_id_kurs_fkey"
FOREIGN KEY ("id_kurs", "id_grupa")
REFERENCES "USER"."lab01"."kurs" ("id_kurs", "id_grupa")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

insert into lab01.uczestnik ( id_uczestnik, nazwisko, imie ) values 
( 1, 'Flisikowski', 'Jan'),
( 2, 'Olech', 'Andrzej'       ),
( 3, 'Płochocki', 'Piotr'    ),
( 4, 'Stachyra', 'Krzysztof' ),
( 5, 'Sztuka', 'Stanisław'   ),
( 6, 'Sosin', 'Tomasz'       ),
( 7, 'Głowala', 'Paweł'      ),
( 8, 'Straszewski', 'Józef'  ),
( 9, 'Dwojak', 'Marcin'      ),
(10, 'Kotulski', 'Marek'    ),
(11, 'Łaski', 'Michał'       ),
(12, 'Iwanowicz', 'Grzegorz' ),
(13, 'Barnaś', 'Jerzy'       ),
(14, 'Stachera', 'Tadeusz'   ),
(15, 'Gzik', 'Adam'          ),
(16, 'Całus', 'Łukasz'       ),
(17, 'Kołodziejek', 'Zbigniew'),
(18, 'Bukowiecki', 'Ryszard' ),
(19, 'Sielicki', 'Dariusz'   ),
(20, 'Radziszewski', 'Henryk'),
(21, 'Szcześniak', 'Mariusz' ),
(22, 'Nawara', 'Kazimierz'   ),
(23, 'Kęski', 'Wojciech'     ),
(24, 'Rafalski', 'Robert'    ),
(25, 'Hołownia', 'Mateusz'   ),
(26, 'Niedziałek', 'Marian'  ),
(27, 'Matuszczak', 'Rafał'   ),
(28, 'Wolf', 'Jacek'         ),
(29, 'Kolczyński', 'Janusz'  ),
(30, 'Chrobok', 'Mirosław'   )  ;

insert into lab01.kurs_opis ( id_kurs, opis ) values
( 1, 'Język angielski, stopień 1'),
( 2, 'Język angielski, stopień 2'),
( 3, 'Język angielski, stopień 3'), 
( 4, 'Język angielski, stopień 4'),
( 5, 'Język angielski, stopień 5'),
( 6, 'Język niemiecki, stopień 1'),
( 7, 'Język niemiecki, stopień 2'),
( 8, 'Język niemiecki, stopień 3'),
( 9, 'Język niemiecki, stopień 4'),
(10, 'Język hiszpański, stopień 1'),
(11, 'Język hiszpański, stopień 2'),
(12, 'Język hiszpański, stopień 3') ;

insert into lab01.wykladowca ( id_wykladowca, imie, nazwisko ) values 
( 1, 'Marcin','Szymczak'),
( 2, 'Joanna','Baranowska'),
( 3, 'Maciej','Szczepański'),
( 4, 'Czesław','Wróbel'),
( 5, 'Grażyna','Górska'),
( 6, 'Wanda','Krawczyk'),
( 7, 'Renata','Urbańska'),
( 8, 'Wiesława','Tomaszewska'),
( 9, 'Bożena','Baranowska'),
(10, 'Ewelina','Malinowska'),
(11, 'Anna','Krajewska'),
(12, 'Mieczysław','Zając'),
(13, 'Wiesław','Przybylski'),
(14, 'Dorota','Tomaszewska'),
(15, 'Jerzy','Wróblewski') ;

insert into lab01.kurs ( id_kurs, id_grupa, id_nazwa, termin_rozpoczecia, termin_zakonczenia) values
( 1, 1, 1, '1-01-2021', '31-03-2021'),
( 2, 2, 1, '1-01-2021', '31-03-2021'),
( 3, 1, 2, '1-04-2021', '30-06-2021'),
( 4, 1, 3, '1-08-2021', '10-10-2021'),
( 5, 1, 4, '1-11-2021', '23-12-2021'),
( 6, 1, 6, '1-01-2021', '31-03-2021'),
( 7, 2, 6, '1-01-2021', '31-03-2021'),
( 8, 1, 7, '1-04-2021', '30-06-2021'),
( 9, 1, 8, '1-07-2021', '31-07-2021'),
(10, 1, 10, '1-02-2021', '31-05-2021'),
(11, 1, 11, '1-09-2021', '30-11-2021') ;

insert into lab01.wykl_kurs ( id_kurs, id_grupa, id_wykl ) values
( 1, 1, 1 ),
( 2, 2, 2 ),
( 3, 1, 1 ),
( 4, 1, 1 ),
( 5, 1, 3 ),
( 6, 1, 4 ),
( 7, 2, 5 ),
( 8, 1, 4 ),
( 9, 1, 4 ),
(10, 1, 11 ),
(11, 1, 11 ) ; 

insert into lab01.uczest_kurs ( id_kurs, id_uczest, id_grupa ) values
( 1, 1, 1 ),
( 1, 3, 1 ),
( 1, 5, 1 ),
( 1, 7, 1 ),
( 1, 8, 1 ),
( 1, 10, 1 ),
( 1, 11, 1 ),
( 1, 12, 1 ),
( 2, 2, 2 ),
( 2, 16, 2 ),
( 2, 17, 2 ),
( 2, 18, 2 ),
( 2, 20, 2 ),
( 3, 1, 1 ),
( 3, 2, 1 ),
( 3, 3, 1 ),
( 3, 5, 1 ),
( 3, 7, 1 ),
( 3, 17, 1 ),
( 3, 18, 1 ),
( 3, 20, 1 ),
( 4, 1, 1 ),
( 4, 2, 1 ),
( 4, 3, 1 ),
( 4, 5, 1 ),
( 4, 21, 1),
( 4, 22, 1 ),
( 4, 25, 1 ),
( 5, 1, 1 ),
( 5, 2, 1 ),
( 5, 3, 1 ),
( 5, 5, 1 ),
( 5, 21, 1 ),
( 5, 22, 1 ),
( 6, 8, 1 ),
( 6, 9, 1 ),
( 6, 13, 1 ),
( 6, 15, 1 ),
( 6, 19, 1 ),
( 6, 24, 1 ),
( 6, 27, 1 ),
( 7, 11, 2 ),
( 7, 17, 2 ),
( 7, 18, 2 ),
( 7, 23, 2 ),
( 7, 25, 2 ),
( 7, 28, 2 ),
( 7, 30, 2 ),
( 8, 8, 1 ),
( 8, 9, 1 ),
( 8, 13, 1 ),
( 8, 15, 1 ),
( 8, 19, 1 ),
( 8, 24, 1 ),
( 8, 27, 1 ),
( 9, 8, 1 ),
( 9, 9, 1 ),
( 9, 13, 1 ),
( 9, 24, 1 ),
( 9, 27, 1 ),
(10, 6, 1 ),
(10, 16, 1 ),
(10, 18, 1 ),
(10, 22, 1 ),
(10, 24, 1 ),
(10, 29, 1 ),
(10, 30, 1 ),
(11, 6, 1 ),
(11, 16, 1 ),
(11, 18, 1 ),
(11, 22, 1 ),
(11, 24, 1 ),
(11, 29, 1 ),
(11, 30, 1 ) ;



select nazwisko, imie, ko.opis, ku.id_Kurs, uck.id_grupa, ku.termin_rozpoczecia, ku.termin_zakonczenia
FROM lab01.Uczestnik uc
JOIN lab01.uczest_kurs uck ON uc.id_uczestnik=uck.id_uczest
JOIN lab01.Kurs ku ON uck.id_kurs=ku.id_kurs
JOIN lab01.Kurs_opis ko ON ko.id_kurs=ku.id_nazwa;