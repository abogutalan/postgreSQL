/* 
     * Abdullah Ogutalan
     * 1109732  
     * cis3530
     * A3
*/ 

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