CREATE TABLE ricetta (
Kricetta serial primary key,
Codricetta integer
);
INSERT into ricetta(Codricetta)
SELECT Numero
FROM Ricette
WHERE Numero NOT IN(SELECT Codricetta FROM ricetta);
