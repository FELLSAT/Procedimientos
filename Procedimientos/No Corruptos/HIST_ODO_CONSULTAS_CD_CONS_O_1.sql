CREATE OR REPLACE TRIGGER HIMS.HIST_ODO_CONSULTAS_CD_CONS_O_1 BEFORE INSERT ON HIMS.HIST_ODO_CONSULTAS FOR EACH ROW
DECLARE

BEGIN
    SELECT HIST_ODO_CONSULTAS_CD_CONS_ODO.NEXTVAL
    INTO :NEW.CD_CONS_ODO
    FROM DUAL;
END;
/