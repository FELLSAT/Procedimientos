CREATE OR REPLACE TRIGGER PERFIL_ACCESO_Pac_Id_TRG BEFORE INSERT ON PERFIL_ACCESO
FOR EACH ROW
DECLARE 
  
BEGIN
    SELECT PERFIL_ACCESO_Pac_Id_SEQ.NEXTVAL
    INTO   :NEW.Pac_Id
    FROM   dual;
END;