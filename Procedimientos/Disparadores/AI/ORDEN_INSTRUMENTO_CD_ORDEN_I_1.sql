CREATE OR REPLACE TRIGGER ORDEN_INSTRUMENTO_CD_ORDEN_I_1 BEFORE INSERT ON ORDEN_INSTRUMENTO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT ORDEN_INSTRUMENTO_CD_ORDEN_INS.NEXTVAL
    INTO   :NEW.CD_ORDEN_INSTRUM
    FROM   dual;
END;