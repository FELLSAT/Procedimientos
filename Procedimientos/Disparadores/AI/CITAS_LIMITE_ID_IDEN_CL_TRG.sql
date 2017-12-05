CREATE OR REPLACE TRIGGER CITAS_LIMITE_ID_IDEN_CL_TRG BEFORE INSERT ON CITAS_LIMITE
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT CITAS_LIMITE_ID_IDEN_CL_SEQ.NEXTVAL
    INTO   :NEW.ID_IDEN_CL
    FROM   dual;
END;