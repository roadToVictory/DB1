--create and insert dat--
CREATE TABLE lab14.sample_table ( 
fname varchar, 
lname varchar, 
city varchar, 
email varchar, 
phone varchar, 
id varchar ) ;

INSERT INTO lab14.sample_table VALUES
( 'Adam', 'Abacki', 'Krakow', 'abacki@o2.pl', '123 400 212', '10001'),
( 'Marta', 'Babacka', 'Konin', 'babacki@onet.pl', '411 909 123', '11011'),
( 'Bogdan', 'Cabacki', 'Tarnow', 'cabacki@wp.pl', '222 190 100', '20010'),
( 'Marek', 'Dadacki', 'Gdynia', 'dadacki@google.com', '431 222 100', '10022'),
( 'Edward', 'Kabacki', 'Szczecin', 'kabacki@o2.pl', '780 159 100', '21145') ;

--1--

SELECT id, xpath('//fname/text()', data)::text as imie,
           xpath('//lname/text()', data)::text as nazwisko,
           xpath('//contact/email/text()', data)::text as email
FROM lab14.xml_table
WHERE xpath('//contact/email/text()', data)::text ~* '.*@o2.pl';

--2--

SELECT id, xpath('//fname/text()', data)::text as imie,
           xpath('//lname/text()', data)::text as nazwisko
FROM lab14.xml_table
WHERE xpath('//user[@id>10000 and @id<20000]/@id', data)::text != '{}';



