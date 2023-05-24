CREATE EXTENSION mongo_fdw;
CREATE  SERVER mongo FOREIGN DATA WRAPPER mongo_fdw OPTIONS (address  '127.0.0.1', port '27017');
-- create user mapping
CREATE  USER MAPPING FOR postgres SERVER mongo OPTIONS (username 'v1tor', password  'randompasswd123');
-- create foreign table
CREATE FOREIGN TABLE waza ( _id name, waza_id int, waza_name text, waza_created timestamptz ) SERVER mongo OPTIONS (database  'admin', collection  'waza');
SELECT * FROM waza WHERE waza_id = 0;
INSERT INTO waza VALUES (0, 1, 'test', '2015-11-11T08:13:10Z');