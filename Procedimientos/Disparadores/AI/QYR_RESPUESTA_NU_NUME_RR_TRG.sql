CREATE OR REPLACE TRIGGER QYR_RESPUESTA_NU_NUME_RR_TRG BEFORE INSERT ON QYR_RESPUESTA
FOR EACH ROW
DECLARE 
  
BEGIN
    SELECT QYR_RESPUESTA_NU_NUME_RR_SEQ.NEXTVAL
    INTO   :NEW.NU_NUME_RR
    FROM   dual;
END;