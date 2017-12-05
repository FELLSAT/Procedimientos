CREATE OR REPLACE TRIGGER HIMS.CONSULTAS_RIPS_NU_CONSE_CONS_T BEFORE INSERT ON HIMS.CONSULTAS_RIPS FOR EACH ROW
DECLARE

BEGIN
    SELECT CONSULTAS_RIPS_NU_CONSE_CONS_S.NEXTVAL
    INTO :NEW.NU_CONSE_CONS
    FROM DUAL;
END;
/