--ćw 6 GIS

--1. Dla warstwy treeszmień ustawienia tak, aby lasy liściaste, iglaste i mieszane wyświetlane były innymi kolorami. Podaj pole powierzchni wszystkich lasów o charakterze mieszanym.
--Własciwosi war. trees-> Styl-> War. unikalna-> dla VEGDESC-> kolory-> Klasyfikuj
	SELECT SUM(trees.AREA_KM2) AS Pole_mieszanych FROM trees 
		WHERE VEGDESC='Mixed Trees';

--3. Długość linii kolejowych dla regionu Matanuska-Susitna.
	SELECT SUM(ST_Length(railroads.GEOMETRY)) AS Dlugość_linii_kolejowych 
	FROM regions, railroads 
	WHERE regions.NAME_2='Matanuska-Susitna';
--Odp. 2768932,0458

--4. Średnia wysokość nad poziomem morza, gdzie są położone lotniska o charakterze militarnym
	SELECT AVG(ELEV) AS Srednia_wysokosc 
	FROM airports 
	WHERE USE='Military';
--Odp. 593.25

	--Ilość lotnisk o charakterze militarnym
	SELECT COUNT(*) AS il_militarnych 
	FROM airports 
	WHERE USE='Military';
--Odp. 8

	--Ilosc lotnisk powyżej 1400m 
	SELECT COUNT(*) AS il_militarnych 
	FROM airports 
	WHERE USE='Military' AND ELEV>1400;
--Odp. 1

--5. Utwórz warstwę, na której znajdować się będą jedynie budynki położone w regionie Bristol Bay
	SELECT COUNT(*) AS il_budynkow 
	FROM popp, regions 
	WHERE regions.NAME_2='Bristol Bay' AND popp.F_CODEDESC='Building' AND Contains(regions.geometry, popp.geometry);
	
	SELECT COUNT(*) AS il_budynkow2 
	FROM popp, regions, rivers 
	WHERE popp.F_CODEDESC='Building' AND regions.NAME_2='Bristol Bay' AND ST_Contains(ST_Buffer(rivers.Geometry,100000), popp.Geometry) AND ST_Contains(regions.geometry, popp.geometry);
--Odp. 5

--6. w ilu miejscach przecinają się rzeki (majrivers) z liniami kolejowymi (railroads).
	SELECT COUNT(*) 
	FROM majrivers, railroads 
	WHERE ST_Intersects(majrivers.Geometry, railroads.Geometry);
	
--7. Węzły dla warstwy railroads.
	--Wektor ->narzedzie analizy->Przecięcia lini
	--164 węzły

--8. Najlepsze lokalizacje do budowy hotelu.
	SELECT  NAME_2 
	FROM regions , airports , railroads  
	WHERE ST_Distance(airports.GEOMETRY, regions.GEOMETRY) < 100000 AND ST_Distance(railroads.GEOMETRY, regions.GEOMETRY) >= 50000  LIMIT 1;

--9. Uproszczona geometria warstwy przedstawiającej bagna.
	--Wektor->Narzędzia geometrii->Uprość geometrię-> tolerancja= 100
	--pole bez zmian po urposzczeniu




