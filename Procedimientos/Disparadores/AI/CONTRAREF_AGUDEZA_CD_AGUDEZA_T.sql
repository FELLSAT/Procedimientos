CREATE OR REPLACE TRIGGER CONTRAREF_AGUDEZA_CD_AGUDEZA_T BEFORE INSERT ON CONTRAREF_AGUDEZA
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT CONTRAREF_AGUDEZA_CD_AGUDEZA_S.NEXTVAL
    INTO   :NEW.CD_AGUDEZA
    FROM   dual;
END;