/* 
     * Abdullah Ogutalan
     * 1109732  
     * cis3530
     * A3
*/ 

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