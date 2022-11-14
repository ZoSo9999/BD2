create table data (
	kdata serial primary key,
	datanumerica date
);
COPY data(datanumerica)
FROM '/hw3/date.csv'
DELIMITER ','
CSV HEADER;
