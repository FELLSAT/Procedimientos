CREATE OR REPLACE TRIGGER TIPO_LIQ_ADMELI_NU_AUTO_ADME_T BEFORE INSERT ON TIPO_LIQ_ADMELI
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT TIPO_LIQ_ADMELI_NU_AUTO_ADME_S.NEXTVAL
    INTO   :NEW.NU_AUTO_ADME
    FROM   dual;
END;