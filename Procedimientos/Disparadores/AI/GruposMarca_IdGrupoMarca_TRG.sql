CREATE OR REPLACE TRIGGER GruposMarca_IdGrupoMarca_TRG BEFORE INSERT ON GruposMarca
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT GruposMarca_IdGrupoMarca_SEQ.NEXTVAL
    INTO   :NEW.IdGrupoMarca
    FROM   dual;
END;