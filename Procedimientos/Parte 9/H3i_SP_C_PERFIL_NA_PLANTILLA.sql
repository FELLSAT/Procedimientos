CREATE OR REPLACE PROCEDURE H3i_SP_C_PERFIL_NA_PLANTILLA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_IdPlantilla IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_NUME_PLHI ,
             CD_CODI_PERF 
        FROM R_PERFILES_PLANTILLA 
       WHERE  NU_NUME_PLHI = v_IdPlantilla ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;