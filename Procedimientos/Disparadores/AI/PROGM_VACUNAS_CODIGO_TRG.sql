CREATE OR REPLACE TRIGGER PROGM_VACUNAS_CODIGO_TRG BEFORE INSERT ON PROGM_VACUNAS
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT PROGM_VACUNAS_CODIGO_SEQ.NEXTVAL
    INTO   :NEW.CODIGO
    FROM   dual;
END;