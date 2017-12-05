CREATE OR REPLACE TRIGGER PLANTILLA_HIST_NU_NUME_PLHI_TR BEFORE INSERT ON PLANTILLA_HIST
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT PLANTILLA_HIST_NU_NUME_PLHI_SE.NEXTVAL
    INTO   :NEW.NU_NUME_PLHI
    FROM   dual;
END;