CREATE OR REPLACE TRIGGER TIPO_USUARIO_ADM_NU_AUTO_TUA_T BEFORE INSERT ON TIPO_USUARIO_ADM
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT TIPO_USUARIO_ADM_NU_AUTO_TUA_S.NEXTVAL
    INTO   :NEW.NU_AUTO_TUA
    FROM   dual;
END;