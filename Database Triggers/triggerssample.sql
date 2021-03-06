SELECT * 
FROM customers
ORDER BY customer_id;

SELECT *
FROM customers_log;

//Creating UPDATE trigger

CREATE TRIGGER update_trigger
BEFORE UPDATE ON customers
FOR EACH ROW
EXECUTE PROCEDURE log_customers_change();

//Updating values in the table

UPDATE customers
SET first_name = 'Kirk'
WHERE customer_id = 1;

UPDATE customers
SET last_name = 'Donovan'
WHERE customer_id = 3;

// Checking if triggers fired and recorded activity

SELECT * 
FROM customers
ORDER BY customer_id;

SELECT *
FROM customers_log;

//Confirming no log is created when modifying a column not covered by the trigger function

UPDATE customers
SET years_old = 333
WHERE customer_id = 1;

SELECT *
FROM customers
ORDER BY customer_id;

SELECT *
FROM customers_log;

//Creating INSERT trigger to return a  single record of who did bulk inserts

CREATE TRIGGER insert_trigger
BEFORE INSERT ON customers
FOR EACH STATEMENT
EXECUTE PROCEDURE log_customers_change();

// log_customers_change() function(UPDATE/INSERT)

CREATE OR REPLACE FUNCTION log_customers_change() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'UPDATE') THEN
            IF (NEW.first_name <> OLD.first_name OR NEW.last_name <> OLD.last_name) THEN
                INSERT INTO customers_log (changed_by, time_changed, change_type) VALUES (User, DATE_TRUNC('minute',NOW()), 'UPDATE');
            END IF;
        END IF;
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO customers_log (changed_by, time_changed, change_type) VALUES (User, DATE_TRUNC('minute',NOW()), 'INSERT');
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE PLPGSQL;

// Inserting values in the table and checking if the trigger has been recorded

INSERT INTO customers (first_name, last_name, email_address, home_phone, city, state_name, years_old)
VALUES ('Jeffrey','Cook','Jeffrey.Cook@example.com','202-555-0398','Jersey city','New Jersey',66);

SELECT *
FROM customers
ORDER BY customer_id;

SELECT *
FROM customers_log;

// Setting conditionals

CREATE TRIGGER customer_min_age
BEFORE UPDATE ON customers
FOR EACH ROW
WHEN (NEW.years_old < 13)
EXECUTE PROCEDURE override_with_min_age();

UPDATE customers
SET years_old = 11
WHERE customer_id = 1;

UPDATE customers
SET years_old = 14
WHERE customer_id = 2;

SELECT * FROM customers ORDER BY customer_id;
SELECT * FROM customers_log;

// Dropping a trigger

 DROP TRIGGER IF EXISTS customer_min_age ON customers;
 SELECT * FROM information_schema.triggers;


