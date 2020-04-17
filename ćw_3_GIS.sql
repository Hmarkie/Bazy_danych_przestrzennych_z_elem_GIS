--ćwiczenia nr 3
CREATE DATABASE cw3_gis;
CREATE EXTENSION postgis;

--tabela budynki
CREATE TABLE budynki(
	id_b serial NOT NULL,
	geometria geometry,
	nazwa VARCHAR(40),
	wysokosc FLOAT
	CONSTRAINT budynki_pk PRIMARY KEY (id_b)
	
);

-- tabela drogi
CREATE TABLE drogi(
	id_d serial NOT NULL,
	geometria geometry NOT NULL,
	nazwa VARCHAR (30) NOT NULL,
	CONSTRAINT drogi_pk PRIMARY KEY (id_d)
);

--tabela pktinfo
CREATE TABLE pktinfo(
	id_p serial NOT NULL,
	geometria geometry NOT NULL,
	nazwa varchar(30) NOT NULL,
	liczprac int,
	CONSTRAINT pktinfo_pk PRIMARY KEY (id_p)
);
	
	
--budynki
INSERT INTO budynki( geometria, nazwa, wysokosc)
	VALUES (ST_GeomFromText('POLYGON((3 8, 5 8, 5 6, 3 6, 3 8))',-1), 'BuildingC','5');
INSERT INTO budynki( geometria, nazwa, wysokosc)
	VALUES (ST_GeomFromText('POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))',-1), 'BuildingB','10');
INSERT INTO budynki( geometria, nazwa, wysokosc)
	VALUES (ST_GeomFromText('POLYGON((9 9, 10 9, 10 8, 9 8, 9 9))',-1), 'BuildingD','15');
INSERT INTO budynki( geometria, nazwa, wysokosc)
	VALUES (ST_GeomFromText('POLYGON((1 2, 2 2, 2 1, 1 1, 1 2))',-1), 'BuildingF','20');
INSERT INTO budynki( geometria, nazwa, wysokosc)
	VALUES (ST_GeomFromText('POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))',-1), 'BuildingA','25');

--drogi
INSERT INTO drogi( geometria, nazwa)
	VALUES (ST_GeomFromText('LINESTRING(7.5 10.5, 7.5 0)',-1), 'RoadY');	
INSERT INTO drogi( geometria, nazwa)
	VALUES (ST_GeomFromText('LINESTRING(0 4.5, 12 4.5)',-1), 'RoadX');

--pktinfo
INSERT INTO pktinfo( geometria, nazwa, liczprac)
	VALUES (ST_GeomFromText('POINT(6 9.5)',-1), 'K', '2');
INSERT INTO pktinfo( geometria, nazwa, liczprac)
	VALUES (ST_GeomFromText('POINT(6.5 6)',-1), 'J', '4');
INSERT INTO pktinfo( geometria, nazwa, liczprac)
	VALUES (ST_GeomFromText('POINT(9.5 6)',-1), 'I', '6');
INSERT INTO pktinfo( geometria, nazwa, liczprac)
	VALUES (ST_GeomFromText('POINT(1 3.5)',-1), 'G', '8');
INSERT INTO pktinfo( geometria, nazwa, liczprac)
	VALUES (ST_GeomFromText('POINT(5.5 1.5)',-1), 'H', '9');

--1
SELECT SUM(ST_Length(geometria)) AS "Calkowita dlugosc drog: " FROM drogi;

--2
SELECT geometria AS "Geometria: ", ST_Area(geometria) 
AS "Pole powierzchni: ", ST_Perimeter(geometria) 
AS "Obwod " FROM budynki
WHERE nazwa = 'BuildingA';

--3
SELECT nazwa, ST_Area(geometria) AS "Pole powierzchni" FROM budynki
ORDER BY nazwa ASC;

--4
SELECT nazwa,ST_Perimeter(geometria) AS "Obwod" FROM budynki ORDER BY ST_Area(geometria) DESC LIMIT 2;

--5
SELECT ST_Distance(budynki.geometria, pktinfo.geometria) FROM budynki, pktinfo 
WHERE budynki.nazwa=='BuildingC' AND pktinfo.nazwa='G';

--6
SELECT ST_Area(ST_Difference(geometria, (SELECT ST_Buffer(geometria, 0.5, 'join=mitre') FROM budynki
WHERE nazwa=='BuildingB'))) AS "Pole powierzchni" FROM budynki WHERE budynki.nazwa='BuildingC';

--7
SELECT budynki.* FROM budynki, drogi 
WHERE drogi.nazwa='RoadX' AND ST_Centroid(budynki.geometria)|>>drogi.geometria;

--8
SELECT ST_Area(ST_SymDifference(budynki.geometria, ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))'))) AS "Pole powierzchni" FROM budynki
WHERE budynki.nazwa='BuildingC';












