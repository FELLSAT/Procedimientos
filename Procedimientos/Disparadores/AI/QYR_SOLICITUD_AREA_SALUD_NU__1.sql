CREATE OR REPLACE TRIGGER QYR_SOLICITUD_AREA_SALUD_NU__1 BEFORE INSERT ON QYR_SOLICITUD_AREA_SALUD
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT QYR_SOLICITUD_AREA_SALUD_NU_NU.NEXTVAL
    INTO   :NEW.NU_NUME_SAS
    FROM   dual;
END;