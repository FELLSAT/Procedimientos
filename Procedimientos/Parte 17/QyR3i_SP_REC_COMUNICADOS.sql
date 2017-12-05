CREATE OR REPLACE PROCEDURE QyR3i_SP_REC_COMUNICADOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_NUME_COM ,
            FE_FECH_INI_COM ,
            NU_REM_COM ,
            TX_ASUN_COM ,
            TX_CONT_COM ,
            TX_DEST_COM ,
            NU_NUME_EST_COM ,
            NU_NUME_SQR_COM ,
            NVL(CD_CODI_PA, ' ') CD_CODI_PA  ,
            NVL(TX_NOMB_PA, ' ') TX_NOMB_PA  
        FROM QYR_COMUNICADO 
        LEFT JOIN QYR_SOLICITUD    
            ON NU_NUME_SQR_COM = NU_NUME_SOL
        LEFT JOIN PROGRAMA_ACADEMICO    
            ON CD_CODI_PA_SOL = CD_CODI_PA
        ORDER BY FE_FECH_INI_COM DESC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;