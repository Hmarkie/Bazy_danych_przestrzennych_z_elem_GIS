--Ćwiczenia nr 1
--Bazy donych przestrzennych wraz z elementamiGIS
--Powtórka SQL

CREATE database s299632;

CREATE SCHEMA firma;

CREATE ROLE ksiegowosc;
GRANT USAGE ON SCHEMA firma TO ksiegowosc;
GRANT SELECT on all tables IN SCHEMA "firma" TO ksiegowosc;

CREATE TABLE firma.godziny (
    id_godziny SERIAL,
    data DATE  NOT NULL,
    liczba_godzin int  NOT NULL,
    id_pracownika int  NOT NULL,
    CONSTRAINT godziny_pk PRIMARY KEY (id_godziny)
);



-- Table: pensja_stanowisko
CREATE TABLE firma.pensja_stanowisko (
    id_pensji serial  NOT NULL,
    stanowisko varchar(50)  NOT NULL,
    kwota decimal(6,2)  NOT NULL,
    CONSTRAINT pensja_stanowisko_pk PRIMARY KEY (id_pensji)
);

-- Table: pracownicy
CREATE TABLE firma.pracownicy (
    id_pracownika SERIAL,
    imie varchar(20)  NOT NULL,
    nazwisko varchar(50)  NOT NULL,
    adres varchar(50)  NOT NULL,
    telefon varchar(15)  NOT NULL,
    CONSTRAINT pracownicy_pk PRIMARY KEY (id_pracownika)
);



-- Table: premia
CREATE TABLE firma.premia (
    id_premii serial  NOT NULL,
    rodzaj varchar(40)  NOT NULL,
    kwota decimal(6,2)  NOT NULL,
    CONSTRAINT premia_pk PRIMARY KEY (id_premii)
);

-- Table: wynagrodzenie
CREATE TABLE firma.wynagrodzenie (
    id_wynagrodzenia serial  NOT NULL,
    data date  NOT NULL,
    id_pracownika int  NOT NULL,
    id_godziny int  NOT NULL,
    id_pensji int  NOT NULL,
    id_premii int  NOT NULL,
    CONSTRAINT wynagrodzenie_pk PRIMARY KEY (id_wynagrodzenia)
);


ALTER TABLE firma.godziny ADD CONSTRAINT godziny_pracownicy
	FOREIGN KEY (id_pracownika)
	REFERENCES firma.pracownicy (id_pracownika)
	ON DELETE CASCADE 
	ON UPDATE CASCADE
	;
	
ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_godziny
	FOREIGN KEY (id_godziny)
	REFERENCES firma.godziny (id_godziny)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	;
	
ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_pensja_stanowisko
	FOREIGN KEY (id_pensji)
	REFERENCES firma.pensja_stanowisko (id_pensji)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	;

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_pracownicy
	FOREIGN KEY (id_pracownika)
	REFERENCES firma.pracownicy (id_pracownika)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	;
	
ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_premia
	FOREIGN KEY (id_premii)
	REFERENCES firma.premia (id_premii)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	;
	
	--d)Indeksowanie metodą B-drzewa
	
	CREATE INDEX id_index ON firma.pracownicy (nazwisko)
	
	--e)Komentarze
	
COMMENT ON TABLE firma.godziny
		IS 'Ilość przepracowanych godzin';
COMMENT ON TABLE firma.pensja_stanowisko
		IS 'Podstawowa pensja odpowiednia do danego stanowiska';
COMMENT ON TABLE firma.pracownicy
	IS 'Dane o pracownikach';
COMMENT ON TABLE firma.premia
	IS 'Premia i jej wysokość';
COMMENT ON TABLE firma.wynagrodzenie
	IS 'Końcowe dane odnośnie wynagrodzenia';

--Wypełnianie tabeli
		--a)
ALTER TABLE firma.godziny ADD tydzien int NOT NULL;
ALTER TABLE firma.godziny ADD miesiac int NOT NULL;

		--b)
ALTER TABLE firma.wynagrodzenie alter column "data" type varchar(20) USING "data"::varchar;

		--c)

