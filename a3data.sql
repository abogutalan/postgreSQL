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

-- functions




       

-- // to do: double-check c_Cbalance



-- // to do : display no transaction only?
-- newly added customer does not exist on transaction table 
--  thus we should print no transaction for that one.
create or replace function q04() returns void as $$ 
	declare 
        c4 cursor for select DISTINCT ON (c.Account)c.Account,Cname,Amount,Vname FROM c,t,v
            WHERE c.Account=t.Account AND v.Vno=t.Vno ORDER BY c.Account,T_Date DESC;
		cust_num CHAR(5); 
		cust_name CHAR(20); 
		trans_amount NUMERIC(10,2); 
        vendor_name CHAR(20);
	begin 
        open c4;
        loop
        fetch c4 into cust_num, cust_name, trans_amount, vendor_name; 
        exit when not found;
        raise notice '~~~~~~~~~~~~~~~~~~~~~~~~~~ ';
		raise notice 'Customer Number: %', cust_num; 
		raise notice 'Customer Name: %', cust_name; 
        raise notice 'Vendor Name: %', vendor_name;
        if (trans_amount>0) then 
				raise notice 'Amount: %', trans_amount; 
			else 
				raise notice 'no transaction'; 
		end if; 
        end loop;
        close c4;
	end; 
$$ language plpgsql;


create or replace function q05() returns void as $$
	declare 
        c1 cursor for select SUM(Amount) FROM v,t WHERE v.Vno=t.Vno;
        c2 cursor for select v.Vno,Vname,Vbalance FROM v,t WHERE v.Vno=t.Vno GROUP BY Vbalance,v.Vno;
        total_amount integer;
        vendor_no CHAR(5);
        vendor_name CHAR(20);
        vendor_balance NUMERIC(10,2); 
    begin 
		open c1; 
		loop 
			fetch c1 into total_amount; 
			exit when not found; 
				update v set Vbalance = Vbalance + total_amount;
				
		end loop; 
		close c1;

        open c2; 
		loop 
			fetch c2 into vendor_no, vendor_name, vendor_balance; 
			exit when not found; 
			raise notice '~~~~~~~~~~~~~~~~~~~~~~~~~~ '; 
			raise notice 'vendor_no: %', vendor_no; 
			raise notice 'vendor_name: %', vendor_name; 
			raise notice 'New balance: %', vendor_balance; 
		end loop; 
		close c2;
	end; 
$$ language plpgsql;

create or replace function q06() returns void as $$
	declare 
        c1 cursor for select Vname,Vbalance FROM v;
        vendor_name CHAR(20);
        vendor_balance real; 
        new_balance NUMERIC(10,2); 
    begin 
		open c1; 
		loop 
			fetch c1 into vendor_name, vendor_balance; 
			exit when not found; 
				update v set Vbalance = Vbalance - vendor_balance*4/100;
                new_balance := vendor_balance - vendor_balance*4/100;
                raise notice '~~~~~~~~~~~~~~~~~~~~~~~~~~ ';
                raise notice 'vendor_name: %', vendor_name; 
                raise notice 'fee charged: %', vendor_balance*4/100; 
                raise notice 'New balance: %', new_balance; 
                
		end loop; 
		close c1;

	end; 
$$ language plpgsql;

create or replace function q07() returns void as $$
	declare 
        c1 cursor for select Cname,Cbalance,Crlimit FROM c WHERE Cbalance > Crlimit;
        cust_name CHAR(20);
        current_balance NUMERIC(10,2); 
        new_balance NUMERIC(10,2); 
        service_fee NUMERIC(10,2);
        credit_limit INTEGER;
    begin 
		open c1; 
		loop 
			fetch c1 into cust_name, current_balance,credit_limit; 
			exit when not found; 

				if (current_balance > credit_limit) then 
                    service_fee := (current_balance - credit_limit) * 10/100;
                    update c set Cbalance = Cbalance + service_fee; 
                
                end if;
                raise notice '~~~~~~~~~~~~~~~~~~~~~~~~~~ ';
                new_balance := current_balance + service_fee;
                raise notice 'cust_name: %', cust_name; --CONCAT(trim(cust_name),1)
                raise notice 'New balance: %', new_balance; 
                
		end loop; 
		close c1;

	end; 
$$ language plpgsql;






-- create or replace function q05() returns void as $$
-- 	declare 
--         c1 cursor for select Account, count(*) from t group by Account;
--         c2 cursor for select Account, Cname, Cbalance from c; 
--         acc char(10); 
--         num_trans integer;
--         cust_acc char(10); 
--         cust_name char(10); 
--         cust_balance real;
      
--     begin 
-- 		open c1; 
-- 		loop 
-- 			fetch c1 into acc, num_trans; 
-- 			exit when not found; 
-- 			if (num_trans>1) then 
-- 				update c set Cbalance = Cbalance + 100 
-- 					where Account = acc; 
-- 			else 
-- 				update c set Cbalance = Cbalance - 100 
-- 				where Account = acc; 
-- 			end if; 
-- 		end loop; 
-- 		close c1;
        
--         open c2; 
-- 		loop 
-- 			fetch c2 into cust_acc, cust_name, cust_balance; 
-- 			exit when not found; 
-- 			raise notice 'Account: %', cust_acc; 
-- 			raise notice 'Customer name: %', cust_name; 
-- 			raise notice 'New balance: %', cust_balance; 
-- 			raise notice '~~~~~~~~~~~~~~~~~~~~~~~~~~ '; 
-- 		end loop; 
-- 		close c2;
-- 	end; 
-- $$ language plpgsql;
                     

-- create or replace function q03(v_name char, v_city char) returns void as $$ 
-- 	declare 
-- 		vendor_num char(10); 
-- 	begin 
-- 		select Vno into vendor_num from v 
-- 			where Vname = v_name and City = v_city; 
-- 		raise notice 'Vendor number is: %', vendor_num; 
-- 	end; 
-- $$ language plpgsql;
-- vendor_num is destination for the result data of the query
-- run command: select q03('Esso', 'Waterloo');





