SET SEARCH_PATH TO "farmacie";
DROP TABLE IF EXISTS eta CASCADE; 
create table eta (
	keta serial primary key,
	anni integer,
	fascia varchar(10)
);
COPY eta(anni,fascia)
FROM 'hw3/out.csv'
DELIMITER ','
CSV HEADER;

select * from eta