ALTER TABLE firma.premia alter column rodzaj DROP NOT NULL;
ALTER TABLE firma.wynagrodzenie ALTER COLUMN id_premii DROP NOT NULL;
 
 
 --tabela pracownicy zawartość
 INSERT INTO firma.pracownicy ( imie, nazwisko, adres, telefon)
    VALUES ( 'Pat', 'Mat', 'ul. Czeska 3; Svijany', '123456789');
INSERT INTO firma.pracownicy ( imie, nazwisko, adres, telefon)
    VALUES ( 'Mała', 'Syrenka', 'ul. Wodna 3; Ocean', '234567891');
INSERT INTO firma.pracownicy ( imie, nazwisko, adres, telefon)
    VALUES ( 'Jan', 'Kowalski', 'ul. Polska 5; Jaskinia', '345678912');
INSERT INTO firma.pracownicy ( imie, nazwisko, adres, telefon)
    VALUES ( 'Papa', 'Smerf', 'ul. Chatka 1; Las', '113456789');
INSERT INTO firma.pracownicy ( imie, nazwisko, adres, telefon)
    VALUES ( 'Smerfetka', 'Sukienka', 'ul. Chatka 2; Las', '700456789');
INSERT INTO firma.pracownicy ( imie, nazwisko, adres, telefon)
	VALUES ( 'Maruda', 'Student', 'ul. Chatka 3; Las', '223456789');
INSERT INTO firma.pracownicy ( imie, nazwisko, adres, telefon)
    VALUES ( 'Ważniak', 'Starosta', 'ul. Chatka 4; Las', '333456789');
INSERT INTO firma.pracownicy ( imie, nazwisko, adres, telefon)
    VALUES ( 'Ciamajda', 'Spadochroniarz', 'ul. Chatka 5; Las', '443456789');
INSERT INTO firma.pracownicy ( imie, nazwisko, adres, telefon)
    VALUES ( 'Zgrywus', 'Stypendysta', 'ul. Chatka 6; Las', '553456789');
INSERT INTO firma.pracownicy (, imie, nazwisko, adres, telefon)
    VALUES ( 'Śpioch', 'Spóźniony', 'ul. Chatka 7; Las', '123456789');



--tabela godziny zawartość
INSERT INTO firma.godziny ( "data", liczba_godzin, id_pracownika, miesiac, tydzien)
    VALUES ('2020-02-10', 120, 1, extract(month from date '2020-02-10'), extract(week from date '2020-03-10'));
INSERT INTO firma.godziny ( "data", liczba_godzin, id_pracownika, miesiac, tydzien)
    VALUES ('2020-02-13', 153, 2, extract(month from date '2020-02-13'), extract(week from date '2020-03-13'));
INSERT INTO firma.godziny ( "data", liczba_godzin, id_pracownika, miesiac, tydzien)
    VALUES ('2020-02-18', 143, 3, extract(month from date '2020-02-18'), extract(week from date '2020-03-18'));
INSERT INTO firma.godziny ( "data", liczba_godzin, id_pracownika, miesiac, tydzien)
    VALUES ('2020-02-16', 170, 4, extract(month from date '2020-02-16'), extract(week from date '2020-03-16'));	
INSERT INTO firma.godziny ( "data", liczba_godzin, id_pracownika, miesiac, tydzien)
    VALUES ('2020-02-21', 180, 5, extract(month from date '2020-02-21'), extract(week from date '2020-03-21'));
INSERT INTO firma.godziny ( "data", liczba_godzin, id_pracownika, miesiac, tydzien)
    VALUES ('2020-02-23', 168, 6, extract(month from date '2020-02-23'), extract(week from date '2020-03-23'));
INSERT INTO firma.godziny ( "data", liczba_godzin, id_pracownika, miesiac, tydzien)
    VALUES ('2020-02-25', 148, 7, extract(month from date '2020-02-25'), extract(week from date '2020-03-25'));
INSERT INTO firma.godziny ( "data", liczba_godzin, id_pracownika, miesiac, tydzien)
    VALUES ('2020-02-26', 185, 8, extract(month from date '2020-02-26'), extract(week from date '2020-03-26'));
