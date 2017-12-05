CREATE OR REPLACE PROCEDURE H3i_SP_GUARDA_PROFESIONALES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_MED IN VARCHAR2,
  v_NU_DOCU_MED IN VARCHAR2 DEFAULT NULL ,
  v_NO_NOMB_MED IN VARCHAR2 DEFAULT NULL ,
  v_NU_TIPD_MED IN NUMBER DEFAULT NULL ,
  v_DE_DIRE_MED IN VARCHAR2 DEFAULT NULL ,
  v_DE_TELE_MED IN VARCHAR2 DEFAULT NULL ,
  v_DE_CARG_MED IN VARCHAR2 DEFAULT NULL ,
  v_NU_MICO_MED IN NUMBER DEFAULT 0 ,
  v_NU_INDI_MED IN NUMBER DEFAULT 0 ,
  v_NU_ESTA_MED IN NUMBER DEFAULT NULL ,
  v_NU_CONSE_ADSC_MED IN NUMBER DEFAULT NULL ,
  v_NU_MAXC_MED IN NUMBER DEFAULT 0 ,
  v_DE_REGI_MED IN VARCHAR2 DEFAULT NULL ,
  --@NU_FIRMA_MED IMAGE = NULL,
  v_NU_DIAS_MED IN NUMBER DEFAULT NULL ,
  v_CD_CODI_CONC_MED IN VARCHAR2 DEFAULT NULL ,
  v_NO_NOMB1_MED IN VARCHAR2 DEFAULT NULL ,
  v_NO_NOMB2_MED IN VARCHAR2 DEFAULT NULL ,
  v_NO_APEL1_MED IN VARCHAR2 DEFAULT NULL ,
  v_NO_APEL2_MED IN VARCHAR2 DEFAULT NULL ,
  v_NU_MIPRO_MED IN NUMBER DEFAULT 0 ,
  v_NU_DOCENTE_MEDI IN NUMBER,
  v_NU_TIPO_MEDI IN NUMBER,
  v_DE_CELU_MED IN VARCHAR2,
  v_DE_MAIL_MED IN VARCHAR2,
  v_TX_CODIGO_MOCO_MEDI IN VARCHAR2,
  v_PERMITE_CITAWEB IN NUMBER
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE ( SELECT COUNT(CD_CODI_MED)  
               FROM MEDICOS 
                WHERE  CD_CODI_MED = v_CD_CODI_MED ) = 0;
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
    --SE TRATA DE UN MEDICO NUEVO
   BEGIN
      INSERT INTO MEDICOS
        ( CD_CODI_MED, NU_DOCU_MED, NO_NOMB_MED, NU_TIPD_MED, DE_DIRE_MED, DE_TELE_MED, DE_CARG_MED, NU_MICO_MED, NU_INDI_MED, NU_ESTA_MED, NU_CONSE_ADSC_MED, NU_MAXC_MED, DE_REGI_MED
      --  ,[NU_FIRMA_MED]
      , NU_DIAS_MED, CD_CODI_CONC_MED, NO_NOMB1_MED, NO_NOMB2_MED, NO_APEL1_MED, NO_APEL2_MED, NU_MIPRO_MED, NU_DOCENTE_MEDI, NU_TIPO_MEDI, DE_CELU_MED, DE_MAIL_MED, TX_CODIGO_MOCO_MEDI, PERM_CITA_WEB )
        VALUES ( v_CD_CODI_MED, v_NU_DOCU_MED, v_NO_NOMB_MED, v_NU_TIPD_MED, v_DE_DIRE_MED, v_DE_TELE_MED, v_DE_CARG_MED, v_NU_MICO_MED, v_NU_INDI_MED, v_NU_ESTA_MED, v_NU_CONSE_ADSC_MED, v_NU_MAXC_MED, v_DE_REGI_MED, 
      --   ,@NU_FIRMA_MED
      v_NU_DIAS_MED, v_CD_CODI_CONC_MED, v_NO_NOMB1_MED, v_NO_NOMB2_MED, v_NO_APEL1_MED, v_NO_APEL2_MED, v_NU_MIPRO_MED, v_NU_DOCENTE_MEDI, v_NU_TIPO_MEDI, v_DE_CELU_MED, v_DE_MAIL_MED, v_TX_CODIGO_MOCO_MEDI, v_PERMITE_CITAWEB );
   
   END;
   ELSE
   
   BEGIN
      UPDATE MEDICOS
         SET CD_CODI_MED = v_CD_CODI_MED,
             NU_DOCU_MED = v_NU_DOCU_MED,
             NO_NOMB_MED = v_NO_NOMB_MED,
             NU_TIPD_MED = v_NU_TIPD_MED,
             DE_DIRE_MED = v_DE_DIRE_MED,
             DE_TELE_MED = v_DE_TELE_MED,
             DE_CARG_MED = v_DE_CARG_MED,
             NU_MICO_MED = v_NU_MICO_MED,
             NU_INDI_MED = v_NU_INDI_MED,
             NU_ESTA_MED = v_NU_ESTA_MED,
             NU_CONSE_ADSC_MED = v_NU_CONSE_ADSC_MED,
             NU_MAXC_MED = v_NU_MAXC_MED,
             DE_REGI_MED = v_DE_REGI_MED
             -- ,[NU_FIRMA_MED] = @NU_FIRMA_MED
             ,
             NU_DIAS_MED = v_NU_DIAS_MED,
             CD_CODI_CONC_MED = v_CD_CODI_CONC_MED,
             NO_NOMB1_MED = v_NO_NOMB1_MED,
             NO_NOMB2_MED = v_NO_NOMB2_MED,
             NO_APEL1_MED = v_NO_APEL1_MED,
             NO_APEL2_MED = v_NO_APEL2_MED,
             NU_MIPRO_MED = v_NU_MIPRO_MED,
             NU_DOCENTE_MEDI = v_NU_DOCENTE_MEDI,
             NU_TIPO_MEDI = v_NU_TIPO_MEDI,
             DE_CELU_MED = v_DE_CELU_MED,
             DE_MAIL_MED = v_DE_MAIL_MED,
             TX_CODIGO_MOCO_MEDI = v_TX_CODIGO_MOCO_MEDI,
             PERM_CITA_WEB = v_PERMITE_CITAWEB
       WHERE  CD_CODI_MED = v_CD_CODI_MED;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_GUARDA_PROFESIONALES;