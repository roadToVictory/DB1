
CREATE SEQUENCE wykladowca_id_wykladowca_seq;

CREATE TABLE Wykladowca (
                id_wykladowca INTEGER NOT NULL DEFAULT nextval('wykladowca_id_wykladowca_seq'),
                nazwisko VARCHAR NOT NULL,
                imie VARCHAR NOT NULL,
                CONSTRAINT wykladowca_pk PRIMARY KEY (id_wykladowca)
);


ALTER SEQUENCE wykladowca_id_wykladowca_seq OWNED BY Wykladowca.id_wykladowca;

CREATE SEQUENCE kurs_opis_id_kurs_seq;

CREATE TABLE Kurs_opis (
                id_kurs INTEGER NOT NULL DEFAULT nextval('kurs_opis_id_kurs_seq'),
                opis INTEGER NOT NULL,
                CONSTRAINT kurs_opis_pk PRIMARY KEY (id_kurs)
);


ALTER SEQUENCE kurs_opis_id_kurs_seq OWNED BY Kurs_opis.id_kurs;

CREATE TABLE kurs (
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL,
                id_kurs_nazwa INTEGER NOT NULL,
                CONSTRAINT kurs_pk PRIMARY KEY (id_kurs, id_grupa)
);


CREATE TABLE wykl_kurs (
                id_wykl INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL,
                CONSTRAINT wykl_kurs_pk PRIMARY KEY (id_wykl, id_kurs, id_grupa)
);


CREATE SEQUENCE uczestnik_id_seq;

CREATE TABLE Uczestnik (
                id INTEGER NOT NULL DEFAULT nextval('uczestnik_id_seq'),
                nazwisko VARCHAR NOT NULL,
                imie VARCHAR NOT NULL,
                CONSTRAINT id_uczestnik PRIMARY KEY (id)
);


ALTER SEQUENCE uczestnik_id_seq OWNED BY Uczestnik.id;

CREATE TABLE uczest_kurs (
                id_grupa INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_uczest INTEGER NOT NULL,
                CONSTRAINT uczest_kurs_pk PRIMARY KEY (id_grupa, id_kurs, id_uczest)
);


ALTER TABLE wykl_kurs ADD CONSTRAINT wykladowca_wykl_kurs_fk
FOREIGN KEY (id_wykl)
REFERENCES Wykladowca (id_wykladowca)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE kurs ADD CONSTRAINT kurs_opis_kurs_fk
FOREIGN KEY (id_kurs_nazwa)
REFERENCES Kurs_opis (id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE uczest_kurs ADD CONSTRAINT kurs_uczest_kurs_fk
FOREIGN KEY (id_kurs, id_grupa)
REFERENCES kurs (id_kurs, id_grupa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE wykl_kurs ADD CONSTRAINT kurs_wykl_kurs_fk
FOREIGN KEY (id_kurs, id_grupa)
REFERENCES kurs (id_kurs, id_grupa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE uczest_kurs ADD CONSTRAINT uczestnik_uczest_kurs_fk
FOREIGN KEY (id_uczest)
REFERENCES Uczestnik (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
