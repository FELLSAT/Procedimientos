CREATE OR REPLACE TRIGGER APLICACION_QUIM_NU_NUME_AQ_TRG BEFORE INSERT ON APLICACION_QUIM
FOR EACH ROW
DECLARE 
  
BEGIN
    SELECT APLICACION_QUIM_NU_NUME_AQ_SEQ.NEXTVAL
    INTO   :NEW.NU_NUME_AQ
    FROM   dual;
END;