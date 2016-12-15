create procedure usun_uczestnika_z_kursu
	@os varchar(11)
AS
	DELETE FROM EdycjeSzkolen
	WHERE @os = (select Osoba
	from  EdycjeSzkolen_Osoby_zlaczenie a join EdycjeSzkolen b
	on b.ID=a.Osoba)

create procedure sprawdz_zapisy
	@pesel varchar(11),
	@szkolenie1 varchar(255),
	@szkolenie2 varchar(255)
AS
	DECLARE @data1 date;
	DECLARE @data2 date;
	DECLARE @data3 date;
	DECLARE @data4 date;
	select @data1 = a.Data_rozpoczecia, @data2 = a.Data_zakonczenia, @data3 = b.Data_rozpoczecia, @data4 = b.Data_zakonczenia from (
		(SELECT * from EdycjeSzkolen_Osoby_zlaczenie x
		JOIN EdycjeSzkolen e on x.IDSzkolenia = e.ID where x.Osoba = @pesel and e.Id = @szkolenie1) a
	FULL OUTER JOIN
		(SELECT * from EdycjeSzkolen_Osoby_zlaczenie x
		JOIN EdycjeSzkolen e on x.IDSzkolenia = e.ID where x.Osoba = @pesel and e.Id = @szkolenie2) b
	on a.Osoba = b.Osoba)


	IF (cast(convert(char(8), @data2, 112) as int) < cast(convert(char(8), @data3, 112) as int) or cast(convert(char(8), @data4, 112) as int) < cast(convert(char(8), @data1, 112) as int))
		print 'Powy¿sze kursy nie nak³adaj¹ siê na siebie'
	ELSE
		print 'Powy¿sze kursy nak³adaj¹ siê na siebie'


	 

create procedure dodaj_osobe
	@pesel varchar(11),
	@imie varchar(255),
	@nazwisko varchar(255),
	@adres varchar(255)
AS
	INSERT INTO Osoby values (@pesel, @imie, @nazwisko, @adres)

create procedure dodaj_szkolenie
	@nazwa varchar(255),
	@przedmiot varchar(255)
AS
	INSERT INTO Szkolenia values (@nazwa, @przedmiot)

create procedure dodaj_certyfikat
	@id varchar(255),
	@data date,
	@cena money,
	@status bit,
	@osoba varchar(11),
	@szkolenie varchar(255)
AS
	INSERT INTO Certyfikaty values (@id, @data, @cena, @status, @osoba, @szkolenie)


create procedure dodaj_licencje
	@id varchar(255),
	@os varchar(255),
	@szkol varchar(255)
AS
	INSERT INTO Licencje values (@id, @os, @szkol)

create procedure dodaj_edycje_szkolenia
	@id varchar(255),
	@data_roz date,
	@data_zak date,
	@cena money,
	@szkol varchar(255)
AS
	INSERT INTO EdycjeSzkolen values (@id, @data_roz, @data_zak, @cena, @szkol)

create procedure zmien_date_szkolenia
	@dat_roz date,
	@dat_zak date,
	@id varchar(255)
AS
	UPDATE EdycjeSzkolen
	SET data_rozpoczecia=@dat_roz, data_zakonczenia=@dat_zak
	WHERE ID=@id

create procedure dodaj_EdycjeSzkolen_Osoby_zlaczenie
	@szkol varchar(255),
	@os varchar(11)
AS
	INSERT INTO EdycjeSzkolen_Osoby_zlaczenie values (@szkol, @os)

create trigger blok_licencja
	on Licencje
	for delete
as
	print 'Proba usuniecia licencji:'
	select * from deleted
rollback

CREATE TRIGGER dobryCertyfikat
ON Certyfikaty
AFTER INSERT

AS
	DECLARE @x date;
	select @x=Data_wydania_certyfikatu from inserted
	DECLARE @y date;
	select @y=(select Data_zakonczenia from ((
		inserted i JOIN Osoby e ON i.osoba = e.PESEL
	)  join EdycjeSzkolen_Osoby_zlaczenie d on e.PESEL=d.Osoba) join EdycjeSzkolen a on d.IDSzkolenia=a.ID where i.szkolenie=a.szkolenie)
	IF cast(convert(char(8), @x, 112) as int)<cast(convert(char(8), @y, 112) as int)
	begin 
	rollback
	end

select * from ((
		Certyfikaty i JOIN Osoby e ON i.osoba = e.PESEL
	)  join EdycjeSzkolen_Osoby_zlaczenie d on e.PESEL=d.Osoba) join EdycjeSzkolen a on d.IDSzkolenia=a.ID

select * from certyfikaty
select * from EdycjeSzkolen_Osoby_zlaczenie
select * from Szkolenia

CREATE VIEW OSOBY_CERT_VIEW AS
SELECT PESEL, Imie, Nazwisko, c.szkolenie
FROM Osoby JOIN Certyfikaty c ON Osoby.PESEL = c.osoba

CREATE VIEW PRZEDMIOT_SZKOLENIA_VIEW AS
SELECT E.id, S.Nazwa_szkolenia
FROM EdycjeSzkolen E join SZKOLENIA S ON E.szkolenie = S.nazwa_szkolenia

CREATE VIEW UCZESTNICY_SZKOLENIA AS
SELECT O.Pesel, O.imie, O.nazwisko, X.nazwa_szkolenia
from Osoby O join (SELECT * FROM PRZEDMIOT_SZKOLENIA_VIEW P JOIN EdycjeSzkolen_Osoby_Zlaczenie E on P.ID =  E.IDSzkolenia) X on O.Pesel = X.Osoba)

CREATE FUNCTION

drop procedure usun_uczestnika_z_kursu
drop trigger dobryCertyfikat