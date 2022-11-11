CREATE TABLE KKAsl (
Kasl serial primary key,
Codice integer
);
INSERT into KKASl(Codice)
SELECT Codice
FROM Asl
WHERE Codice NOT IN(SELECT Codice FROM KKAsl);

CREATE TABLE aslpaziente (
	kaslpaziente integer,
	codiceaslpaziente integer,
	nomeaslpaziente character varying
);

CREATE TABLE aslfarmacia (
	kaslfarmacia integer,
	codiceaslfarmacia integer,
	nomeaslfarmacia character varying
);

INSERT into aslpaziente(kaslpaziente,codiceaslpaziente,nomeaslpaziente)
SELECT KKA.kasl as kaslpaziente, A.Codice as codiceaslpaziente, A.Nome as nomeaslpaziente
FROM Pazienti P natural join Territorio T join Asl A on A.Codice=T.ASL natural join kkasl KKA;


INSERT into aslfarmacia(kaslfarmacia,codiceaslfarmacia,nomeaslfarmacia)
SELECT KKA.kasl as kaslfarmacia, A.Codice as codiceaslfarmacia, A.Nome as nomeaslfarmacia
FROM Farmacie F natural join Territorio T join Asl A on A.Codice=T.ASL natural join kkasl KKA
