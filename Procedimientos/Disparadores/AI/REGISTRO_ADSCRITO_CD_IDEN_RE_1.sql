CREATE OR REPLACE TRIGGER REGISTRO_ADSCRITO_CD_IDEN_RE_1 BEFORE INSERT ON REGISTRO_ADSCRITO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT REGISTRO_ADSCRITO_CD_IDEN_READ.NEXTVAL
    INTO   :NEW.CD_IDEN_READ
    FROM   dual;
END;