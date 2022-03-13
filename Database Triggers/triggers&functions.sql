1. Sample trigger query(UPDATE):

CREATE TRIGGER check_update
    BEFORE UPDATE ON accounts
    FOR EACH ROW
    EXECUTE PROCEDURE check_account_update();
    
2. Sample trigger query(INSERT):

CREATE TRIGGER insert_trigger
    BEFORE INSERT ON customers
    FOR EACH ROW
    EXECUTE PROCEDURE insert_function();

CREATE OR REPLACE FUNCTION insert_function() RETURNS TRIGGER AS $$
    BEGIN
        NEW.last_name := 'UNKOWN';
        RETURN NEW;
    END;
$$ LANGUAGE PLPGSQL;

3. Sample trigger(UPDATE/AFTER)

CREATE TRIGGER after_trigger
AFTER UPDATE ON customers
FOR EACH ROW
EXECUTE PROCEDURE log_customers_change();

4. Sample trigger(UPDATE/ for each statement)

CREATE TRIGGER each_statement_trigger
AFTER UPDATE ON customers
FOR EACH STATEMENT 
EXECUTE PROCEDURE statement_function();

5. Sample / filter when the trigger calls

CREATE TRIGGER insert_trigger_high
BEFORE INSERT ON clients
FOR EACH ROW
WHEN (NEW.total_spent >= 1000)
EXECUTE PROCEDURE high_spender();

CREATE TRIGGER insert_trigger_low
BEFORE INSERT ON clients
FOR EACH ROW
WHEN (NEW.total_spent < 1000)
EXECUTE PROCEDURE not_a_high_spender();

6.  Sample / filter when the trigger calls

CREATE TRIGGER update_trigger_high
BEFORE UPDATE ON clients
FOR EACH ROW
WHEN (NEW.total_spent >= 1000)
EXECUTE PROCEDURE set_high_spender();

CREATE TRIGGER update_trigger_low
BEFORE UPDATE ON clients
FOR EACH ROW
WHEN (NEW.total_spent < 1000)
EXECUTE PROCEDURE  set_low_spender();
