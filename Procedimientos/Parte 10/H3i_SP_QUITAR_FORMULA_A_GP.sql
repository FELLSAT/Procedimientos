CREATE OR REPLACE PROCEDURE H3i_SP_QUITAR_FORMULA_A_GP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_GP IN VARCHAR2
)
AS

BEGIN

   DELETE R_GP_DEP_POR

    WHERE  CD_CODI_GP_RGDP = v_CD_CODI_GP;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;