CREATE OR REPLACE TRIGGER ESCALA_DETALLE_NU_AUTO_ESDE_TR BEFORE INSERT ON ESCALA_DETALLE
FOR EACH ROW
DECLARE 
    
BEGIN
     SELECT ESCALA_DETALLE_NU_AUTO_ESDE_SE.NEXTVAL
    INTO   :NEW.NU_AUTO_ESDE
    FROM   dual;
END;