CREATE OR REPLACE TRIGGER HIMS.PRUEBA_PERCUSION_ODO_NU_AUTO_1 BEFORE INSERT ON HIMS.PRUEBA_PERCUSION_ODO FOR EACH ROW
DECLARE

BEGIN
    SELECT PRUEBA_PERCUSION_ODO_NU_AUTO_P.NEXTVAL
    INTO :NEW.NU_AUTO_PRPE
    FROM DUAL;
END;