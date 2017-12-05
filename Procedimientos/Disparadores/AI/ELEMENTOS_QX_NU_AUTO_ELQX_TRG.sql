CREATE OR REPLACE TRIGGER ELEMENTOS_QX_NU_AUTO_ELQX_TRG BEFORE INSERT ON ELEMENTOS_QX
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT ELEMENTOS_QX_NU_AUTO_ELQX_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_ELQX
    FROM   dual;
END;