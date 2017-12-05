CREATE OR REPLACE TRIGGER TBL_ERROR_ID_TRG BEFORE INSERT ON TBL_ERROR
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT TBL_ERROR_ID_SEQ.NEXTVAL
    INTO   :NEW.ID
    FROM   dual;
END;