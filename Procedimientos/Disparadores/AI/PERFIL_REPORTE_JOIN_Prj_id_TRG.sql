CREATE OR REPLACE TRIGGER PERFIL_REPORTE_JOIN_Prj_id_TRG BEFORE INSERT ON PERFIL_REPORTE_JOIN
FOR EACH ROW
DECLARE 
    
BEGIN
   SELECT PERFIL_REPORTE_JOIN_Prj_id_SEQ.NEXTVAL
    INTO   :NEW.Prj_id
    FROM   dual;
END;