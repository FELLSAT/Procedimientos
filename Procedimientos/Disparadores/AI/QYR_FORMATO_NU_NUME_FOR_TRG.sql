CREATE OR REPLACE TRIGGER QYR_FORMATO_NU_NUME_FOR_TRG BEFORE INSERT ON QYR_FORMATO
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT QYR_FORMATO_NU_NUME_FOR_SEQ.NEXTVAL
    INTO   :NEW.NU_NUME_FOR
    FROM   dual;
END;