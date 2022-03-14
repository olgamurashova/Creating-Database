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
