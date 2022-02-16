--1 -- zakladam ze nieobecnosc usprawiedliwiona to obecnosc
WITH abCTE AS(
SELECT id_uczestnik, COUNT(*) AS obec FROM lab04.aktywnosc WHERE obecnosc!=0 GROUP BY id_uczestnik)
SELECT abCTE.id_uczestnik, imie, nazwisko,
CASE 
WHEN obec>=18 THEN 'duza'
WHEN obec>=11 and obec<18 THEN 'srednia'
WHEN obec>=1 and obec<11 THEN 'mala'
ELSE 'brak'
END frekwencja
FROM lab04.uczestnik JOIN abCTE ON uczestnik.id_uczestnik=abCTE.id_uczestnik ORDER BY abCTE.obec desc, nazwisko;


--2--
SELECT nazwisko, imie,
  CASE
        WHEN COUNT(*) >=18 THEN 'powyzej limitu'
        WHEN COUNT(*) >=10 and COUNT(*)<18 then 'limit'
        ELSE 'ponizej limitu'
        END AS limit
FROM lab04.uczest_kurs RIGHT OUTER JOIN lab04.wykl_kurs using(id_kurs) right outer join lab04.wykladowca on wykl_kurs.id_wykl=wykladowca.id_wykladowca
GROUP BY nazwisko, imie order by count(*) desc;



--2-- z CTE (choć troche na siłe)
with myCTE AS(select id_wykladowca, nazwisko, imie from lab04.wykladowca) SELECT myCTE.nazwisko, myCTE.imie,
CASE
when count(*)>=18 then 'powyzej limitu'
when count(*)<10 then 'ponizej limitu'
else 'limit'
end as limit 
FROM lab04.uczest_kurs RIGHT OUTER JOIN lab04.wykl_kurs using(id_kurs) RIGHT OUTER join myCTE on wykl_kurs.id_wykl=myCTE.id_wykladowca
GROUP BY nazwisko, imie order by count(*) desc;

--3--
 with myCTE as(select id_kurs, count(*) as ilosc
from lab04.uczest_kurs group by id_kurs)
select SUM(ilosc)/COUNT(*) as "srednia uczestnikow na kursie" from myCTE; 