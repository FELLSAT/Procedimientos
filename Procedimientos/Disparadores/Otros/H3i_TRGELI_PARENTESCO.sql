CREATE OR REPLACE TRIGGER H3i_TRGELI_PARENTESCO 
AFTER DELETE          
ON PARENTESCO            
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================       
DECLARE        
    V_PrimaryKeyField VARCHAR2(1000);
    V_PrimaryKeyValue VARCHAR2(1000);
    V_ValueCD_CODI_PARE VARCHAR2(100); 
    V_ValueDE_DESC_ACOM VARCHAR2(100);
    V_ValueDE_DESC_PARE VARCHAR2(100);
    V_NU_ESTA_PAAU PARAMETRIZACION_AUDITORIA.NU_ESTA_PAAU%TYPE;
    V_USER_NAME VARCHAR2(30);
    V_USER_ID NUMBER;
BEGIN
    ------------------------------------------------------
    SELECT COLS.COLUMN_NAME
    INTO V_PrimaryKeyField
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = 'PARENTESCO'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
    ------------------------------------------------------
    IF(V_PrimaryKeyField IS NOT NULL) THEN 
        SELECT :OLD.CD_CODI_PARE
        INTO V_PrimaryKeyValue
        FROM DUAL;
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA    
    WHERE DE_NOMTABLA_PAAU = 'PARENTESCO'
        AND ROWNUM <= 1;
    ------------------------------------------------------
    IF(V_NU_ESTA_PAAU > 0) THEN
        BEGIN
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            SELECT :OLD.CD_CODI_PARE
            INTO V_ValueCD_CODI_PARE
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('D','PARENTESCO',
                'CD_CODI_PARE', V_PrimaryKeyValue , 
                'CD_CODI_PARE', V_ValueCD_CODI_PARE,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0 );
            ------------------------------------------------------
            SELECT :OLD.DE_DESC_ACOM 
            INTO V_ValueDE_DESC_ACOM
            FROM DUAL; 

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            Values ('D','PARENTESCO',
                'CD_CODI_PARE', V_PrimaryKeyValue , 
                'DE_DESC_ACOM', V_ValueDE_DESC_ACOM,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0 );
            ------------------------------------------------------
            SELECT :OLD.DE_DESC_PARE 
            INTO V_ValueDE_DESC_PARE
            FROM DUAL; 

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES ('D','PARENTESCO',
                'CD_CODI_PARE', V_PrimaryKeyValue , 
                'DE_DESC_PARE', V_ValueDE_DESC_PARE,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0 );
        END;
    END IF;
END;

