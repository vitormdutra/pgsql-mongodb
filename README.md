
# postgresql-to-mongodb

to send data form pgsql to mongodb you need to install on your server [mongo_fdw_14](https://github.com/EnterpriseDB/mongo_fdw)

in this exemple i used a OracleLinux 8 VM in proxmox and [Ansible](https://docs.ansible.com/ansible/latest/index.html) to do the install process more fast

`ansible-playbook -u root -k {file}.yml -vvv`

to install mongo_fdw on OracleLinux you just need:

`yum install mongo_fdw_14`

after install mongo and postgres using ansible or doing manuely
you need to acess psql to run some sql query

```SQL
CREATE EXTENSION mongo_fdw;
CREATE  SERVER mongo FOREIGN DATA WRAPPER mongo_fdw OPTIONS (address  '127.0.0.1', port '27017');
-- create user mapping
CREATE  USER MAPPING FOR postgres SERVER mongo OPTIONS (username 'v1tor', password  'randompasswd123');
-- create foreign table
CREATE FOREIGN TABLE waza ( _id name, waza_id int, waza_name text, waza_created timestamptz ) SERVER mongo OPTIONS (database  'admin', collection  'waza');
SELECT * FROM waza WHERE waza_id = 0;
INSERT INTO waza VALUES (0, 1, 'test', '2015-11-11T08:13:10Z');
```

this process make all the data you insert in the table waza send to collection waza in the database admin on mongodb

a fell things we need to understand before using this process, we need a database on mongoDB or this pocess don't work, in my lab i used the Admin DB, but you can create a new for your project.

all update query you use in pgsql, the data change in mongodb.