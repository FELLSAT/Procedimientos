CREATE OR REPLACE TRIGGER HIMS.R_PLAN_CON_INCAPACIDAD_CD_CO_1 BEFORE INSERT ON HIMS.R_PLAN_CON_INCAPACIDAD FOR EACH ROW
DECLARE

BEGIN
    SELECT R_PLAN_CON_INCAPACIDAD_CD_CODI.NEXTVAL
    INTO :NEW.CD_CODI_RPI
    FROM DUAL;
END;