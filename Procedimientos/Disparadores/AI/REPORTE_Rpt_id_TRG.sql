CREATE OR REPLACE TRIGGER REPORTE_Rpt_id_TRG BEFORE INSERT ON REPORTE
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT REPORTE_Rpt_id_SEQ.NEXTVAL
    INTO   :NEW.Rpt_id
    FROM   dual;
END;