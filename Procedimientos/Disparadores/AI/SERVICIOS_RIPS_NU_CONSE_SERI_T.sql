CREATE OR REPLACE TRIGGER SERVICIOS_RIPS_NU_CONSE_SERI_T BEFORE INSERT ON SERVICIOS_RIPS
FOR EACH ROW
DECLARE   
    
BEGIN
    SELECT SERVICIOS_RIPS_NU_CONSE_SERI_S.NEXTVAL
    INTO   :NEW.NU_CONSE_SERI
    FROM   dual;
END;