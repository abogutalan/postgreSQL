/* 
     * Abdullah Ogutalan
     * 1109732  
     * cis3530
     * A3
*/ 
create or replace function q01(cust_name char) returns void as $$ 
	declare 
        c1 cursor for select Vname, T_Date, Amount FROM c,t,v 
            WHERE c.Account=t.Account AND v.Vno=t.Vno AND Cname=cust_name;
		vendor_name CHAR(20); 
		trans_date Date; 
		trans_amount NUMERIC(10,2); 
	begin 
        open c1;
        loop
        fetch c1 into vendor_name, trans_date, trans_amount; 
        exit when not found;
        raise notice '~~~~~~~~~~~~~~~~~~~~~~~~~~ ';
		raise notice 'Vendor name: %', vendor_name; 
		raise notice 'Date: %', trans_date; 
		raise notice 'Amount: %', trans_amount; 
        end loop;
        close c1;
	end; 
$$ language plpgsql;