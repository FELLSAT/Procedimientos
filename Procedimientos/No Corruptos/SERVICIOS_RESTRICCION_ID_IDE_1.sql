CREATE OR REPLACE TRIGGER HIMS.SERVICIOS_RESTRICCION_ID_IDE_1 BEFORE INSERT ON HIMS.SERVICIOS_RESTRICCION FOR EACH ROW
DECLARE

BEGIN
    SELECT SERVICIOS_RESTRICCION_ID_IDEN_.NEXTVAL
    INTO :NEW.ID_IDEN_SR
    FROM DUAL;
END;