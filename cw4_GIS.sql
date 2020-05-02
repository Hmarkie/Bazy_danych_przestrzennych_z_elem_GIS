--cw4

--Liczba budykow odl. <100000m od rzek glownych
	CREATE TABLE tableB as

	SELECT f_codedesc as liczba_budynkow
	FROM popp p, majrivers m 
	WHERE  Contains(Buffer(m.Geometry, 100000), p.Geometry);

	SELECT * FROM tableB;
	
--Tabela airportsNew.
	CREATE TABLE airportsNew as
	SELECT NAME, Geometr, ELEV
	FROM airports;
	SELECT * FROM airportsNew;
	
--a) lotnisko polozone najbardziej na zachod i na wschod
	--zachod
	SELECT NAME, ELEV
	FROM airportsNew ORDER BY MbrMinY(Geometry) asc limit 1;
	
	--wschod
	SELECT NAME, ELEV
	FROM airportsNew ORDER BY MbrMaxY(Geometry) desc limit 1;

--b)nowy obiekt-lotnisko (airportB)-polozony w połowie drogi pomiędzy lotniskami znalezionymi w punkcie a.
--Obliczona wysokość n.p.m., jako średnią wartość atrybutów elev.
	INSERT INTO airportsNew (NAME, Geometry, ELEV) 
		VALUES ('airportB', (0.5*ST_Distance((SELECT Geometry FROM airportsNew WHERE NAME 'NOATAK'),
				(SELECT Gemoetry FROM airportsNew WHERE NAME='NIKOLSKI AS'))),
				(SELECT avg(ELEV) FROM airportsNew WHERE NAME='NOATAK' OR NAME='NIKOLSKI AS'));

	SELECT * FROM airportsNew
	WHERE NAME='NOATAK' OR NAME='NIKOLSKI AS' OR NAME='airportB';

--Pole powierzchni obszaru oddalonego o mniej niz o 1000 jednostek od najkrótszej linii łączącej wyznaczone w zadaniu jezioro i lotnisko 
	SELECT AREA(BUFFER(DISTANCE(lak.Geometry, a.Geometry),1000))
	FROM lakes lak, airports a WHERE lak.NAMES="Iliamma Lake" a.NAME="AMBLER";


--Napisz zapytanie, które zwróci sumaryczne pole powierzchni poligonów reprezentujących poszczególne typy drzew znajdujących się na obszarze tundry i bagien.
	SELECT SUM(trees.AREA_KM2) AS pole FROM tundra, trees, swamp 
	WHERE Intersects(tundra.Geometry, trees.Geometry) OR Intersects(swamp.Geometry, trees.Geometry);

