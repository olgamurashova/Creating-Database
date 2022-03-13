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

