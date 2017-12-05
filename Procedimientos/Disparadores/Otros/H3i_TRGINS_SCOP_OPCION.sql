CREATE OR REPLACE TRIGGER H3i_TRGINS_SCOP_OPCION   
AFTER INSERT    
ON SCOP_OPCION    
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
DECLARE    
    V_PrimaryKeyField VARCHAR2(1000);    
    V_PrimaryKeyValue VARCHAR2(1000);
    V_ESTADO VARCHAR2(100);
    V_ValueESTADO VARCHAR2(100);
    V_NU_NUME_SO VARCHAR2(100);
    V_ValueNU_NUME_SO VARCHAR2(100);
    V_NU_NUME_SV_SO VARCHAR2(100);
    V_ValueNU_NUME_SV_SO VARCHAR2(100);
    V_NU_PUNT_SO VARCHAR2(100);
    V_ValueNU_PUNT_SO VARCHAR2(100);
    V_TX_NOMB_SO VARCHAR2(100);
    V_ValueTX_NOMB_SO VARCHAR2(100);
    V_NU_ESTA_PAAU PARAMETRIZACION_AUDITORIA.NU_ESTA_PAAU%TYPE;
    V_USER_NAME VARCHAR2(30);
    V_USER_ID NUMBER;
BEGIN
    ------------------------------------------------------
    SELECT COLS.COLUMN_NAME
    INTO V_PrimaryKeyField
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = 'SCOP_OPCION'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
    ------------------------------------------------------
    IF (V_PrimaryKeyField IS NOT NULL) THEN
        BEGIN 
          SELECT :NEW.NU_NUME_SO
          INTO V_PrimaryKeyValue
          FROM DUAL;
        END; 
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU 
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA    
    WHERE DE_NOMTABLA_PAAU = 'SCOP_OPCION'
        AND ROWNUM<=1;
    ------------------------------------------------------
    IF (V_NU_ESTA_PAAU > 0) THEN
        BEGIN 
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            SELECT :NEW.ESTADO 
            INTO V_ValueESTADO
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('I','SCOP_OPCION',
                'NU_NUME_SO', V_PrimaryKeyValue , 
                'ESTADO', '  ' , 
                V_ValueESTADO, SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :NEW.NU_NUME_SO
            INTO V_ValueNU_NUME_SO
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('I','SCOP_OPCION',
                'NU_NUME_SO', V_PrimaryKeyValue , 
                'NU_NUME_SO', '  ' , 
                V_ValueNU_NUME_SO, SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :NEW.NU_NUME_SV_SO 
            INTO V_ValueNU_NUME_SV_SO
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )  
            VALUES ('I','SCOP_OPCION',
                'NU_NUME_SO', V_PrimaryKeyValue , 
                'NU_NUME_SV_SO', '  ' , 
                V_ValueNU_NUME_SV_SO, SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :NEW.NU_PUNT_SO
            INTO V_ValueNU_PUNT_SO
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('I','SCOP_OPCION',
                'NU_NUME_SO', V_PrimaryKeyValue , 
                'NU_PUNT_SO', '  ' , 
                V_ValueNU_PUNT_SO, SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :NEW.TX_NOMB_SO 
            INTO V_ValueTX_NOMB_SO
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('I','SCOP_OPCION',
                'NU_NUME_SO', V_PrimaryKeyValue , 
                'TX_NOMB_SO', '  ' , 
                V_ValueTX_NOMB_SO, SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
        END;
    END IF;
END;