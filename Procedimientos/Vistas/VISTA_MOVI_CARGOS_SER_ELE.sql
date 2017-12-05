CREATE OR REPLACE VIEW VISTA_MOVI_CARGOS_SER_ELE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
AS 
		SELECT NU_ESTA_MOVI,NU_NUME_MOVI,
			LUAT_ESP_TIAT_ESELE_MC,VL_TOTAL_CONTA,
			VL_RADI_CREDITO,NU_NUME_CONV_MOVI,
			FE_FECH_MOVI,NO_NOMB_ESP
		FROM vista_movi_cargos_ser 
	UNION 
		SELECT NU_ESTA_MOVI,NU_NUME_MOVI,
			LUAT_ESP_TIAT_ESELE_MC,VL_TOTAL_CONTA,
			VL_RADI_CREDITO,NU_NUME_CONV_MOVI,
			FE_FECH_MOVI,NO_NOMB_ESP 
		FROM vista_movi_cargos_ele;
 