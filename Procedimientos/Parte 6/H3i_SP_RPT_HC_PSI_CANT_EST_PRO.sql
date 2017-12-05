CREATE OR REPLACE PROCEDURE H3i_SP_RPT_HC_PSI_CANT_EST_PRO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_INI IN VARCHAR2,
  v_FIN IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT COUNT(DISTINCT NU_HIST_PAC)  CANTIDAD  ,
             TX_NOMBRE_CARGO ,
             DE_DESC_DEPE PROGRAMA_ACADEMICO  ,
             IT.DE_DESC_HITE PROBLEMATICA_ATENDIDA  
        FROM PACIENTES 
               INNER JOIN ( SELECT NU_HIST_PAC_MOVI ,
                                NU_NUME_HICL 
                            FROM HISTORIACLINICA 
                                   INNER JOIN LABORATORIO    ON NU_NUME_LABO_HICL = NU_NUME_LABO
                                   INNER JOIN MOVI_CARGOS    ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
                            WHERE  NU_ESTA_MOVI <> 2
                                      AND FE_FECINI_HICL BETWEEN v_INI AND v_FIN
                                      AND NU_NUME_PLHI_HICL = 1348 ) MC   ON NU_HIST_PAC = MC.NU_HIST_PAC_MOVI
               INNER JOIN CARGOS    ON CD_CODI_CARGO_PAC = CD_CODI_CARGO
               INNER JOIN DEPENDENCIA    ON NU_DEPENDENCIA_PAC = CD_CODI_DEPE
               LEFT JOIN HIST_TEXT IT   ON IT.NU_NUME_HICL_HITE = MC.NU_NUME_HICL
               AND IT.NU_INDI_HITE = 64
       WHERE  TX_NOMBRE_CARGO = 'ESTUDIANTE'
        GROUP BY TX_NOMBRE_CARGO,DE_DESC_DEPE,IT.DE_DESC_HITE ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;