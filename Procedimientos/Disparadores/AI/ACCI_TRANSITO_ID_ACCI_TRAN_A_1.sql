CREATE OR REPLACE TRIGGER ACCI_TRANSITO_ID_ACCI_TRAN_A_1 BEFORE INSERT ON ACCI_TRANSITO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT ACCI_TRANSITO_ID_ACCI_TRAN_ACC.NEXTVAL
    INTO   :NEW.ID_ACCI_TRAN_ACCT
    FROM   dual;
END;