
-- \prompt 'enter some text: ' psqlvar
\prompt 'Enter vendor number: ' vendor_num
\prompt 'Enter account number: ' account_num
\prompt 'Enter amount: ' amount
\o /dev/null
-- select set_config('psql.psqlvar', :'psqlvar', false);
select set_config('psql.vendor_num', :'vendor_num', false);
select set_config('psql.account_num', :'account_num', false);
select set_config('psql.amount', :'amount', false);
\o
do $$
--   DECLARE var text = current_setting('psql.psqlvar');
  DECLARE vendorNum text = current_setting('psql.vendor_num');
  DECLARE accountNum text = current_setting('psql.account_num');
  DECLARE amount text = current_setting('psql.amount');
  DECLARE vno_counter int;
  DECLARE account_counter int;

BEGIN

  select COUNT(*) into vno_counter from v;
  select COUNT(*) into account_counter from c;

-- checking whether the input values are integer or not
--    and if vendor and account numbers exist on the table
  if not ((vendorNum ~ '^[1-9]+$') AND (cast(vendorNum as int) <= vno_counter)) then    
	    RAISE NOTICE 'Not VALID vendor number: %', vendorNum;
  elsif not ((accountNum ~ '^[1-9]+$') AND (cast(accountNum as int) <= account_counter)) then   
	    RAISE NOTICE 'Not VALID account number: %', accountNum;
  elsif not (amount ~ '^[1-9]+$') then   
	    RAISE NOTICE 'Not VALID amount: %', amount;
	else 
    INSERT INTO t VALUES (DEFAULT, cast(vendorNum as int), 
      cast(accountNum as int), CURRENT_DATE, cast(amount as int));

-- updates the balances of the related customer and vendor 
--    with the amount of the new transaction
    update c set Cbalance = Cbalance - cast(amount as int) 
        where Account = cast(accountNum as int);
    update v set Vbalance = Vbalance + cast(amount as int) 
        where Vno = cast(vendorNum as int); 
	end if; 

END;
$$;