exec dodaj_osobe '02020202020', Mateusz, Masarzezba, Poznan
exec dodaj_szkolenie '.NET i ty', '.NET'
exec dodaj_certyfikat '127c', '20120622 10:34:08 AM', '1199.99', 0
exec dodaj_licencje '12b', '02020202020', '.NET i ty'
exec dodaj_edycje_szkolenia '128', '20120527', '20120518', '299.99', '.NET i ty'
exec zmien_date_szkolenia '20120526', '20120622', '128'
exec dodaj_EdycjeSzkolen_Osoby_zlaczenie 
exec usun_uczestnika_z_kursu '02020202020'
exec sprawdz_zapisy '94949494940', '124', '123'

select * from Osoby
select * from EdycjeSzkolen