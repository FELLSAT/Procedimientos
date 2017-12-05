CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_INCAP_REGAD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_PACIENTE IN VARCHAR2,
  v_TIPO IN VARCHAR2,
  v_CAUSA IN VARCHAR2,
  v_INICIO IN DATE,
  v_FIN IN DATE,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT DE_DESC_HINC ,
             NU_NUME_HEVO_HINC ,
             CD_CODI_CAEX_HINC ,
             NU_NUME_HICL_HINC ,
             NU_DIAS_HINC ,
             FE_INIC_HINC ,
             NU_PROR_HINC ,
             FE_REGIS_HINC ,
             DE_TIPO_USR_HINC ,
             DE_DEPENDEN_HINC ,
             DE_ASEGURA_HINC ,
             FE_IMPRES_HINC ,
             CD_DIAGNOST_HINC ,
             CD_TIPO_INC_HINC ,
             FE_FINAL_HINC ,
             DE_PROF_IPS_HINC ,
             CD_PROFESIONAL_HINC ,
             NUM_CONSEC_HINC 
        FROM HIST_INCA 
              INNER JOIN LABORATORIO    ON NU_NUME_LABO = NU_NUME_HICL_HINC
               INNER JOIN MOVI_CARGOS    ON NU_NUME_MOVI_LABO = NU_NUME_MOVI
       WHERE  NU_HIST_PAC_MOVI = v_PACIENTE
                AND CD_TIPO_INC_HINC = v_TIPO
                AND CD_CODI_CAEX_HINC = v_CAUSA
                AND FE_INIC_HINC >= v_INICIO
                AND FE_INIC_HINC <= v_FIN
        ORDER BY NU_NUME_HICL_HINC DESC,
                 NU_PROR_HINC DESC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;