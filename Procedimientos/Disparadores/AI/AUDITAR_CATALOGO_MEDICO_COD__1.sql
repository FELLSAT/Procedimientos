CREATE OR REPLACE TRIGGER AUDITAR_CATALOGO_MEDICO_COD__1 BEFORE INSERT ON AUDITAR_CATALOGO_MEDICO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT AUDITAR_CATALOGO_MEDICO_COD_CA.NEXTVAL
    INTO   :NEW.COD_CATAL_MED
    FROM   dual;
END;