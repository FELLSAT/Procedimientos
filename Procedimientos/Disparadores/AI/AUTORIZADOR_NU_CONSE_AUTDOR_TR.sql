CREATE OR REPLACE TRIGGER AUTORIZADOR_NU_CONSE_AUTDOR_TR BEFORE INSERT ON AUTORIZADOR
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT AUTORIZADOR_NU_CONSE_AUTDOR_SE.NEXTVAL
    INTO   :NEW.NU_CONSE_AUTDOR
    FROM   dual;
END;