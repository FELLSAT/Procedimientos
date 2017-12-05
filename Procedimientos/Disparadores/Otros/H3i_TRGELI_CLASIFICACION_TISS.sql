CREATE OR REPLACE TRIGGER H3i_TRGELI_CLASIFICACION_TISS 
AFTER DELETE          
ON CLASIFICACION_TISS       
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
DECLARE          
    V_PrimaryKeyField VARCHAR2(1000);
    V_PrimaryKeyValue VARCHAR2(1000);
    V_ValueNU_AUTO_CLTI VARCHAR2(100); 
    V_ValueNU_ESTADO_CLTI VARCHAR2(100); 
    V_ValueTX_NOMB_CLTI VARCHAR2(100);
    V_NU_ESTA_PAAU PARAMETRIZACION_AUDITORIA.NU_ESTA_PAAU%TYPE;
    V_USER_NAME VARCHAR2(30);
    V_USER_ID NUMBER;
BEGIN
    ------------------------------------------------------
    SELECT COLS.COLUMN_NAME
    INTO V_PrimaryKeyField
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = 'CLASIFICACION_TISS'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
    ------------------------------------------------------
    IF (V_PrimaryKeyField IS NOT NULL) THEN
        BEGIN
            SELECT :OLD.NU_AUTO_CLTI 
            INTO V_PrimaryKeyValue
            FROM DUAL;
        END;
    END IF;
    ------------------------------------------------------    
    SELECT NU_ESTA_PAAU 
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA    
    WHERE DE_NOMTABLA_PAAU = 'CLASIFICACION_TISS'
        AND ROWNUM<=1;
    ------------------------------------------------------
    IF (V_NU_ESTA_PAAU > 0) THEN
        BEGIN 
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            SELECT :OLD.NU_AUTO_CLTI
            INTO V_ValueNU_AUTO_CLTI
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES ('D','CLASIFICACION_TISS',
                'NU_AUTO_CLTI', V_PrimaryKeyValue , 
                'NU_AUTO_CLTI', V_ValueNU_AUTO_CLTI,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_ESTADO_CLTI 
            INTO V_ValueNU_ESTADO_CLTI
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('D','CLASIFICACION_TISS',
                'NU_AUTO_CLTI', V_PrimaryKeyValue , 
                'NU_ESTADO_CLTI', V_ValueNU_ESTADO_CLTI,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.TX_NOMB_CLTI 
            INTO V_ValueTX_NOMB_CLTI
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('D','CLASIFICACION_TISS',
                'NU_AUTO_CLTI', V_PrimaryKeyValue , 
                'TX_NOMB_CLTI', V_ValueTX_NOMB_CLTI,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
        END; 
    END IF;
END;