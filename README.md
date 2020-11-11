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


    