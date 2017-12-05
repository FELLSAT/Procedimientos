CREATE OR REPLACE TRIGGER HIMS.ESTADO_GLOSA3I_NU_AUTO_ESGLO_T BEFORE INSERT ON HIMS.ESTADO_GLOSA3I
FOR EACH ROW
DECLARE

BEGIN
    SELECT ESTADO_GLOSA3i_NU_AUTO_ESGLO_S.NEXTVAL
    INTO :NEW.NU_AUTO_ESGLO
    FROM DUAL;
END;
/