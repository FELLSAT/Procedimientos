CREATE OR REPLACE TRIGGER SUBPROGRAMAS_SALUD_UNAL_NU_C_1 BEFORE INSERT ON SUBPROGRAMAS_SALUD_UNAL
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT SUBPROGRAMAS_SALUD_UNAL_NU_COD.NEXTVAL
    INTO   :NEW.NU_CODI_SUBP
    FROM   dual;
END;