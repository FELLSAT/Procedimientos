CREATE OR REPLACE PROCEDURE H3I_SP_BUSQUEDAACTIVA_CHAP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_FECHAINICIAL IN DATE,
  v_FECHAFINAL IN DATE,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT DISTINCT TO_NUMBER(NU_ID_ITBU) NU_ID_ITBU  ,
                      TX_TITULO_ITBU ,
                      NU_SALTO_ITBU ,
                      TX_TITSALTO_ITBU ,
                      NVL(CANTIDAD, 0) CANTIDAD  
        FROM ITEM_BUSQUEDAACTIVA 
              LEFT JOIN( SELECT NU_ID_ITBU_RID ,
                                 COUNT(DISTINCT NU_NUME_MOVI)  CANTIDAD  
                          FROM R_LABO_DIAG RLD
                          INNER JOIN LABORATORIO L   
                            ON ( RLD.NU_NUME_LABO_RLAD = NU_NUME_LABO
                            AND ID_TIPO_RLAD = 1 )
                          INNER JOIN MOVI_CARGOS M   
                            ON L.NU_NUME_MOVI_LABO = M.NU_NUME_MOVI
                          INNER JOIN PACIENTES P   
                            ON P.NU_HIST_PAC = M.NU_HIST_PAC_MOVI
                          INNER JOIN R_ITBU_DIAG    
                            ON CD_CODI_DIAG_RLAD = CD_CODI_DIAG_RID
                          WHERE  NU_ESTA_LABO <> 2
                            AND NU_ESTA_MOVI <> 2
                            AND FE_FECH_MOVI BETWEEN v_FECHAINICIAL AND v_FECHAFINAL
                          GROUP BY NU_ID_ITBU_RID ) DXS   
              ON DXS.NU_ID_ITBU_RID = NU_ID_ITBU
        ORDER BY 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;