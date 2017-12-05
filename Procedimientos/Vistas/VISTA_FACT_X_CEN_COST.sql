CREATE OR REPLACE VIEW VISTA_FACT_X_CEN_COST
-- =============================================       
-- Author:  FELIPE SATIZABAL
-- ============================================= 
AS 
  SELECT vista_movi_esp_hipocr.CD_CODI_CEN_COST_HIPO_RLEH ,
      vista_movi_esp_hipocr.NO_NOMB_CEN_COST_HIPO_RLEH ,
      EPS.NO_NOMB_EPS ,
      CONVENIOS.CD_CODI_CONV ,
      vista_movi_esp_hipocr.NO_NOMB_LUAT_RLEH ,
      vista_movi_esp_hipocr.NO_NOMB_ESP_RLEH ,
      vista_movi_esp_hipocr.VL_TOTAL_CONTA ,
      vista_movi_esp_hipocr.VL_RADI_CREDITO ,
      vista_movi_esp_hipocr.FE_FECH_MOVI 
  FROM EPS 
  INNER JOIN CONVENIOS    
      ON EPS.CD_NIT_EPS = CONVENIOS.CD_NIT_EPS_CONV
  INNER JOIN vista_movi_esp_hipocr    
      ON CONVENIOS.NU_NUME_CONV = vista_movi_esp_hipocr.NU_NUME_CONV_MOVI;