CREATE OR REPLACE TRIGGER H3i_TRGELI_CONVOCATORIAS_HIST            
AFTER DELETE  
ON CONVOCATORIAS_HIST        
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================    
DECLARE
	V_PrimaryKeyField VARCHAR2(1000);
	V_PrimaryKeyValue VARCHAR2(1000);
	V_ValueCD_COD_PROFREG_CONVHC VARCHAR2(100) ;
	V_ValueCD_COD_USR_CONVHC VARCHAR2(100) ;
	V_ValueCD_COD_USRREG_CONVHC VARCHAR2(100) ;
	V_ValueCD_CONVOC_HC VARCHAR2(100) ;
	V_ValueES_CONT_EMAIL_CONVHC VARCHAR2(100) ;
	V_ValueES_CONT_TELEF_CONVHC VARCHAR2(100) ;
	V_ValueFE_FECHA_CITA_CONVHC VARCHAR2(100) ;
	V_ValueFE_FECHA_CONT_CONVHC VARCHAR2(100) ;
	V_ValueNO_NOM_PROFREG_CONVHC VARCHAR2(100) ;
	V_ValueNO_NOM_USR_CONVHC VARCHAR2(100) ;
	V_ValueNO_NOM_USRREG_CONVHC VARCHAR2(100) ;
	V_ValueNU_DOC_SESS_CONVHC VARCHAR2(100) ;
	V_ValueNU_HIST_USR_CONVHC VARCHAR2(100) ;
	V_ValueNU_NUM_SESS_CONVHC VARCHAR2(100) ;
	V_ValueTX_OBSERV_CONVHC VARCHAR2(100);
	V_ValueTXT_EMAIL VARCHAR2(100) ;
	V_ValueTXT_PHONE VARCHAR2(100)  ;
	V_NU_ESTA_PAAU PARAMETRIZACION_AUDITORIA.NU_ESTA_PAAU%TYPE;
	V_USER_NAME VARCHAR2(30);
	V_USER_ID NUMBER;
