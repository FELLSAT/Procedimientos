CREATE OR REPLACE VIEW VISTA_R_LUAT_ESP_HIPCR
 -- =============================================      
 -- Author: 
 -- =============================================
AS 
	SELECT 
		CD_CODI_LUAT_RLEH || '-' || 
			CD_CODI_ESP_RLEH || '-' || 
			CD_CODI_TIAT_RLEH || '-' || 
			TO_CHAR(CD_CODI_ESELE_RLEH) LUAT_ESP_TIAT_ESELE_RLEH,
		NO_NOMB_LUAT_RLEH ,
		NO_NOMB_ESP_RLEH ,
		NO_NOMB_CEN_COST_HIPO_RLEH ,
		CD_CODI_CEN_COST_HIPO_RLEH ,
		CD_CODI_TIAT_RLEH ,
		CD_CODI_ESELE_RLEH 
	FROM R_LUAT_ESP_HIPCR;