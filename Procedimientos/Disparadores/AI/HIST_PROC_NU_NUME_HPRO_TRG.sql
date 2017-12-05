CREATE OR REPLACE TRIGGER HIST_PROC_NU_NUME_HPRO_TRG BEFORE INSERT ON HIST_PROC
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT HIST_PROC_NU_NUME_HPRO_SEQ.NEXTVAL
    INTO   :NEW.NU_NUME_HPRO
    FROM   dual;
END;