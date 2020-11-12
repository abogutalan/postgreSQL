/* 
     * Abdullah Ogutalan
     * 1109732  
     * cis3530
     * A3
*/ 

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
