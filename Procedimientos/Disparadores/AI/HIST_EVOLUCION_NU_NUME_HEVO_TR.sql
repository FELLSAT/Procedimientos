CREATE OR REPLACE TRIGGER HIST_EVOLUCION_NU_NUME_HEVO_TR BEFORE INSERT ON HIST_EVOLUCION
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT HIST_EVOLUCION_NU_NUME_HEVO_SE.NEXTVAL
    INTO   :NEW.NU_NUME_HEVO
    FROM   dual;
END;