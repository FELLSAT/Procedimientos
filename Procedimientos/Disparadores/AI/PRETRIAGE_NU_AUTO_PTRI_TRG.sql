CREATE OR REPLACE TRIGGER PRETRIAGE_NU_AUTO_PTRI_TRG BEFORE INSERT ON PRETRIAGE
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT PRETRIAGE_NU_AUTO_PTRI_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_PTRI
    FROM   dual;
END;