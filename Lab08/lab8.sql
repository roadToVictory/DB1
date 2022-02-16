CREATE SEQUENCE lab04.person_person_id_seq;

CREATE TABLE lab04.person (
                person_id INTEGER NOT NULL DEFAULT nextval('lab04.person_person_id_seq'),
                fname VARCHAR(20) NOT NULL,
                lname VARCHAR(20) NOT NULL,
                primary_group CHAR(1) NOT NULL,
                secondary_group CHAR(2) NOT NULL,
                CONSTRAINT person_pk PRIMARY KEY (person_id)
);


ALTER SEQUENCE lab04.person_person_id_seq OWNED BY lab04.person.person_id;

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Lem', 'And', 'P', 'WY' ); 
SELECT * FROM lab04.person;


    --1-- Napisać wyzwalacz walidujący fname i lname w tabeli person, tylko litery, bez spacji i tabulatorów. W lname dopuszczalny znak - (myślnik, pauza).
 Create or replace function lab04.validate_name()
returns trigger
language 'plpgsql'
as $$ begin
if new.fname!~ '^[A-Za-z]*$' or new.lname!~ '^[A-Za-z]*$' or length(new.fname)=0 or length(new.lname)=0
then
raise exception 'niepoprawne wartosci fname i/lub lname';
end if;
return new;
end; $$;

--trigger--
create trigger name_valid
after insert or update on lab04.person
for each row execute procedure lab04.validate_name();

--testy--
INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Dyd456', 'Ant546', 'P', 'WY' ); --blad, niezgodne z reg-expem

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( '', 'Ant', 'P', 'WY' ); --blad, puste lname

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Dyd', 'Ant', 'P', 'WY' );  --OK

    --2-- Napisać wyzwalacz normalizujący fname i lname w tabeli person, fname i skladowe lname ( przy podwójnym nazwisku) powinny zaczynać się od dużej litery, reszta małe.
create or replace function lab04.normalize_name() returns trigger language 'plpgsql' as $$ declare
first_letter text; anoth text;
begin
first_letter:=upper(substring(new.fname for 1));
anoth:=lower(substring(new.fname from 2));
new.fname:=first_letter||anoth;
first_letter:=upper(substring(new.lname for 1));
anoth:=lower(substring(new.lname from 2));
new.lname:=first_letter||anoth;
return new;
end; $$;

--trigger--
create trigger name_norm
before insert or update on lab04.person
for each row execute procedure lab04.normalize_name();

--testy--
INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'mic', 'jan', 'A', 'Wy' );

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'mic', 'JAN', 'A', 'Wy' );



    --3--
create or replace function lab04.akt_tab() returns trigger language 'plpgsql' as $$
begin
	if new.primary_group = 'P' then
		INSERT into lab04.person_group(lname, fname, secondary_group) VALUES (new.lname, new.fname, new.secondary_group);
		--select count(*) from lab04.person_group;
	end if;
return new;
end; $$;

--trigger--
create trigger akt_tabele
after insert or update on lab04.person
for each row execute procedure lab04.akt_tab();

--testy--
INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Sto', 'Zbi', 'A', 'Wy' ); 
select * from lab04.person_group; -- nie dodalo, bo primary_group != 'P'

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'mal', 'daw', 'P', 'Wy' ); --test czy zostanie wywolany trigger normalizujacy 
select * from lab04.person_group; -- OK