create or replace function q03(c_account int, c_Cname char, c_Province char, c_Cbalance NUMERIC, c_Crlimit INTEGER) returns void as $$ 
	
	declare 
        c3 cursor for select * from c;
		Account int;
        Cname CHAR(20);
        Province CHAR(3);
        Cbalance NUMERIC(10,2);
        Crlimit INTEGER;
	begin 
	INSERT INTO c VALUES (DEFAULT, c_Cname, c_Province, 0.00, c_Crlimit);
        open c3;
        loop
        fetch c3 into Account,Cname,Province,Cbalance,Crlimit;
        exit when not found;
        raise notice '~~~~~~~~~~~~~~~~~~~~~~~~~~ ';
		raise notice 'Account: %', Account; 
		raise notice 'Cname: %', Cname; 
		raise notice 'Province: %', Province;
        raise notice 'Cbalance: %', Cbalance; 
		raise notice 'Crlimit: %', Crlimit; 
        end loop;
        close c3;
	end; 
$$ language plpgsql;
-- select q03(4, 'abdullah', 'ONT', 0.00, 3228);