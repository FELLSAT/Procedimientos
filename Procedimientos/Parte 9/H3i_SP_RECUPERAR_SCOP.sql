CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_SCOP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ID IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_NUME_HS ,
             NU_HIST_PAC_HS ,
             FE_FECH_INGR_HS ,
             FE_FECH_CLAS_HS ,
             FE_FECH_ATEN_HS ,
             FE_FECH_CIER_HS ,
             CD_CODI_REG_HS ,
             CD_CODI_PA_HS ,
             CD_NIT_EPS_HS ,
             NU_NUME_CONV_HS ,
             NU_EDAD_HS ,
             DE_MOTI_HS ,
             NU_CALI_HS ,
             CD_CODI_CONS_HS ,
             NU_MEGA_HS ,
             FE_FECH_MEGA_HS ,
             NU_TIPS_HS ,
             NU_NUME_HS_SP ,
             NU_NUME_SV_SP ,
             NU_NUME_SO_SP ,
             NU_PUNT_SP ,
             NU_NUME_SV ,
             TX_NOMB_SV ,
             NU_TIPO_SV ,
             NU_NUME_SO ,
             NU_NUME_SV_SO ,
             TX_NOMB_SO ,
             NU_PUNT_SO ,
             NU_TIPD_PAC ,
             NU_DOCU_PAC ,
             TX_NOMBRECOMPLETO_PAC ,
             NO_NOMB_EPS ,
             CD_CODI_CONV ,
             DE_DESC_CONS ,
             TX_NOMB_PA 
        FROM HIST_SCOP 
               INNER JOIN PACIENTES    ON NU_HIST_PAC = NU_HIST_PAC_HS
               INNER JOIN EPS    ON CD_NIT_EPS = CD_NIT_EPS_HS
               INNER JOIN CONVENIOS    ON NU_NUME_CONV_HS = NU_NUME_CONV
               INNER JOIN SCOP_PUNTAJE    ON NU_NUME_HS_SP = NU_NUME_HS
               INNER JOIN SCOP_VARIABLE    ON NU_NUME_SV_SP = NU_NUME_SV
               INNER JOIN SCOP_OPCION    ON NU_NUME_SO_SP = NU_NUME_SO
               INNER JOIN CONSULTORIOS    ON CD_CODI_CONS_HS = CD_CODI_CONS
               INNER JOIN PROGRAMA_ACADEMICO    ON CD_CODI_PA = CD_CODI_PA_HS
       WHERE  NU_NUME_HS = v_ID ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;