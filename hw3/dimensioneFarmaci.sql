SET SEARCH_PATH TO "farmacie";
DROP TABLE IF EXISTS KKVersioniFarmaci CASCADE; 

CREATE TABLE KKVersioniFarmaci (
KFarmaco serial primary key,
Codice integer,
Fascia character(1)
);
INSERT into KKVersioniFarmaci(Codice,Fascia)
SELECT F.Codice, F.Fascia
FROM Farmaci F
WHERE (F.Codice,F.Fascia)
NOT IN(SELECT Codice, Fascia FROM KKVersioniFarmaci);

CREATE TABLE KKFarmaci (
KFarmaco serial primary key,
Codice integer
);
INSERT into KKFarmaci(Codice)
SELECT F.Codice
FROM Farmaci F
WHERE F.Codice NOT IN(SELECT Codice FROM KKFarmaci);

CREATE TABLE farmaco (
	kversionefarmaco integer,
	kfarmaco integer,
	codfarmaco integer,
	descrizionefarmaco character varying,
	codmolecola integer,
	descrizionemolecola character varying,
	codcasa integer,
	nomecasa character varying,
	fascia character varying
);

INSERT into farmaco(kversionefarmaco,kfarmaco,codfarmaco,descrizionefarmaco,codmolecola,descrizionemolecola,codcasa,nomecasa,fascia)
SELECT KKF.kfarmaco as kversionefarmaco, KF.kfarmaco, F.Codice as codfarmaco, f.Descrizione as descrizionefarmaco, F.CodMolecola, M.Descrizione as descrizionemolecola, 
	C.CodCasa, C.Nome as nomecasa, F.Fascia
FROM Farmaci F join Molecole M on F.CodMolecola=M.CodMolecola natural join Casefarmaceutiche C natural join kkfarmaci KF, kkversionifarmaci KKF
WHERE KKF.codice = F.codice AND KKF.fascia = F.fascia
