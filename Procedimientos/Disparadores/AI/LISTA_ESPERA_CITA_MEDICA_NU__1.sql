CREATE OR REPLACE TRIGGER LISTA_ESPERA_CITA_MEDICA_NU__1 BEFORE INSERT ON LISTA_ESPERA_CITA_MEDICA
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT LISTA_ESPERA_CITA_MEDICA_NU_AU.NEXTVAL
    INTO   :NEW.NU_AUTO_LECM
    FROM   dual;
END;