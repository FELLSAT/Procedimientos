CREATE OR REPLACE PROCEDURE H3i_SP_RECU_VAC_APL /** RECUPERAR VACUNA APLICADA **/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NUM_HIST_PACIENTE IN VARCHAR2,
  v_COD_VACUNA IN VARCHAR2,
  v_TIPO_VACUNA IN VARCHAR2,
  v_NUM_DOSIS IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_AUTO_VACU ,
             NU_HIST_PAC_VACU ,
             CD_CODI_SERV_VACU ,
             NU_DOSIS_VACU ,
             FE_FECH_VACU ,
             FE_REGI_VACU ,
             NU_NUME_CONE_VACU ,
             TX_TIPO_VACU ,
             NU_NUME_MOVI_VACU ,
             TX_ESTA_VACU ,
             NU_APL_INSTI ,
             TX_NO_LOTE ,
             TX_LAB ,
             FE_VENC ,
             TX_IPS ,
             TX_OBS ,
             TX_SITIO ,
             TX_TIPO ,
             TX_VIA ,
             TX_PAI ,
             TX_ESQUEMA ,
             TX_CONDICION 
        FROM VACUNACION 
       WHERE  NU_HIST_PAC_VACU = v_NUM_HIST_PACIENTE
                AND CD_CODI_SERV_VACU = v_COD_VACUNA
                AND TX_TIPO_VACU = v_TIPO_VACUNA
                AND NU_DOSIS_VACU = v_NUM_DOSIS AND ROWNUM <= 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_RECU_VAC_APL;