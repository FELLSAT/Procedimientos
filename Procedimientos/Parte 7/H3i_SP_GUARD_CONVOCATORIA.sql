CREATE OR REPLACE PROCEDURE H3i_SP_GUARD_CONVOCATORIA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN NUMBER,
  v_NUMHCLI IN VARCHAR2,
  v_CODUSR IN VARCHAR2,
  v_NOMUSR IN VARCHAR2,
  v_NUMSESS IN NUMBER,
  v_DOCSESS IN VARCHAR2,
  v_CODUSRREG IN VARCHAR2,
  v_NOMUSRREG IN VARCHAR2,
  v_CODPROFES IN VARCHAR2,
  v_NOMPROFES IN VARCHAR2,
  v_FECHACONVOCAT IN DATE,
  v_FECHACONTACTO IN DATE,
  v_OBSERVACIONES IN VARCHAR2,
  v_ESCONTACPHONE IN NUMBER,
  v_ESCONTACEMAIL IN NUMBER,
  v_TELEFONO IN VARCHAR2,
  v_EMAIL IN VARCHAR2
)
AS

BEGIN

   IF v_CODIGO = 0 THEN
    
   BEGIN
      INSERT INTO CONVOCATORIAS_HIST
        ( NU_HIST_USR_CONVHC, CD_COD_USR_CONVHC, NO_NOM_USR_CONVHC, NU_NUM_SESS_CONVHC, NU_DOC_SESS_CONVHC, CD_COD_USRREG_CONVHC, NO_NOM_USRREG_CONVHC, CD_COD_PROFREG_CONVHC, NO_NOM_PROFREG_CONVHC, FE_FECHA_CONT_CONVHC, FE_FECHA_CITA_CONVHC, TX_OBSERV_CONVHC, ES_CONT_TELEF_CONVHC, ES_CONT_EMAIL_CONVHC, TXT_EMAIL, TXT_PHONE )
        VALUES ( v_NUMHCLI, v_CODUSR, v_NOMUSR, v_NUMSESS, v_DOCSESS, v_CODUSRREG, v_NOMUSRREG, v_CODPROFES, v_NOMPROFES, TO_DATE(v_FECHACONTACTO,'dd/mm/yyyy'), TO_DATE(v_FECHACONVOCAT,'dd/mm/yyyy'), v_OBSERVACIONES, v_ESCONTACPHONE, v_ESCONTACEMAIL, v_EMAIL, v_TELEFONO );
   
   END;
   ELSE
   
   BEGIN
      UPDATE CONVOCATORIAS_HIST
         SET NU_HIST_USR_CONVHC = v_NUMHCLI,
             CD_COD_USR_CONVHC = v_CODUSR,
             NO_NOM_USR_CONVHC = v_NOMUSR,
             NU_NUM_SESS_CONVHC = v_NUMSESS,
             NU_DOC_SESS_CONVHC = v_DOCSESS,
             CD_COD_USRREG_CONVHC = v_CODUSRREG,
             NO_NOM_USRREG_CONVHC = v_NOMUSRREG,
             CD_COD_PROFREG_CONVHC = v_CODPROFES,
             NO_NOM_PROFREG_CONVHC = v_NOMPROFES,
             FE_FECHA_CONT_CONVHC = v_FECHACONTACTO,
             FE_FECHA_CITA_CONVHC = v_FECHACONVOCAT,
             TX_OBSERV_CONVHC = v_OBSERVACIONES,
             ES_CONT_TELEF_CONVHC = v_ESCONTACPHONE,
             ES_CONT_EMAIL_CONVHC = v_ESCONTACEMAIL,
             TXT_EMAIL = v_EMAIL,
             TXT_PHONE = v_TELEFONO
       WHERE  CD_CONVOC_HC = v_CODIGO;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;