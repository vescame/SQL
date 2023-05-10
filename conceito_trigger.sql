/* trigger */
/* created to be executed in the smallest slice of the transaction
{
  INSERT
  UPDATE
  DELETE
}
  every database system has the operations above;
  depends on the database management system;

sintax:
 create or replace trigger TRIGGER_NAME on $TB_NAME
    before/after UPDATE/DELETE/INSERT
    for each row
    begin
      -- code
    end;
    /

during execution
  temp variables -- only when using 'for each row'
-- ORACLE
  :old.$COL_NAME
  :new.$COL_NAME
-- MSSQL equivalent table
  deleted
  inserted
  
-- FROM INTERNET
CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER } triggering_event ON table_name
[FOR EACH ROW]
[FOLLOWS | PRECEDES another_trigger]
[ENABLE / DISABLE ]
[WHEN condition]
DECLARE
    declaration statements
BEGIN
    executable statements
EXCEPTION
    exception_handling statements
END;

-- EXAMPLE
CREATE OR REPLACE TRIGGER customers_audit_trg
    AFTER 
    UPDATE OR DELETE 
    ON customers
    FOR EACH ROW    
DECLARE
   l_transaction VARCHAR2(10);
BEGIN
   -- determine the transaction type
   l_transaction := CASE  
         WHEN UPDATING THEN 'UPDATE'
         WHEN DELETING THEN 'DELETE'
   END;
 
   -- insert a row into the audit table   
   INSERT INTO audits (table_name, transaction_name, by_user, transaction_date)
   VALUES('CUSTOMERS', l_transaction, USER, SYSDATE);
END;
/
*/