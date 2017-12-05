CREATE OR REPLACE TRIGGER GRUPO_SERVICIO_NU_AUTO_GRSE_TR BEFORE INSERT ON GRUPO_SERVICIO
FOR EACH ROW
DECLARE 
  
BEGIN
    SELECT GRUPO_SERVICIO_NU_AUTO_GRSE_SE.NEXTVAL
    INTO   :NEW.NU_AUTO_GRSE
    FROM   dual;
END;