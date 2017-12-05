CREATE OR REPLACE TRIGGER lista_opcion_id_auto_opcio_TRG BEFORE INSERT ON lista_opcion
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT lista_opcion_id_auto_opcio_SEQ.NEXTVAL
    INTO   :NEW.id_auto_opcio
    FROM   dual;
END;