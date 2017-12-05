CREATE OR REPLACE TRIGGER CONFIGURACION_LDAP_AUTO_CONF_1 BEFORE INSERT ON CONFIGURACION_LDAP
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT CONFIGURACION_LDAP_AUTO_CONF_L.NEXTVAL
    INTO   :NEW.AUTO_CONF_LDAP
    FROM   dual;
END;