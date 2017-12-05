CREATE OR REPLACE TRIGGER HIMS.R_LUAT_FAC_NU_AUTO_LUATFAC_TRG BEFORE INSERT ON HIMS.R_LUAT_FAC FOR EACH ROW
DECLARE
v_newVal NUMBER(12) := 0;
v_incval NUMBER(12) := 0;
BEGIN
    SELECT R_LUAT_FAC_NU_AUTO_LUATFAC_SEQ.NEXTVAL
    INTO :NEW.NU_AUTO_LUATFAC
    FROM DUAL;
END;