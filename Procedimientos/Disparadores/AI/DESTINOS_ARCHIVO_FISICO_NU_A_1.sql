CREATE OR REPLACE TRIGGER DESTINOS_ARCHIVO_FISICO_NU_A_1 BEFORE INSERT ON DESTINOS_ARCHIVO_FISICO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT DESTINOS_ARCHIVO_FISICO_NU_AUT.NEXTVAL
    INTO   :NEW.NU_AUTO_DEAR
    FROM   dual;
END;