CREATE OR REPLACE TRIGGER HIMS.PROGRAMA_SALUD_UNAL_NU_CODI__1 BEFORE INSERT ON HIMS.PROGRAMA_SALUD_UNAL FOR EACH ROW
DECLARE

BEGIN
    SELECT PROGRAMA_SALUD_UNAL_NU_CODI_PR.NEXTVAL
    INTO :NEW.NU_CODI_PRSA
    FROM DUAL;
END;
/