INSERT INTO firma.godziny ( "data", liczba_godzin, id_pracownika, miesiac, tydzien)
    VALUES ('2020-02-22', 138, 9, extract(month from date '2020-02-22'), extract(week from date '2020-03-22'));
INSERT INTO firma.godziny ( "data", liczba_godzin, id_pracownika, miesiac, tydzien)
    VALUES ('2020-02-12', 175, 10, extract(month from date '2020-02-12'), extract(week from date '2020-03-12'));	



--tabela pensja_stanowisko zawartość
INSERT INTO firma.pensja_stanowisko ( stanowisko, kwota)
    VALUES ('Team Leader', 5400);
INSERT INTO firma.pensja_stanowisko ( stanowisko, kwota)
    VALUES ('Asystent', 3500);
INSERT INTO firma.pensja_stanowisko ( stanowisko, kwota)
    VALUES ('Prezes', 8400);
INSERT INTO firma.pensja_stanowisko ( stanowisko, kwota)
    VALUES ('Zastepca dyrektora', 4500);
INSERT INTO firma.pensja_stanowisko ( stanowisko, kwota)
    VALUES ('Dyrektor', 5800);
INSERT INTO firma.pensja_stanowisko ( stanowisko, kwota)
    VALUES ('Stażysta', 2100);
INSERT INTO firma.pensja_stanowisko ( stanowisko, kwota)
    VALUES ('Prawnik', 6200);
INSERT INTO firma.pensja_stanowisko ( stanowisko, kwota)
    VALUES ('Programista', 7500);
INSERT INTO firma.pensja_stanowisko ( stanowisko, kwota)
    VALUES ('Tester', 4400);
INSERT INTO firma.pensja_stanowisko ( stanowisko, kwota)
    VALUES ('PRowiec', 6500);
	

--Tabela premia
INSERT INTO firma.premia ( rodzaj, kwota)
    VALUES ('Nadgodziny +5', 120);
INSERT INTO firma.premia ( rodzaj, kwota)
    VALUES ('Nadgodziny +10', 240);
INSERT INTO firma.premia ( rodzaj, kwota)
    VALUES ('Świateczne-karp', 400);
INSERT INTO firma.premia ( rodzaj, kwota)
    VALUES ('Świateczne-królik', 200);
INSERT INTO firma.premia ( rodzaj, kwota)
    VALUES ('Bonus', 100);
INSERT INTO firma.premia ( rodzaj, kwota)
    VALUES ('Nadgodziny +15', 300);
INSERT INTO firma.premia ( rodzaj, kwota)
    VALUES ('Nadgodziny +25', 400);
INSERT INTO firma.premia ( rodzaj, kwota)
    VALUES ('Nadgodziny +35', 520);
INSERT INTO firma.premia ( rodzaj, kwota)
    VALUES ('Nadgodziny +45', 620);
INSERT INTO firma.premia ( rodzaj, kwota)
    VALUES ('Brak', 0);


--Tabela wynagrodzenie
INSERT INTO firma.wynagrodzenie ( "data", id_pracownika, id_pensji, id_premii, id_godziny)
    VALUES ('2020-03-01', '1', '1', '4', '1');
INSERT INTO firma.wynagrodzenie ( "data", id_pracownika, id_pensji, id_premii, id_godziny)
    VALUES ('2020-03-01', '2', '2', '4', '2');
INSERT INTO firma.wynagrodzenie ( "data", id_pracownika, id_pensji, id_premii, id_godziny)
    VALUES ('2020-03-01', '3', '3', '4', '3');
INSERT INTO firma.wynagrodzenie ( "data", id_pracownika, id_pensji, id_premii, id_godziny)
    VALUES ('2020-03-01', '4', '4', '4', '4');
INSERT INTO firma.wynagrodzenie ( "data", id_pracownika, id_pensji, id_premii, id_godziny)
    VALUES ('2020-03-01', '5', '5', '4', '5');
INSERT INTO firma.wynagrodzenie ( "data", id_pracownika, id_pensji, id_premii, id_godziny)
    VALUES ('2020-03-01', '6', '6', '4', '6');
INSERT INTO firma.wynagrodzenie ( "data", id_pracownika, id_pensji, id_premii, id_godziny)
    VALUES ('2020-03-01', '7', '7', '4', '7');
