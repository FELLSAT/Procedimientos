CREATE OR REPLACE PROCEDURE H3I_SP_CON_RGE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_AUTO_GRAP_RGE IN NUMBER,
  v_NU_AUTO_HOGR_RGE IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    IF ( v_NU_AUTO_HOGR_RGE <> 0 ) THEN
    
        BEGIN
            OPEN  cv_1 FOR
                SELECT NU_AUTO_GRAP_RGE ,
                    CD_CODI_MED_RGE ,
                    NU_AUTO_HOGR_RGE ,
                    NO_NOMB_MED 
                FROM R_GRU_EST_2 
                INNER JOIN MEDICOS    
                    ON CD_CODI_MED = CD_CODI_MED_RGE
                WHERE  NU_AUTO_GRAP_RGE = v_NU_AUTO_GRAP_RGE
                    AND NU_AUTO_HOGR_RGE = v_NU_AUTO_HOGR_RGE ;        
        END;
    ELSE
   
   BEGIN
      OPEN  cv_1 FOR
         SELECT NU_AUTO_GRAP_RGE ,
                CD_CODI_MED_RGE ,
                NU_AUTO_HOGR_RGE ,
                NO_NOMB_MED 
           FROM R_GRU_EST_2 
                  JOIN MEDICOS    ON CD_CODI_MED = CD_CODI_MED_RGE
          WHERE  NU_AUTO_GRAP_RGE = v_NU_AUTO_GRAP_RGE ;-- AND	NU_AUTO_HOGR_RGE = @NU_AUTO_HOGR_RGE
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;