BEGIN          
	------------------------------------------------------
	SELECT COLS.COLUMN_NAME
    INTO V_PrimaryKeyField
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = 'CONVOCATORIAS_HIST'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
	------------------------------------------------------
	IF(V_PrimaryKeyField IS NOT NULL) THEN
		BEGIN
			SELECT :OLD.CD_CONVOC_HC
			INTO V_PrimaryKeyValue
			FROM DUAL;
		END;
	END IF;
	------------------------------------------------------
	SELECT NU_ESTA_PAAU 
	INTO V_NU_ESTA_PAAU
	FROM PARAMETRIZACION_AUDITORIA    
	WHERE DE_NOMTABLA_PAAU = 'CONVOCATORIAS_HIST'
		AND ROWNUM<=1;
	------------------------------------------------------
	IF(V_NU_ESTA_PAAU > 0) THEN
		BEGIN
			SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
			SELECT :OLD.CD_COD_PROFREG_CONVHC
			INTO V_ValueCD_COD_PROFREG_CONVHC
			FROM DUAL; 

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			VALUES ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'CD_COD_PROFREG_CONVHC', V_ValueCD_COD_PROFREG_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID, 
				0);
			------------------------------------------------------
			SELECT :OLD.CD_COD_USR_CONVHC 
			INTO V_ValueCD_COD_USR_CONVHC
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			Values ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'CD_COD_USR_CONVHC', V_ValueCD_COD_USR_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID,  
				0);
			------------------------------------------------------
			SELECT :OLD.CD_COD_USRREG_CONVHC 
			INTO V_ValueCD_COD_USRREG_CONVHC
			From DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			Values ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'CD_COD_USRREG_CONVHC', V_ValueCD_COD_USRREG_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID,  
				0);
			------------------------------------------------------
			SELECT :OLD.CD_CONVOC_HC 
			INTO V_ValueCD_CONVOC_HC
			FROM DUAL; 

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			VALUES ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'CD_CONVOC_HC', V_ValueCD_CONVOC_HC,  
				'  ' , SYSDATE,
				V_USER_NAME, V_USER_ID, 
				0);
			------------------------------------------------------			
			SELECT :OLD.ES_CONT_EMAIL_CONVHC 
			INTO V_ValueES_CONT_EMAIL_CONVHC
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			VALUES ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'ES_CONT_EMAIL_CONVHC', V_ValueES_CONT_EMAIL_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID,
				0 );
			------------------------------------------------------			
			Select :OLD.ES_CONT_TELEF_CONVHC 
			INTO V_ValueES_CONT_TELEF_CONVHC
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			VALUES ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'ES_CONT_TELEF_CONVHC', V_ValueES_CONT_TELEF_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID, 
				0);
			------------------------------------------------------			
			SELECT :OLD.FE_FECHA_CITA_CONVHC 
			INTO V_ValueFE_FECHA_CITA_CONVHC
			FROM DUAL; 

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			Values ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'FE_FECHA_CITA_CONVHC', V_ValueFE_FECHA_CITA_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID, 
				0);
			------------------------------------------------------			
			Select :OLD.FE_FECHA_CONT_CONVHC 
			INTO V_ValueFE_FECHA_CONT_CONVHC
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			Values ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'FE_FECHA_CONT_CONVHC', V_ValueFE_FECHA_CONT_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID, 
				0); 			
			------------------------------------------------------			
			SELECT :OLD.NO_NOM_PROFREG_CONVHC 
			INTO V_ValueNO_NOM_PROFREG_CONVHC
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			VALUES ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'NO_NOM_PROFREG_CONVHC', V_ValueNO_NOM_PROFREG_CONVHC, 
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID, 
				0 );
			------------------------------------------------------			
			SELECT :OLD.NO_NOM_USR_CONVHC 
			INTO V_ValueNO_NOM_USR_CONVHC
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			VALUES ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'NO_NOM_USR_CONVHC', V_ValueNO_NOM_USR_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID, 
				0 );
			------------------------------------------------------			
			SELECT :OLD.NO_NOM_USRREG_CONVHC 
			INTO V_ValueNO_NOM_USRREG_CONVHC
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			Values ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'NO_NOM_USRREG_CONVHC', V_ValueNO_NOM_USRREG_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID,
				0 );
			------------------------------------------------------			
			SELECT :OLD.NU_DOC_SESS_CONVHC 
			INTO V_ValueNU_DOC_SESS_CONVHC
			FROM DUAL; 

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
			VALUES('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'NU_DOC_SESS_CONVHC', V_ValueNU_DOC_SESS_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID,
				0 );
			------------------------------------------------------			
			SELECT :OLD.NU_HIST_USR_CONVHC 
			INTO V_ValueNU_HIST_USR_CONVHC
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			VALUES ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'NU_HIST_USR_CONVHC', V_ValueNU_HIST_USR_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID, 
				0 );
			------------------------------------------------------			
			SELECT :OLD.NU_NUM_SESS_CONVHC 
			INTO V_ValueNU_NUM_SESS_CONVHC
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			VALUES ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'NU_NUM_SESS_CONVHC', V_ValueNU_NUM_SESS_CONVHC,  
				'  ' ,SYSDATE, 
				V_USER_NAME, V_USER_ID, 
				0 );
			------------------------------------------------------
			SELECT :OLD.TX_OBSERV_CONVHC 
			INTO V_ValueTX_OBSERV_CONVHC
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
			VALUES('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'TX_OBSERV_CONVHC', V_ValueTX_OBSERV_CONVHC,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID, 
				0 );
			------------------------------------------------------
			SELECT :OLD.TXT_EMAIL 
			INTO V_ValueTXT_EMAIL
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
			VALUES ('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'TXT_EMAIL', V_ValueTXT_EMAIL,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID,
				0 );
			------------------------------------------------------
			SELECT :OLD.TXT_PHONE 
			INTO V_ValueTXT_PHONE
			FROM DUAL;

			INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
			VALUES('D','CONVOCATORIAS_HIST',
				'CD_CONVOC_HC', V_PrimaryKeyValue , 
				'TXT_PHONE', V_ValueTXT_PHONE,  
				'  ' , SYSDATE, 
				V_USER_NAME, V_USER_ID,
				0 );				
		END;
	END IF;
END;