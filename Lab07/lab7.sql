    --1-- Utworzyć funkcję,  która dostarcza listę z nazwiskami, imionami i adresem email uczestników dla organizacji. Identyfikator organizacji jest argumentem funkcji.
create or replace function lab04.getstudent(org int) returns table (name varchar, surn varchar, email varchar) as
$$
begin
return query
select u.imie, u.nazwisko, u.email from lab04.uczestnik u join lab04.uczestnik_organizacja uo using (id_uczestnik) where uo.id_organizacja=org;
end
$$ language 'plpgsql';

--wywolania
select * from lab04.getstudent(1);
select * from lab04.getstudent(2);

--usuniecie funkcji
drop function lab04.getstudent(int);


    --2-- Utworzyć funkcję, która dostarcza ilość studentów dla kursów danego języka. Nazwa języka jest argumentem funkcji.
CREATE OR REPLACE FUNCTION lab04.countk( jezyk varchar )
RETURNS TABLE (name varchar, ilosc bigint) AS
$$ begin
	return query
        SELECT ko.opis, count(uk.id_uczest)
        FROM lab04.uczest_kurs uk
        JOIN lab04.kurs ku USING (id_kurs)
        JOIN lab04.kurs_opis ko ON ku.id_nazwa = ko.id_kurs
        WHERE lower(KO.opis) LIKE lower(jezyk) GROUP BY ko.opis;
end $$
LANGUAGE 'plpgsql';

--wywolanie--
select * from lab04.countk('%hisz%');
select * from lab04.countk('%angielski%');


--usuniecie funkcji
drop function lab04.countk(varchar);


	--3-- Utworzyć funkcję,  która dostarcza listę wykładowców prowadzących kursy dla zadanej organizacji. Argumentem funkcji jest adres strony np. www.uj.edu.pl.
CREATE OR REPLACE FUNCTION lab04.wykl( org text )
RETURNS TABLE (imie VARCHAR, nazwisko VARCHAR) AS
$$ begin
	return query
        select w.imie, w.nazwisko from lab04.wykladowca w join lab04.uczestnik_organizacja using(id_wykladowca) join lab04.organizacja using(id_organizacja) where lower(strona_www) like lower(org);
end $$
LANGUAGE 'plpgsql';	

--wywolanie--
select * from lab04.wykl('%agh%'); 
select * from lab04.wykl('www.uj.edu.pl');

--usuniecie funkcji
drop function lab04.wykl(text);


	--4-- Utworzyć funkcję,  która zwraca napis ( string) którego zawartością jest lista. Wiersze listy zawierają  opis kursu, data rozpoczęcia, data zakończenia oddzielone średnikami. Każdy wiersz jest umieszczony w nawiasach () i oddzielony przecinkiem.
CREATE OR REPLACE FUNCTION lab04.info() 
returns text as
$$ DECLARE
	rec RECORD;
	napis text DEFAULT '';
begin
	for rec IN (select opis, data_rozpoczecia, data_zakonczenia from lab04.kurs_opis join lab04.kurs on kurs_opis.id_kurs=kurs.id_nazwa)
	LOOP
	napis:= napis || '(' || rec.opis ||'; '|| rec.data_rozpoczecia || '; ' || rec.data_zakonczenia || '), ';
	end loop;
	return napis;
	
end$$ 
LANGUAGE 'plpgsql';	

--wywolanie--
select lab04.info(); 

--usuniecie funkcji
drop function lab04.info();