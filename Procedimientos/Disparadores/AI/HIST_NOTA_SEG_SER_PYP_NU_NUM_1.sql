CREATE OR REPLACE TRIGGER HIST_NOTA_SEG_SER_PYP_NU_NUM_1 BEFORE INSERT ON HIST_NOTA_SEG_SER_PYP
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT HIST_NOTA_SEG_SER_PYP_NU_NUME_.NEXTVAL
    INTO   :NEW.NU_NUME_HNSSPYP
    FROM   dual;
END;