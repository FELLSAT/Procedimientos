CREATE OR REPLACE TRIGGER PROGRAMA_DEPENDENCIA_ADSCRIT_1 BEFORE INSERT ON PROGRAMA_DEPENDENCIA_ADSCRITO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT PROGRAMA_DEPENDENCIA_ADSCRITO_.NEXTVAL
    INTO   :NEW.CD_CODI_PRO_DEP_ADS
    FROM   dual;
END;