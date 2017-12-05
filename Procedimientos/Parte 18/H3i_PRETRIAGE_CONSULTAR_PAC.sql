CREATE OR REPLACE PROCEDURE H3i_PRETRIAGE_CONSULTAR_PAC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_LUAT IN VARCHAR2,
  v_NUMHISTPAC IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
      SELECT nu_auto_ptri ,
          nu_hist_pac_ptri ,
          nu_tipdoc_ptri ,
          tx_ape1_ptri ,
          tx_ape2_ptri ,
          tx_nomb1_ptri ,
          tx_nomb2_ptri ,
          fe_nacepac_ptri ,
          fe_ingre_ptri ,
          fe_iniat_ptri ,
          fe_regis_ptri ,
          nu_nume_tria_ptri ,
          nu_nume_cone_ptri ,
          nu_estado_ptri ,
          nu_nume_conanu_ptri ,
          nu_nume_reg_ptri ,
          fe_borra_ptri ,
          tx_borra_ptri ,
          PRETRIAGE.NU_GEST_PAC ,
          (   SELECT FE_FECH_ATEN_HS 
              FROM ( SELECT FE_FECH_ATEN_HS, CD_CODI_TRIAGE
                    FROM HIST_SCOP 
                    ORDER BY NU_NUME_HS DESC )
              WHERE NU_AUTO_PTRI = CD_CODI_TRIAGE
                  AND ROWNUM <= 1 ) FECHA_ATENCION  ,
          (   SELECT FE_FECH_CLAS_HS 
              FROM( SELECT FE_FECH_CLAS_HS, CD_CODI_TRIAGE
                    FROM HIST_SCOP 
                    ORDER BY NU_NUME_HS DESC )
              WHERE NU_AUTO_PTRI = CD_CODI_TRIAGE
                  AND ROWNUM <= 1 ) FECHA_CLASIFICACION 
      FROM PRETRIAGE 
      inner JOIN PACIENTES    
          ON ( NU_HIST_PAC_PTRI = NU_HIST_PAC )
      WHERE  nu_estado_ptri IN ( 0,1,4,5,6,7 )
          --where nu_estado_ptri in (0, 1)
          AND CD_CODI_LUAT_PRET = v_COD_LUAT
          AND NU_HIST_PAC = v_NUMHISTPAC
      ORDER BY nu_auto_ptri ASC; --GARANTIZAMOS EL ORDEN
      

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;