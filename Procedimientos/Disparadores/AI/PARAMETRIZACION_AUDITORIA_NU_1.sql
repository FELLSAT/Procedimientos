CREATE OR REPLACE TRIGGER PARAMETRIZACION_AUDITORIA_NU_1 BEFORE INSERT ON PARAMETRIZACION_AUDITORIA
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT PARAMETRIZACION_AUDITORIA_NU_N.NEXTVAL
    INTO   :NEW.NU_NUME_PAAU
    FROM   dual;
END;