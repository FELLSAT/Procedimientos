CREATE OR REPLACE TRIGGER H3i_TRGELI_SERVICIOS 
AFTER DELETE          
ON SERVICIOS            
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================  
DECLARE          
    V_PrimaryKeyField VARCHAR2(1000);
    V_PrimaryKeyValue VARCHAR2(1000);
    V_ValueCD_CODI_COSE_SER VARCHAR2(100) ;
    V_ValueCD_CODI_CUEN_SER VARCHAR2(100) ;
    V_ValueCD_CODI_SER VARCHAR2(100) ;
    V_ValueCD_CODI_TISE_SER VARCHAR2(100) ;
    V_ValueDE_OBSE_SER VARCHAR2(100) ;
    V_ValueDX_PREDET VARCHAR2(100) ;
    V_ValueES_SERV_WEB_SER VARCHAR2(100);
    V_ValueESTADO VARCHAR2(100); 
    V_ValueFINALIDAD VARCHAR2(100); 
    V_ValueID_CITA_SER VARCHAR2(100); 
    V_ValueID_GCIT_SER VARCHAR2(100);
    V_ValueIS_SERV_ODONT VARCHAR2(100); 
    V_ValueMEDIDA_TIEMPO VARCHAR2(100); 
    V_ValueNO_NOMB_SER VARCHAR2(100); 
    V_ValueNU_APLI_SER VARCHAR2(100); 
    V_ValueNU_AUTRIPS_SER VARCHAR2(100); 
    V_ValueNU_CLAS_SER VARCHAR2(100); 
    V_ValueNU_EDFI_SER VARCHAR2(100); 
    V_ValueNU_EDIN_SER VARCHAR2(100); 
    V_ValueNU_ESGRUPAL_SER VARCHAR2(100); 
    V_ValueNU_ESTA_SER VARCHAR2(100); 
    V_ValueNU_EVOL_SER VARCHAR2(100); 
    V_ValueNU_HOME_SER VARCHAR2(100); 
    V_ValueNU_MAXPACGRU_SER VARCHAR2(100);
    V_ValueNU_MICO_SER VARCHAR2(100); 
    V_ValueNU_NIVE_SER VARCHAR2(100);
    V_ValueNU_NO_ES_VIS_MIHIMS VARCHAR2(100); 
    V_ValueNU_NOFACT_SER VARCHAR2(100);
    V_ValueNU_NOPOS_SER VARCHAR2(100);
    V_ValueNU_NORIPS_SER VARCHAR2(100); 
    V_ValueNU_NUME_IND_SER VARCHAR2(100);
    V_ValueNU_OPCI_SER VARCHAR2(100);
    V_ValueNU_REQAUT_SER VARCHAR2(100);
    V_ValueNU_TITA_SER VARCHAR2(100);
    V_ValueNU_VACU_SER VARCHAR2(100);
    V_ValueSIN_COPAGO VARCHAR2(100);
    V_NU_ESTA_PAAU PARAMETRIZACION_AUDITORIA.NU_ESTA_PAAU%TYPE;
    V_USER_NAME VARCHAR2(30);
    V_USER_ID NUMBER;
