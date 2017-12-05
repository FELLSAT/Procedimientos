CREATE OR REPLACE PROCEDURE H3i_SP_VALID_ESPEC_ESTUD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ESTUDIANTE IN VARCHAR2,
  v_ESPECIALIDAD IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_ESP_RMP 
        FROM R_MEDI_ESPE 
       WHERE  CD_CODI_MED_RMP = v_ESTUDIANTE
                AND CD_CODI_ESP_RMP = v_ESPECIALIDAD
                AND NU_ESTADO_RMP = 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;