INSERT INTO firma.wynagrodzenie ( "data", id_pracownika, id_pensji, id_premii, id_godziny)
    VALUES ('2020-03-01', '8', '8', '4', '8');
INSERT INTO firma.wynagrodzenie ( "data", id_pracownika, id_pensji, id_premii, id_godziny)
    VALUES ('2020-03-01', '9', '9', '4', '9');
INSERT INTO firma.wynagrodzenie ( "data", id_pracownika, id_pensji, id_premii, id_godziny)
    VALUES ('2020-03-01', '10', '10', '4', '9');


--Selecty
	--a)
	SELECT id_pracownika, nazwisko FROM firma.pracownicy;
	
	--b)
	SELECT firma.wynagrodzenie.id_pracownika FROM firma.wynagrodzenie;
	JOIN firma.pensja_stanowisko ON firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji
	JOIN firma.premia ON firma.premia.id_premii = firma.wynagrodzenie.id_premii
	WHERE firma.premia.kwota+firma.pensja_stanowisko.kwota > 1000;
	
	--c)
	SELECT firma.wynagrodzenie.id_pracownika FROM firma.wynagrodzenie
	JOIN firma.pensja_stanowisko ON firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji
	JOIN firma.premia ON firma.premia.id_premii = firma.wynagrodzenie.id_premii
	WHERE firma.premia.kwota = 0 AND firma.pensja_stanowisko.kwota > 2000;

	--d)
	SELECT imie, nazwisko, adres, telefon
	FROM firma.pracownicy
	WHERE imie LIKE 'J%';
 
	--e)
	SELECT imie, nazwisko, adres, telefon FROM firma.pracownicy
	WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';
 
	--f)
	SELECT firma.pracownicy.imie, firma.pracownicy.nazwisko, 
		CASE
			WHEN firma.godziny.liczba_godzin < 160 THEN 0
			ELSE firma.godziny.liczba_godzin - 160 
		END AS "nadgodziny"
	FROM firma.pracownicy
	JOIN firma.godziny ON firma.pracownicy.id_pracownika = firma.godziny.id_pracownika;
 
	--g)
	SELECT imie, nazwisko FROM firma.pracownicy
	JOIN firma.wynagrodzenie ON firma.wynagrodzenie.id_pracownika = firma.pracownicy.id_pracownika
	JOIN firma.pensja_stanowisko ON firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji
	WHERE firma.pensja_stanowisko.kwota >= 1500 AND firma.pensja_stanowisko.kwota <= 3000;
 
	--h)
	SELECT imie, nazwisko FROM firma.pracownicy
	JOIN firma.godziny ON firma.pracownicy.id_pracownika = firma.godziny.id_pracownika
	JOIN firma.wynagrodzenie ON firma.pracownicy.id_pracownika = firma.wynagrodzenie.id_pracownika
	JOIN firma.premia ON firma.wynagrodzenie.id_premii = firma.premia.id_premii
	WHERE firma.premia.kwota = 0 AND firma.godziny.liczba_godzin > 120;
	
