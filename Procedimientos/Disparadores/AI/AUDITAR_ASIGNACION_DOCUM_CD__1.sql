CREATE OR REPLACE TRIGGER AUDITAR_ASIGNACION_DOCUM_CD__1 BEFORE INSERT ON AUDITAR_ASIGNACION_DOCUM
FOR EACH ROW
DECLARE 
 
BEGIN
    SELECT AUDITAR_ASIGNACION_DOCUM_CD_AS.NEXTVAL
    INTO   :NEW.CD_ASIG_DOCU
    FROM   dual;
END;