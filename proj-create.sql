CREATE TABLE Szkolenia (
  Nazwa_szkolenia varchar(255) PRIMARY KEY,
  Przedmiot_szkolenia varchar(255) NOT NULL,
)
 
CREATE TABLE Osoby (
  PESEL varchar(11) PRIMARY KEY ,
  Imie varchar(255) NOT NULL,
  Nazwisko varchar(255) NOT NULL,
  Adres varchar(255) NOT NULL,
  CHECK (ISNUMERIC(PESEL)=1)
 
)
 
CREATE TABLE Certyfikaty (
  ID varchar(255) PRIMARY KEY,
  Data_wydania_certyfikatu date NOT NULL ,
  Cena money NOT NULL,
  Status_platnosci bit NOT NULL,
  osoba varchar(11) references Osoby(PESEL),
  szkolenie varchar(255) references Szkolenia(Nazwa_szkolenia),
)
 
CREATE TABLE Licencje (
  ID varchar(255) PRIMARY KEY,
  osoba varchar(11) references Osoby(PESEL),
  szkolenie varchar(255) references Szkolenia(Nazwa_szkolenia),
)
 
CREATE TABLE EdycjeSzkolen (
  ID varchar(255) PRIMARY KEY,
  Data_rozpoczecia date NOT NULL,
  Data_zakonczenia date NOT NULL,
  Cena money NOT NULL DEFAULT '500',
  szkolenie varchar(255) references Szkolenia(Nazwa_szkolenia),
)
 
CREATE TABLE EdycjeSzkolen_Osoby_zlaczenie (
  IDSzkolenia varchar(255) references EdycjeSzkolen(ID),
  Osoba varchar(11) references Osoby(Pesel),
)

INSERT INTO Szkolenia (Nazwa_Szkolenia, Przedmiot_szkolenia)
values ('Podstawy PHP', 'PHP')

INSERT INTO Osoby (Pesel, Imie, Nazwisko, Adres)
values ('94949494940', 'Pawel', 'Kowalski', 'Sezamkowa 6 Poziomki')

INSERT INTO Certyfikaty (ID, Data_wydania_certyfikatu, Cena, Status_platnosci, osoba, szkolenie)
values ('122p', '20160118 10:34:09 AM', '1299.99', 1, '94949494940', 'Podstawy PHP')

INSERT INTO Licencje (ID, osoba, szkolenie)
values ('12y', '94949494940', 'Podstawy PHP')

INSERT INTO EdycjeSzkolen (ID, Data_rozpoczecia, Data_zakonczenia, szkolenie)
values ('124', '20160117', '20160219', 'Podstawy PHP')

INSERT INTO EdycjeSzkolen_Osoby_zlaczenie (IDSzkolenia, Osoba)
values ('124', '94949494940')


DROP TABLE Szkolenia
DROP TABLE Osoby
DROP TABLE Certyfikaty
DROP TABLE Licencje
DROP TABLE EdycjeSzkolen
DROP TABLE EdycjeSzkolen_Osoby_zlaczenie

select * from Certyfikaty
select * from EdycjeSzkolen
select * from EdycjeSzkolen_Osoby_zlaczenie
