CREATE OR REPLACE TRIGGER HIMS.HIST_GENO_UBICA_PUNTOS_NU_UB_1 BEFORE INSERT ON HIMS.HIST_GENO_UBICA_PUNTOS FOR EACH ROW
DECLARE

BEGIN
    SELECT HIST_GENO_UBICA_PUNTOS_NU_UBIC.NEXTVAL
    INTO :NEW.NU_UBICA_PUNTO
    FROM DUAL;
END;
/