CREATE OR REPLACE TRIGGER FUSOAT_NU_AUTO_FUS_TRG BEFORE INSERT ON FUSOAT
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT FUSOAT_NU_AUTO_FUS_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_FUS
    FROM   dual;
END;