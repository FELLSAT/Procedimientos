CREATE OR REPLACE TRIGGER AUDITAR_DOCU_SINCRO_SIN_FTP__1 BEFORE INSERT ON AUDITAR_DOCU_SINCRO_SIN_FTP
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT AUDITAR_DOCU_SINCRO_SIN_FTP_CO.NEXTVAL
    INTO   :NEW.COD_AUDI_DOC_SIN_FTP
    FROM   dual;
END;