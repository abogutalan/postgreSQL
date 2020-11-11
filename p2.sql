create or replace function q02(vendor_name char) returns void as $$ 
	declare 
        c2 cursor for select c.Account, Cname, Province FROM c,t,v 
            WHERE c.Account=t.Account AND v.Vno=t.Vno AND Vname=vendor_name;
		cust_num CHAR(5); 
		cust_name CHAR(20); 
		c_province CHAR(3); 
	begin 
        open c2;
        loop
        fetch c2 into cust_num, cust_name, c_province; 
        exit when not found;
        raise notice '~~~~~~~~~~~~~~~~~~~~~~~~~~ ';
		raise notice 'Customer Number: %', cust_num; 
		raise notice 'Customer Name: %', cust_name; 
		raise notice 'Province: %', c_province; 
        end loop;
        close c2;
	end; 
$$ language plpgsql;