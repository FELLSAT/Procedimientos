CREATE OR REPLACE TRIGGER HIMS.PERIODO_ACADEMICO_NU_AUTO_PE_1 BEFORE INSERT ON HIMS.PERIODO_ACADEMICO FOR EACH ROW
DECLARE

BEGIN
    SELECT PERIODO_ACADEMICO_NU_AUTO_PEAC.NEXTVAL
    INTO :NEW.NU_AUTO_PEAC
    FROM DUAL;
END;
/