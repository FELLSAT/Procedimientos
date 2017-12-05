CREATE OR REPLACE PROCEDURE H3I_SP_CON_RGD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_AUTO_GRAP_RGD IN NUMBER,
  v_NU_AUTO_HOGR_RGD IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    IF ( v_NU_AUTO_HOGR_RGD <> 0 ) THEN
    
        BEGIN
            OPEN  cv_1 FOR
                SELECT NU_AUTO_GRAP_RGD ,
                       CD_CODI_MED_RGD ,
                       NU_AUTO_HOGR_RGD ,
                       NO_NOMB_MED 
                FROM R_GRU_DOC_2 
                INNER JOIN MEDICOS    
                    ON CD_CODI_MED = CD_CODI_MED_RGD
                WHERE  NU_AUTO_GRAP_RGD = v_NU_AUTO_GRAP_RGD
                AND NU_AUTO_HOGR_RGD = v_NU_AUTO_HOGR_RGD ;     
        END;
    ELSE
   
        BEGIN
            OPEN  cv_1 FOR
                SELECT NU_AUTO_GRAP_RGD ,
                    CD_CODI_MED_RGD ,
                    NU_AUTO_HOGR_RGD ,
                    NO_NOMB_MED 
                FROM R_GRU_DOC_2 
                INNER JOIN MEDICOS    
                    ON CD_CODI_MED = CD_CODI_MED_RGD
                WHERE  NU_AUTO_GRAP_RGD = v_NU_AUTO_GRAP_RGD ;--AND NU_AUTO_HOGR_RGD = @NU_AUTO_HOGR_RGD   
        END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;