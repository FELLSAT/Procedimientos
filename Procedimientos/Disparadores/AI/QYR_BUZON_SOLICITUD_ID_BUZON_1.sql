CREATE OR REPLACE TRIGGER QYR_BUZON_SOLICITUD_ID_BUZON_1 BEFORE INSERT ON QYR_BUZON_SOLICITUD
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT QYR_BUZON_SOLICITUD_ID_BUZON_S.NEXTVAL
    INTO   :NEW.ID_BUZON_SOLICITUDES
    FROM   dual;
END;