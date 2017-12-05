CREATE OR REPLACE TRIGGER USUARIO_PLANO_NU_AUTO_USUA_TRG BEFORE INSERT ON USUARIO_PLANO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT USUARIO_PLANO_NU_AUTO_USUA_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_USUA
    FROM   dual;
END;