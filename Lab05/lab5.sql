--1
SELECT ucz.imie, ucz.nazwisko, ko.opis FROM lab04.uczestnik ucz
JOIN lab04.uczest_kurs uk on ucz.id_uczestnik=uk.id_uczest
JOIN lab04.kurs ku USING (id_kurs)
JOIN lab04.kurs_opis ko on ku.id_nazwa=ko.id_kurs
WHERE ko.id_kurs < 6
UNION
SELECT ucz.imie, ucz.nazwisko, ko.opis FROM lab04.uczestnik ucz
JOIN lab04.uczest_kurs uk on ucz.id_uczestnik=uk.id_uczest
JOIN lab04.kurs ku USING (id_kurs)
JOIN lab04.kurs_opis ko on ku.id_nazwa=ko.id_kurs
WHERE ko.id_kurs>5 and ko.id_kurs<10;

--2

SELECT ucz.imie, ucz.nazwisko FROM lab04.uczestnik ucz
JOIN lab04.uczest_kurs uk on ucz.id_uczestnik=uk.id_uczest
JOIN lab04.kurs ku USING (id_kurs)
JOIN lab04.kurs_opis ko on ku.id_nazwa=ko.id_kurs
WHERE ko.id_kurs<=5
INTERSECT
SELECT ucz.imie, ucz.nazwisko FROM lab04.uczestnik ucz
JOIN lab04.uczest_kurs uk on ucz.id_uczestnik=uk.id_uczest
JOIN lab04.kurs ku USING (id_kurs)
JOIN lab04.kurs_opis ko on ku.id_nazwa=ko.id_kurs
WHERE ko.id_kurs>=6 and ko.id_kurs<=9;

--3

SELECT ucz.imie, ucz.nazwisko FROM lab04.uczestnik ucz
JOIN lab04.uczest_kurs uk on ucz.id_uczestnik=uk.id_uczest
JOIN lab04.kurs ku USING (id_kurs)
JOIN lab04.kurs_opis ko on ku.id_nazwa=ko.id_kurs
WHERE ko.id_kurs>5 and ko.id_kurs<10
EXCEPT
SELECT ucz.imie, ucz.nazwisko FROM lab04.uczestnik ucz
JOIN lab04.uczest_kurs uk on ucz.id_uczestnik=uk.id_uczest
JOIN lab04.kurs ku USING (id_kurs)
JOIN lab04.kurs_opis ko on ku.id_nazwa=ko.id_kurs
WHERE ko.id_kurs<6;

--4
select ko.id_kurs, ko.opis, s.kwota from 
(select id_kurs id,  sum(oplata) kwota 
from lab04.uczest_kurs group by id_kurs) s
JOIN lab04.kurs ku on s.id=ku.id_kurs
JOIN lab04.kurs_opis ko on ku.id_nazwa=ko.id_kurs
where kwota>5000 order by kwota desc;

--lub z uzyciem HAVING

select ko.id_kurs, ko.opis, s.kwota from 
(select id_kurs id,  sum(oplata) kwota 
from lab04.uczest_kurs group by id_kurs) s
JOIN lab04.kurs ku on s.id=ku.id_kurs
JOIN lab04.kurs_opis ko on ku.id_nazwa=ko.id_kurs
group by ko.id_kurs, s.kwota having kwota>5000 order by kwota desc;


--5
select w.imie, w.nazwisko, sum(s.studenci) as "ilosc_studentow" from
(select count(id_uczest)  studenci, id_kurs from lab04.uczest_kurs group by id_kurs) s
join lab04.wykl_kurs wk on s.id_kurs=wk.id_kurs
join lab04.wykladowca w on wk.id_wykl=w.id_wykladowca
group by w.imie, w.nazwisko
order by ilosc_studentow desc;

--z uzycien USING
select w.imie, w.nazwisko, sum(s.studenci) as "ilosc_studentow" from
(select count(id_uczest)  studenci, id_kurs from lab04.uczest_kurs group by id_kurs) s
join lab04.wykl_kurs wk using(id_kurs)
join lab04.wykladowca w on wk.id_wykl=w.id_wykladowca
group by w.imie, w.nazwisko
order by ilosc_studentow desc;

--6

select distinct ucz.id_uczestnik, ucz.imie, ucz.nazwisko, uo.id_organizacja, o.nazwa, uk.ocena from lab04.uczestnik ucz
join lab04.uczestnik_organizacja uo using(id_uczestnik)
join lab04.organizacja o using(id_organizacja)
join lab04.uczest_kurs uk on ucz.id_uczestnik=uk.id_uczest
where uk.ocena=any(select max(ocena) from lab04.uczest_kurs)
order by uo.id_organizacja;

