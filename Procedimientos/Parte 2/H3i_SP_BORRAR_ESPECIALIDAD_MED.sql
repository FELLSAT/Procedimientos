CREATE OR REPLACE PROCEDURE H3i_SP_BORRAR_ESPECIALIDAD_MED
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_MED_RMP IN VARCHAR2
)
AS

BEGIN

   DELETE R_MEDI_ESPE

    WHERE  CD_CODI_MED_RMP = v_CD_CODI_MED_RMP;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_BORRAR_ESPECIALIDAD_MED;