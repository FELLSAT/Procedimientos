CREATE OR REPLACE TRIGGER DESTINOTRIAGE_CD_DEST_TRIA_TRG BEFORE INSERT ON DESTINOTRIAGE
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT DESTINOTRIAGE_CD_DEST_TRIA_SEQ.NEXTVAL
    INTO   :NEW.CD_DEST_TRIA
    FROM   dual;
END;