CREATE OR REPLACE TRIGGER EVENTO_PERSONAL_APOYO_CD_EVT_1 BEFORE INSERT ON EVENTO_PERSONAL_APOYO
FOR EACH ROW
DECLARE 
      
BEGIN
    SELECT EVENTO_PERSONAL_APOYO_CD_EVT_P.NEXTVAL
    INTO   :NEW.CD_EVT_PERSONAL_APOYO
    FROM   dual;
END;