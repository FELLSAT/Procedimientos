CREATE OR REPLACE TRIGGER SCOP_PUNTAJE_NU_NUME_SP_TRG BEFORE INSERT ON SCOP_PUNTAJE
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT SCOP_PUNTAJE_NU_NUME_SP_SEQ.NEXTVAL
    INTO   :NEW.NU_NUME_SP
    FROM   dual;
END;