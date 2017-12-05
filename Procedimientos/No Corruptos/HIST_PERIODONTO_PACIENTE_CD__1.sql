CREATE OR REPLACE TRIGGER HIMS.HIST_PERIODONTO_PACIENTE_CD__1 BEFORE INSERT ON HIMS.HIST_PERIODONTO_PACIENTE FOR EACH ROW
DECLARE

BEGIN
    SELECT HIST_PERIODONTO_PACIENTE_CD_PA.NEXTVAL
    INTO :NEW.CD_PAC_PERIODONTO
    FROM DUAL;
END;
/