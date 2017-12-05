CREATE OR REPLACE PROCEDURE H3i_SP_MOT_REPE_RESULTADOS1
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_RESU IN VARCHAR2,
  v_NU_NUME_RESU_REPE_RESU IN VARCHAR2,
  v_CD_CODI_RELA_RESU IN VARCHAR2
)
AS

BEGIN

	UPDATE RESULTADOS1
	SET CD_CODI_RELA_RESU = v_CD_CODI_RELA_RESU,
		NU_NUME_RESU_REPE_RESU = v_NU_NUME_RESU_REPE_RESU
	WHERE  NU_NUME_RESU = v_NU_NUME_RESU;
   

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;