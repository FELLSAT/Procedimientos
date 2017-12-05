CREATE OR REPLACE PROCEDURE H3i_SP_RECU_RESCITPREPCOLDEP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_NUME_RCPC ,
            NU_HIST_PAC_RCPC ,
            CD_CODI_LUAT_RCPC ,
            FE_FECH_RCPC ,
            APOYO_MED ,
            NO_NOMB_LUAT ,
            TX_NOMBRECOMPLETO_PAC ,
            NU_NUME_CIT_RCPC 
        FROM RESERV_CIT_PREPAR_COLDEP 
        INNER JOIN LUGAR_ATENCION    
            ON CD_CODI_LUAT = CD_CODI_LUAT_RCPC
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC = NU_HIST_PAC_RCPC
        WHERE  NU_NUME_CIT_RCPC IS NULL
        ORDER BY FE_FECH_RCPC,
                 NU_NUME_RCPC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;