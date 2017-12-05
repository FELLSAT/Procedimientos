CREATE OR REPLACE VIEW DIAS_ESPERA_CONSULTA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
	SELECT cd_codi_esp_cit idEspecialidad,
		SUM(NVL(TO_CHAR(fe_fech_cit,'DD') - TO_CHAR(fe_elab_cit,'DD'), 0))  DiasEspera  ,
		((TO_CHAR(CITAS_MEDICAS.FE_ELAB_CIT,'YYYY') * 10000) + 
		(TO_CHAR(CITAS_MEDICAS.FE_ELAB_CIT,'MM') * 100) + 
		(TO_CHAR(CITAS_MEDICAS.FE_ELAB_CIT,'DD'))) idFecha  
	FROM CITAS_MEDICAS 
	GROUP BY CITAS_MEDICAS.FE_ELAB_CIT,CITAS_MEDICAS.CD_CODI_ESP_CIT;