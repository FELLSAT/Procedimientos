CREATE OR REPLACE TRIGGER VARIABLE_INDICADOR_NU_AUTO_V_1 BEFORE INSERT ON VARIABLE_INDICADOR
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT VARIABLE_INDICADOR_NU_AUTO_VAI.NEXTVAL
    INTO   :NEW.NU_AUTO_VAIN
    FROM   dual;
END;