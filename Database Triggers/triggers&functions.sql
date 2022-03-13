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


