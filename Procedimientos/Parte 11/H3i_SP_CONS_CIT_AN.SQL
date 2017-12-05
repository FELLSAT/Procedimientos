CREATE OR REPLACE PROCEDURE H3i_SP_CONS_CIT_AN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_FECHAINICIAL IN DATE,
  v_FECHAFINAL IN DATE,
  v_NUMHIST IN VARCHAR2 DEFAULT NULL ,
  v_CODMEDICO IN VARCHAR2 DEFAULT NULL ,
  v_CODESP IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_MED_CIAN ,
             CD_CODI_SER_CIAN ,
             NU_HIST_PAC_CIAN ,
             NU_DURA_CIAN ,
             FE_ELAB_CIAN ,
             FE_FECH_CIAN ,
             NU_DIA_CIAN ,
             TO_NUMBER(NU_NUME_MOVI_CIAN) NU_NUME_MOVI_CIAN  ,
             TO_NUMBER(NU_PRIM_CIAN) NU_PRIM_CIAN  ,
             FE_HORA_CIAN ,
             --	CAST(NU_NUME_CONE_CIAN AS NUMERIC) NU_NUME_CONE_CIAN,
             NU_CONE_CALL_CIAN ,
             CD_CODI_ESP_CIAN ,
             CD_CODI_CONS_CIAN ,
             TO_NUMBER(NU_NUME_CONV_CIAN) NU_NUME_CONV_CIAN  ,
             TO_NUMBER(NU_TIPO_CIAN) NU_TIPO_CIAN  ,
             DE_DESC_CIAN ,
             --	CAST(NU_NUME_CIT_CIAN AS NUMERIC(18,2)) NU_NUME_CIT_CIAN,
             CD_MEDI_ORDE_CIAN ,
             ME_OBSMOD_CIAN ,
             TX_USER_CIAN ,
             NO_NOMB_SER ,
             NO_NOMB_ESP ,
             CASE CD_CODI_MED_EST_CIAN
                                      WHEN NULL THEN ' '
             ELSE ( SELECT NO_NOMB_MED 
                    FROM MEDICOS 
                     WHERE  CD_CODI_MED = CD_CODI_MED_EST_CIAN )
                END NOM_ESTUD  
        FROM CITAS_ANULADAS 
               INNER JOIN SERVICIOS    ON CD_CODI_SER_CIAN = CD_CODI_SER
               INNER JOIN ESPECIALIDADES    ON CD_CODI_ESP = CD_CODI_ESP_CIAN
       WHERE  FE_FECH_CIAN BETWEEN v_FECHAINICIAL AND v_FECHAFINAL
                AND NU_HIST_PAC_CIAN = NVL(v_NUMHIST, NU_HIST_PAC_CIAN)
                AND CD_CODI_MED_CIAN = NVL(v_CODMEDICO, CD_CODI_MED_CIAN)
                AND CD_CODI_ESP = NVL(v_CODESP, CD_CODI_ESP)
        ORDER BY FE_FECH_CIAN ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;