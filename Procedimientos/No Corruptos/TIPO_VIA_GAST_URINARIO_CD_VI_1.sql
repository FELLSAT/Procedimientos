CREATE OR REPLACE TRIGGER HIMS.TIPO_VIA_GAST_URINARIO_CD_VI_1 BEFORE INSERT ON HIMS.TIPO_VIA_GAST_URINARIO FOR EACH ROW
DECLARE

BEGIN
    SELECT TIPO_VIA_GAST_URINARIO_CD_VIA_.NEXTVAL
    INTO :NEW.CD_VIA_LIQELI
    FROM DUAL;
END;