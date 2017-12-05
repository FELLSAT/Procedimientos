CREATE OR REPLACE TRIGGER H3i_TRGELI_CONVENIO_ADSC    
AFTER DELETE
ON CONVENIO_ADSC                   
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
DECLARE                   
    V_PrimaryKeyField VARCHAR2(1000);
    V_PrimaryKeyValue VARCHAR2(1000);
    V_ValueVL_VAL_ALERT VARCHAR2(100);
    V_NU_ESTA_PAAU PARAMETRIZACION_AUDITORIA.NU_ESTA_PAAU%TYPE;
    V_USER_NAME VARCHAR2(30);
    V_USER_ID NUMBER;
BEGIN
    ------------------------------------------------------
    SELECT COLS.COLUMN_NAME
    INTO V_PrimaryKeyField
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = 'CONVENIO_ADSC'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
    ------------------------------------------------------
    IF (V_PrimaryKeyField IS NOT NULL) THEN          
        BEGIN          
            SELECT :OLD.NU_NUME_COAD 
            INTO V_PrimaryKeyValue
            FROM DUAL;     
        END; 
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU 
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA    
    WHERE DE_NOMTABLA_PAAU = 'CONVENIO_ADSC'
        AND ROWNUM<=1;
    ------------------------------------------------------

    IF (V_NU_ESTA_PAAU > 0) THEN   
        BEGIN 
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            SELECT :OLD.VL_VAL_ALERT 
            INTO V_ValueVL_VAL_ALERT
            FROM DUAL; 

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('D','CONVENIO_ADSC',
                'NU_NUME_COAD', V_PrimaryKeyValue , 
                'VL_VAL_ALERT', V_ValueVL_VAL_ALERT,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0);
        END; 
    END IF;
END;