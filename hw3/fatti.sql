CREATE TABLE Fatti (
	CodASLF integer,
	CodASLP integer,
	Data date,
	eta integer,
	CodFarmaco integer,
	fascia character varying,
	CodRicetta integer,
	prezzototale numeric,
	quantitatotale bigint,
	PRIMARY KEY (CodASLF,CodASLP,CodFarmaco,CodRicetta)
);

INSERT INTO Fatti(CodASLF,CodASLP,Data,Eta,codfarmaco,Fascia,CodRicetta,PrezzoTotale,QuantitaTotale)
SELECT AF.kaslfarmacia as CodASLF, AP.kaslpaziente as CodASLP, R.Data as Data,
	(R.Data-P.DataNascita)/365 as Eta, FO.kversionefarmaco as codfarmaco, F.Fascia,
	RA.kricetta as CodRicetta, sum(prezzo) as PrezzoTotoale, sum(quantita) as QuantitaTotale
FROM Ricette R 
	join ElementiRicetta E on R.Numero=E.NumeroRicetta
	join Farmaci F on E.CodFarmaco=F.Codice
	join Farmacie FE on R.CodFarmacia=FE.CodFarmacia
	join Territorio T on FE.Via=T.Via AND FE.NumeroCivico=T.NumeroCivico AND FE.Citta=T.Citta
	join Pazienti P on R.CFPaziente=P.CF
	join Territorio TT on P.Via=TT.Via AND P.NumeroCivico=TT.NumeroCivico AND P.Citta=TT.Citta
	join aslfarmacia AF on T.ASL=AF.codiceaslfarmacia
	join aslpaziente AP on TT.ASL=AP.codiceaslpaziente
	join farmaco FO on E.CodFarmaco=FO.CodFarmaco
	join ricetta RA on R.Numero=RA.CodRicetta
GROUP BY AF.kaslfarmacia, AP.kaslpaziente, FO.kversionefarmaco, RA.kricetta, r.data, eta, f.fascia
