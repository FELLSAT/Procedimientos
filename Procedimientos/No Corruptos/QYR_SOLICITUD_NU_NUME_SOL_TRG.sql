CREATE OR REPLACE TRIGGER HIMS.QYR_SOLICITUD_NU_NUME_SOL_TRG BEFORE INSERT ON HIMS.QYR_SOLICITUD FOR EACH ROW
DECLARE
BEGIN
    SELECT QYR_SOLICITUD_NU_NUME_SOL_SEQ.NEXTVAL
    INTO :NEW.NU_NUME_SOL
    FROM DUAL;
END;
/