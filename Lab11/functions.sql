--zad5--
CREATE OR REPLACE FUNCTION lab04.f1_osoba (id_ucz INTEGER) 
	RETURNS lab04.uczestnik AS
	$$
    SELECT * FROM lab04.uczestnik WHERE id_uczestnik=id_ucz;
	$$ LANGUAGE SQL;
	
	
--zad6--
CREATE OR REPLACE FUNCTION lab04.get_table()
	RETURNS table(id INTEGER, imie varchar, nazwisko varchar) AS
	$$
	select id_uczestnik, imie, nazwisko from lab04.uczestnik;
	$$ LANGUAGE SQL;

--zad7--
CREATE OR REPLACE FUNCTION lab04.get_cursor() 
RETURNS refcursor AS
$body$
DECLARE curuczestnik refcursor  ;
BEGIN
  OPEN curuczestnik FOR SELECT id_uczestnik, imie, nazwisko from lab04.uczestnik ;
  RETURN  curuczestnik ;
END;
$body$ LANGUAGE plpgsql;
