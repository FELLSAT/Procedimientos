CREATE OR REPLACE TRIGGER AUTORIZACION_ADSCRITOS_NU_AU_1 BEFORE INSERT ON AUTORIZACION_ADSCRITOS
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT AUTORIZACION_ADSCRITOS_NU_AUTO.NEXTVAL
    INTO   :NEW.NU_AUTO_AUAD
    FROM   dual;
END;