CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_INDI_MEDICA --Procedimiento almacenado que consulta una indicación médica asociada a una historia clínica de un paciente
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NoHICL IN NUMBER,
  v_NoEVO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT DE_DESC_HIND ,
             NU_NUME_HEVO_HIND ,
             NU_NUME_HICL_HIND 
        FROM HIST_INDI 
       WHERE  NU_NUME_HEVO_HIND = v_NoEVO
                AND NU_NUME_HICL_HIND = v_NoHICL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;