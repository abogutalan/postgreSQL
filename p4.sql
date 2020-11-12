/* 
     * Abdullah Ogutalan
     * 1109732  
     * cis3530
     * A3
*/ 

create or replace function q04() returns void as $$ 
	declare 
        c4 cursor for select DISTINCT ON (c.Account)c.Account,Cname,Amount,Vname FROM c,t,v
            WHERE c.Account=t.Account AND v.Vno=t.Vno ORDER BY c.Account,T_Date DESC;
		newCustList cursor for select Account from c;

        cust_num int; 
		new_cust_num int; 
		cust_name CHAR(20); 
		trans_amount NUMERIC(10,2); 
        vendor_name CHAR(20);
	begin 
        open c4;
        open newCustList;
        loop
        fetch c4 into cust_num, cust_name, trans_amount, vendor_name; 
        fetch newCustList into new_cust_num;
        exit when not found;


        if (trans_amount>0) then 
                raise notice '~~~~~~~~~~~~~~~~~~~~~~~~~~ ';
                raise notice 'Customer Number: %', cust_num; 
                raise notice 'Customer Name: %', cust_name; 
                raise notice 'Vendor Name: %', vendor_name;
				raise notice 'Amount: %', trans_amount; 
			else 
                raise notice '~~~~~~~~~~~~~~~~~~~~~~~~~~ ';
                raise notice 'Customer Number: %', new_cust_num;
				raise notice 'no transaction'; 
		end if; 
        end loop;
        close newCustList;
        close c4;
	end; 
$$ language plpgsql;