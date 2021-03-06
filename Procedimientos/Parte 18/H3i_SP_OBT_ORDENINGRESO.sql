CREATE OR REPLACE PROCEDURE H3i_SP_OBT_ORDENINGRESO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_LUAT_ORIN IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

	OPEN  cv_1 FOR
		SELECT ID_ORIN ,
			NO_NOMB_PAC ,
			NO_SGNO_PAC ,
			DE_PRAP_PAC ,
			DE_SGAP_PAC ,
			NU_DOCU_PAC ,
			NU_TIPD_PAC ,
			NU_SEXO_PAC ,
			FE_NACI_PAC ,
			NU_GEST_PAC ,
			NU_AUTO_TRIA ,
			NU_HIST_PAC ,
			FE_INIAT_TRIA ,
			NU_ESTA_ORIN ,
			DE_DESC_TIT 
		FROM PACIENTES ,
			TRIAGE3i ,
			ORDENINGRESO ,
			TIPOTRIAGE 
		WHERE  ORDENINGRESO.NU_ESTA_ORIN = 1
			AND ORDENINGRESO.NU_NUME_HICL_ORIN = TRIAGE3i.NU_AUTO_TRIA
			AND TRIAGE3i.NU_HIST_PAC_TRIA = PACIENTES.NU_HIST_PAC
			AND TRIAGE3i.NU_TIPOTRIAGE_TRIA = TIPOTRIAGE.CD_CODI_TIT
			AND ORDENINGRESO.CD_CODI_LUAT_ORIN = v_CD_CODI_LUAT_ORIN ;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;