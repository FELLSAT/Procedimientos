CREATE OR REPLACE TRIGGER HIST_EXTEND_CD_CODI_HIEX_TRG BEFORE INSERT ON HIST_EXTEND
FOR EACH ROW
DECLARE 
    
BEGIN
     SELECT HIST_EXTEND_CD_CODI_HIEX_SEQ.NEXTVAL
    INTO   :NEW.CD_CODI_HIEX
    FROM   dual;
END;