BEGIN
    ------------------------------------------------------
    SELECT COLS.COLUMN_NAME
    INTO V_PrimaryKeyField
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = 'SERVICIOS'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
    ------------------------------------------------------
    IF (V_PrimaryKeyField IS NOT NULL) THEN
        BEGIN
            SELECT :OLD.CD_CODI_SER 
            INTO V_PrimaryKeyValue
            FROM DUAL;          
        END;
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU 
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA    
    WHERE DE_NOMTABLA_PAAU = 'SERVICIOS'
        AND ROWNUM<=1;
    ------------------------------------------------------
    IF(V_NU_ESTA_PAAU > 0) THEN
        BEGIN
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            SELECT :OLD.CD_CODI_COSE_SER 
            INTO V_ValueCD_CODI_COSE_SER
            FROM DUAL; 

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'CD_CODI_COSE_SER', V_ValueCD_CODI_COSE_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.CD_CODI_CUEN_SER 
            INTO V_ValueCD_CODI_CUEN_SER
            FROM DUAL; 

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'CD_CODI_CUEN_SER', V_ValueCD_CODI_CUEN_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.CD_CODI_SER 
            INTO V_ValueCD_CODI_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue, 
                'CD_CODI_SER', V_ValueCD_CODI_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0 );
            ------------------------------------------------------
            SELECT :OLD.CD_CODI_TISE_SER 
            INTO V_ValueCD_CODI_TISE_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'CD_CODI_TISE_SER', V_ValueCD_CODI_TISE_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0 );
            ------------------------------------------------------
            SELECT :OLD.DE_OBSE_SER 
            INTO V_ValueDE_OBSE_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'DE_OBSE_SER', V_ValueDE_OBSE_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.DX_PREDET 
            INTO V_ValueDX_PREDET
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'DX_PREDET', V_ValueDX_PREDET,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0 );
            ------------------------------------------------------
            SELECT :OLD.ES_SERV_WEB_SER 
            INTO V_ValueES_SERV_WEB_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'ES_SERV_WEB_SER', V_ValueES_SERV_WEB_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0 );
            ------------------------------------------------------
            SELECT :OLD.ESTADO 
            INTO V_ValueESTADO
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue, 
                'ESTADO', V_ValueESTADO,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0 );
            ------------------------------------------------------
            SELECT :OLD.FINALIDAD 
            INTO V_ValueFINALIDAD
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            Values ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'FINALIDAD', V_ValueFINALIDAD,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0 );
            ------------------------------------------------------
            SELECT :OLD.ID_CITA_SER
            INTO V_ValueID_CITA_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'ID_CITA_SER', V_ValueID_CITA_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0 );
            ------------------------------------------------------
            SELECT :OLD.ID_GCIT_SER 
            INTO V_ValueID_GCIT_SER
            FROM DUAL;
            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'ID_GCIT_SER', V_ValueID_GCIT_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0 );
            ------------------------------------------------------
            SELECT :OLD.IS_SERV_ODONT 
            INTO V_ValueIS_SERV_ODONT
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'IS_SERV_ODONT', V_ValueIS_SERV_ODONT,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.MEDIDA_TIEMPO 
            INTO V_ValueMEDIDA_TIEMPO
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'MEDIDA_TIEMPO', V_ValueMEDIDA_TIEMPO,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0);
            ------------------------------------------------------
            SELECT :OLD.NO_NOMB_SER 
            INTO V_ValueNO_NOMB_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NO_NOMB_SER', V_ValueNO_NOMB_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_APLI_SER 
            INTO V_ValueNU_APLI_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_APLI_SER', V_ValueNU_APLI_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_AUTRIPS_SER 
            INTO V_ValueNU_AUTRIPS_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_AUTRIPS_SER', V_ValueNU_AUTRIPS_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_CLAS_SER 
            INTO V_ValueNU_CLAS_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_CLAS_SER', V_ValueNU_CLAS_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_EDFI_SER 
            INTO V_ValueNU_EDFI_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS','
                CD_CODI_SER', V_PrimaryKeyValue, 
                'NU_EDFI_SER', V_ValueNU_EDFI_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_EDIN_SER 
            INTO V_ValueNU_EDIN_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_EDIN_SER', V_ValueNU_EDIN_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_ESGRUPAL_SER 
            INTO V_ValueNU_ESGRUPAL_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_ESGRUPAL_SER', V_ValueNU_ESGRUPAL_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_ESTA_SER 
            INTO V_ValueNU_ESTA_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_ESTA_SER', V_ValueNU_ESTA_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_EVOL_SER
            INTO V_ValueNU_EVOL_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES ('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_EVOL_SER', V_ValueNU_EVOL_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_HOME_SER
            INTO V_ValueNU_HOME_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_HOME_SER', V_ValueNU_HOME_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_MAXPACGRU_SER
            INTO V_ValueNU_MAXPACGRU_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_MAXPACGRU_SER', V_ValueNU_MAXPACGRU_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_MICO_SER 
            INTO V_ValueNU_MICO_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS', 
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_MICO_SER', V_ValueNU_MICO_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_NIVE_SER
            INTO V_ValueNU_NIVE_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_NIVE_SER', V_ValueNU_NIVE_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_NO_ES_VIS_MIHIMS
            INTO V_ValueNU_NO_ES_VIS_MIHIMS
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_NO_ES_VIS_MIHIMS', V_ValueNU_NO_ES_VIS_MIHIMS,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_NOFACT_SER
            INTO V_ValueNU_NOFACT_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_NOFACT_SER', V_ValueNU_NOFACT_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_NOPOS_SER
            INTO V_ValueNU_NOPOS_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_NOPOS_SER', V_ValueNU_NOPOS_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_NORIPS_SER 
            INTO V_ValueNU_NORIPS_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_NORIPS_SER', V_ValueNU_NORIPS_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_NUME_IND_SER 
            INTO V_ValueNU_NUME_IND_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_NUME_IND_SER', V_ValueNU_NUME_IND_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_OPCI_SER 
            INTO V_ValueNU_OPCI_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
              'CD_CODI_SER', V_PrimaryKeyValue , 
              'NU_OPCI_SER', V_ValueNU_OPCI_SER,  
              '  ' , SYSDATE, 
              V_USER_NAME, V_USER_ID,
              0);
            ------------------------------------------------------
            SELECT :OLD.NU_REQAUT_SER 
            INTO V_ValueNU_REQAUT_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_REQAUT_SER', V_ValueNU_REQAUT_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_TITA_SER 
            INTO V_ValueNU_TITA_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_TITA_SER', V_ValueNU_TITA_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0);
            ------------------------------------------------------
            SELECT :OLD.NU_VACU_SER 
            INTO V_ValueNU_VACU_SER
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'NU_VACU_SER', V_ValueNU_VACU_SER,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0);
            ------------------------------------------------------
            SELECT :OLD.SIN_COPAGO 
            INTO V_ValueSIN_COPAGO
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('D','SERVICIOS',
                'CD_CODI_SER', V_PrimaryKeyValue , 
                'SIN_COPAGO', V_ValueSIN_COPAGO,  
                '  ' , SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
        END;
    END IF; 
END;