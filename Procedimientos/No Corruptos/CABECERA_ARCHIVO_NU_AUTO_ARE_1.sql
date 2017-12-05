CREATE OR REPLACE TRIGGER HIMS.CABECERA_ARCHIVO_NU_AUTO_ARE_1 BEFORE INSERT ON HIMS.CABECERA_ARCHIVO
FOR EACH ROW
DECLARE

BEGIN
  SELECT CABECERA_ARCHIVO_NU_AUTO_AREN_.NEXTVAL
  INTO :NEW.NU_AUTO_AREN
  FROM DUAL;
END;
/