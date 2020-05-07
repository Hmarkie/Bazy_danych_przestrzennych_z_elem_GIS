--cwiczenia 5

CREATE DATABASE cw5;
--tabela obiekty
CREATE TABLE obiekty(
	nazwa varchar(30),
	geometria geometry
	);

INSERT INTO obiekty (nazwa,geometria)
	VALUES ('obiekt1', ST_GeomFromText('COMPOUNDCURVE((0 1, 1 1),
										CIRCULARSTRING(1 1, 2 0, 3 1),
										CIRCULARSTRING(3 1, 4 2, 5 1),
										(5 1, 6 1))'));
INSERT INTO obiekty (nazwa, geometria)
	VALUES ('obiekt2', ST_GeomFromText('CURVERPOLYGON(COMPOUNDCURVE((10 2, 10 6, 14 6),
									  CIRCULARSTRING(14 6, 16 4, 14 2, 12 0, 10 2)),
									  CIRCULARSTRING(11 2, 13 2, 11 2))'));
INSERT INTO obiekty (nazwa, geometria)
	VALUES ('obiekt3', ST_GeomFromText('POLYGON(( 10 17, 7 15, 12 13, 10 17))'));
INSERT INTO obiekty (nazwa, geometria)
	VALUES ('obiekt4', ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5))'));
INSERT INTO obiekty (nazwa, geometria)
	VALUES ('obiekt5', ST_GeomFromText('GEOMETRYCOLLECTION(MULTIPOINT(30 30 59, 38 32 234))'));
INSERT INTO obiekty (nazwa, geometria)
	VALUES ('obiekt6', ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(1 1, 3 2), POINT(4 2))'));

SELECT * FROM obiekty;

--1. Pole powierzchni bufora o wielkości 5 jednostek, który został utworzony wokół najkrótszej linii łączącej obiekt 3 i 4.
SELECT ST_Area(ST_Buffer(ST_ShortestLine(x.geom, y.geom),5)) FROM obiekty x, obiekty y
	WHERE x.nazwa='obiekt3' AND y.nazwa='obiekt4';

--2. Obiekt4 zmieniony na poligon
SELECT ST_MakePolygon(ST_AddPoint(a.open_line, ST_StartPoint(a.open_line)))
	FROM (SELECT geometria AS open_line FROM obiekty WHERE nazwa='obiekt4') AS a;
	
--3. Obiekt7 zapisany jako obiekt złożony z obiektu 3 i obiektu 4 w tabeli obiekty
INSERT INTO obiekty	
	VALUES ('obiekt7', ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(7 15, 10 17),
									   LINESTRING(10 17, 12 13),
									   LINESTRING(12 13, 7 15),
									   LINESTRING(20 20, 25 25),
									   LINESTRING(25 25, 27 24),
									   LINESTRING(27 24, 25 22),
									   LINESTRING(25 22, 26 21),
									   LINESTRING(26 21, 22 19),
									   LINESTRING(22 19, 20.5 19.5))',-1));

-- Pole powierzchni wszystkich buforów o wielkości 5 jednostek, które zostały utworzone wokół obiektów nie zawierających łuków.						
SELECT nazwa, ST_Area(ST_Buffer(geometria, 5)) FROM obiekty
	WHERE not ST_HasArc(geometria);
