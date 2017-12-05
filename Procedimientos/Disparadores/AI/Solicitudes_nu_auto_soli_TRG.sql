CREATE OR REPLACE TRIGGER Solicitudes_nu_auto_soli_TRG BEFORE INSERT ON Solicitudes
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT Solicitudes_nu_auto_soli_SEQ.NEXTVAL
    INTO   :NEW.nu_auto_soli
    FROM   dual;
END;