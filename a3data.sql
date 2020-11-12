/* 
     * Abdullah Ogutalan
     * 1109732  
     * cis3530
     * A3
*/ 

-- drop tables
DROP TABLE t;
DROP TABLE c;
DROP TABLE v;

-- create tables
CREATE TABLE c (
    Account SERIAL, 
    Cname CHAR(20), 
    Province CHAR(3),
    Cbalance NUMERIC(10,2), 
    Crlimit INTEGER, 
    PRIMARY KEY (Account)
    );

CREATE TABLE v (
    Vno SERIAL, 
    Vname CHAR(20), 
    City CHAR(30),
    Vbalance NUMERIC(10,2), 
    PRIMARY KEY (Vno)
    );

CREATE TABLE t (
    Tno SERIAL,
    Vno SERIAL,
    Account SERIAL, 
    T_Date Date,
    Amount NUMERIC(10,2), 
    PRIMARY KEY (Tno),
    FOREIGN KEY (Vno) REFERENCES v(Vno),
    FOREIGN KEY (Account) REFERENCES c(Account)
    );

INSERT INTO c VALUES (DEFAULT, 'Smith', 'ONT', 2515.00, 2000), 
                     (DEFAULT, 'Jones', 'BC', 2014.00, 2500),
                     (DEFAULT, 'Doc', 'ONT', 150.00, 1000);
                     
INSERT INTO v VALUES (DEFAULT, 'IKEA', 'Toronto', 200.00), 
                     (DEFAULT, 'Walmart', 'Waterloo', 671.05),
                     (DEFAULT, 'Esso', 'Windsor', 0.00),
                     (DEFAULT, 'Esso', 'Waterloo', 225.00);  
                     --        V  C
INSERT INTO t VALUES (DEFAULT, 2, 1, '2020-07-15', 1325.00), 
                     (DEFAULT, 2, 3, '2019-12-16', 1900.00),
                     (DEFAULT, 3, 1, '2020-09-01', 2500.00),
                     (DEFAULT, 4, 2, '2020-03-20', 1613.00),
                     (DEFAULT, 4, 3, '2020-07-31', 2212.00);    


