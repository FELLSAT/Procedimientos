CREATE OR REPLACE TRIGGER CONFIGURA_CLAP_COD_CONF_CLAP_T BEFORE INSERT ON CONFIGURA_CLAP
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT CONFIGURA_CLAP_COD_CONF_CLAP_S.NEXTVAL
    INTO   :NEW.COD_CONF_CLAP
    FROM   dual;
END;