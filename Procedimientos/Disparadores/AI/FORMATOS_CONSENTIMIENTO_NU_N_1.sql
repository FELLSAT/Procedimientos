CREATE OR REPLACE TRIGGER FORMATOS_CONSENTIMIENTO_NU_N_1 BEFORE INSERT ON FORMATOS_CONSENTIMIENTO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT FORMATOS_CONSENTIMIENTO_NU_NUM.NEXTVAL
    INTO   :NEW.NU_NUME_FOCO
    FROM   dual;
END;