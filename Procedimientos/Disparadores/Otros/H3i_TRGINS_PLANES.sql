CREATE OR REPLACE TRIGGER H3i_TRGINS_PLANES     
AFTER INSERT    
ON PLANES  
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================  
DECLARE    
    V_PrimaryKeyField VARCHAR2(1000); 
    V_PrimaryKeyValue VARCHAR2(1000);
    V_CD_CODI_PLAN VARCHAR2(100);
    V_ValueCD_CODI_PLAN VARCHAR2(100);
    V_DE_DESC_PLAN VARCHAR2(100);
    V_ValueDE_DESC_PLAN VARCHAR2(100);
    V_NU_ESTA_PAAU PARAMETRIZACION_AUDITORIA.NU_ESTA_PAAU%TYPE;
    V_USER_NAME VARCHAR2(30);
    V_USER_ID NUMBER;
BEGIN
    ------------------------------------------------------
    SELECT COLS.COLUMN_NAME
    INTO V_PrimaryKeyField
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = 'PLANES'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
    ------------------------------------------------------ 
    IF (V_PrimaryKeyField IS NOT NULL) THEN
        SELECT :NEW.CD_CODI_PLAN
        INTO V_PrimaryKeyValue 
        FROM DUAL;
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU 
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA    
    WHERE DE_NOMTABLA_PAAU = 'PLANES'
      AND ROWNUM<=1;
    ------------------------------------------------------
    IF (V_NU_ESTA_PAAU > 0) THEN
        BEGIN
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            SELECT :NEW.CD_CODI_PLAN
            INTO V_ValueCD_CODI_PLAN
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('I','PLANES',
                'CD_CODI_PLAN', V_PrimaryKeyValue, 
                'CD_CODI_PLAN', '  ' , 
                V_ValueCD_CODI_PLAN, SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :NEW.DE_DESC_PLAN
            INTO V_ValueDE_DESC_PLAN
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('I','PLANES',
                'CD_CODI_PLAN', V_PrimaryKeyValue , 
                'DE_DESC_PLAN', '  ' , 
                V_ValueDE_DESC_PLAN, SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0);
        END;
    END IF;
END;