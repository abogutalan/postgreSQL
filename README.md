> Connecting to Database:
$ psql –h db
    
> psql commands: 
To list all the psql commands
                             user_id=> \?
To get help on syntax of SQL command       
                             user_id=>\h
To quit from the database        
                             user_id=>\q
To list all the databases        
                             user_id=>\l
To list all the tables in your database       
                             user_id=>\d
To show the definition of a table        
                             user_id=>\d <tableName> 

> How ro run:        
    user_id=>\i filename.sql    
    EX: \i f01.sql 

> run a function:
    user_id=>select funcName();
    EX: select q03('Esso', 'Waterloo');                   

> a3data.sql : create the tables and insert the data

> p1.sql : displays data of all the transactions of a given customer
    \i p1.sql
    select q01('Doc');

> p2.sql : displays data of the customers who have transactions with a given vendor.
    \i p2.sql
    select q01('Esso');
> p3.sql : inserts a new customer record (tuple).
    - Whatever value the user passes for account and cbalance variables,
    the program auto increments account and sets ZERO to cbalance.
> p4.sql
> p5.sql
> p6.sql
> p7.sql
> p8.sql