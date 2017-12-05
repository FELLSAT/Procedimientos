CREATE OR REPLACE TRIGGER SICLAP_GESTACION_ACTUAL_GES__1 BEFORE INSERT ON SICLAP_GESTACION_ACTUAL
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT SICLAP_GESTACION_ACTUAL_ges_nc.NEXTVAL
    INTO   :NEW.ges_nconsecutivo
    FROM   dual;
END;