CREATE OR REPLACE TRIGGER ENCABEZADO_PLANTILLAHC_NU_AU_1 BEFORE INSERT ON ENCABEZADO_PLANTILLAHC
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT ENCABEZADO_PLANTILLAHC_NU_AUTO.NEXTVAL
    INTO   :NEW.NU_AUTO_ENPL
    FROM   dual;
END;