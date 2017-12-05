CREATE OR REPLACE TRIGGER RIPS_CONSE_TRG BEFORE INSERT ON RIPS
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT RIPS_CONSE_SEQ.NEXTVAL
    INTO   :NEW.CONSE
    FROM   dual;
END;