--Zadanie 7:
	--a)
		SELECT p.*, pen.kwota FROM firma.pracownicy p 
		JOIN firma.wynagrodzenie w ON p.id_pracownika = w.id_pracownika 
		JOIN firma.pensja pen ON pen.id_pensji = w.id_pensji 
		ORDER BY pen.kwota;
 
	--b)
		SELECT imie, nazwisko, adres, telefon, firma.pensja_stanowisko.kwota + firma.premia.kwota as "wyplata"
		FROM firma.pracownicy
		JOIN firma.wynagrodzenie ON firma.pracownicy.id_pracownika = firma.wynagrodzenie.id_pracownika
		JOIN firma.pensja_stanowisko ON firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji
		JOIN firma.premia ON firma.wynagrodzenie.id_premii = firma.premia.id_premii
		ORDER BY firma.pensja_stanowisko.kwota + firma.premia.kwota DESC;

	--c)
		SELECT pen.stanowisko 
		COUNT (pen.stanowisko) FROM firma.pensja_stanowisko pen 
		JOIN firma.wynagrodzenie wyn ON pen.id_pensji = wyn.id_pensji 
		JOIN firma.pracownicy prac ON prac.id_pracownika = wyn.id_pracownika 
		GROUP BY pen.stanowisko;
		
	--d)
		SELECT pen.stanowisko AVG(pen.kwota+pre.kwota),	MIN(pen.kwota+pre.kwota), MAX(pen.kwota+pre.kwota) 
		FROM firma.pensja_stanowisko pen 
		JOIN firma.wynagrodzenie wyn ON pen.id_pensji = wyn.id_pensji 
		JOIN firma.premia pre ON pre.id_premii = wyn.id_premii 
		WHERE pen.stanowisko = 'Prawnik' GROUP BY pen.stanowisko;
	
	-- e)
		SELECT SUM(firma.pensja_stanowisko.kwota + firma.premia.kwota) AS "Suma wynagrodzen"
		FROM firma.wynagrodzenie
		JOIN firma.pensja_stanowisko ON firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji
		JOIN firma.premia ON firma.wynagrodzenie.id_premii = firma.premia.id_premii;

	--f)
		SELECT pen.stanowisko, SUM(pen.kwota+pre.kwota) AS "Suma wynagrodzen" 
		FROM firma.wynagrodzenie w 
		JOIN firma.pensja pen ON w.id_pensji = pen.id_pensji 
		JOIN firma.premia pre ON w.id_premii = pre.id_premii 
		GROUP BY pen.stanowisko;
	
	--g)
		SELECT stanowisko, COUNT(firma.premia.kwota > 0) AS "Ilosc premii"
		FROM firma.pensja_stanowisko
		JOIN firma.wynagrodzenie ON firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji
		JOIN firma.premia ON firma.wynagrodzenie.id_premii = firma.premia.id_premii
		WHERE firma.premia.kwota > 0 GROUP BY firma.pensja_stanowisko.stanowisko;
 
	--h)
		DELETE FROM firma.pracownicy prac 
		USING firma.wynagrodzenie wyn, firma.pensja_stanowisko pen 
		WHERE prac.id_pracownika = wyn.id_pracownika AND pen.id_pensji = wyn.id_pensji AND pen.kwota < 1200;
 
 --8
	--a)
		UPDATE firma.pracownicy 
		SET telefon=CONCAT('(+48) ', telefon);
	
	--b)
		UPDATE firma.pracownicy 
		SET telefon=CONCAT(SUBSTRING(telefon, 1, 5), '-', SUBSTRING(telefon, 5, 2), '-', SUBSTRING(telefon, 10, 5));
	--c) 
		SELECT imie, UPPER(nazwisko) AS "nazwisko", adres, telefon 
		FROM firma.pracownicy 
		WHERE LENGTH(nazwisko) = (SELECT MAX(LENGTH(nazwisko)) FROM firma.pracownicy);
 
	--d)
		SELECT md5(imie) AS "imie", md5(nazwisko) AS "nazwisko", md5(adres) AS "adres", md5(telefon) AS "telefon", md5(CAST(firma.pensja_stanowisko.kwota AS varchar(20))) AS "pensja"
		FROM firma.pracownicy
		JOIN firma.wynagrodzenie ON firma.pracownicy.id_pracownika = firma.wynagrodzenie.id_pracownika
		JOIN firma.pensja_stanowisko ON firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji;
 
 
 --9
 SELECT concat('Pracownik ', pracownicy.imie, ' ', pracownicy.nazwisko, ', w dniu ', wynagrodzenie."data", ' otrzymał pensję całkowitą na kwotę ', 
			  pensja.kwota+premia.kwota,'zł, gdzie wynagrodzenie zasadnicze wynosiło: ', pensja.kwota, 'zł, premia: ', premia.kwota, 'zł. Liczba nadgodzin: ') 
			  AS "raport" FROM firma.pracownicy pracownicy JOIN firma.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
			  JOIN firma.pensja_stanowisko pensja ON pensja.id_pensji = wynagrodzenie.id_pensji JOIN firma.premia premia ON premia.id_premii = wynagrodzenie.id_premii;



 
 
 
 



		