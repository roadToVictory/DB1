DROP TABLE IF EXISTS lab15.tabela;
CREATE TABLE lab15.tabela (person JSONB);

insert into lab15.tabela select * from (select jsonb_build_object('person_record', jsonb_build_object('pid',id,'firstname', fname, 'lastname',lname,'contact', jsonb_build_object('email', email, 'phone', phone), 'adress', jsonb_build_object('city',city ,'street', street, 'address', address))) from lab15.person_sample_table) obj;
select jsonb_pretty(person) from lab15.tabela;

--2--
delete from lab15.tabela where person->'person_record' ->>'pid' = '20010';

select jsonb_pretty(person) from lab15.tabela;



