CREATE OR REPLACE VIEW VISTA_MOVI_ESP_HIPOCR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
     SELECT vista_movi_cargos_ser_ele.NU_NUME_MOVI ,
          vista_r_luat_esp_hipcr.NO_NOMB_LUAT_RLEH ,
          vista_r_luat_esp_hipcr.NO_NOMB_ESP_RLEH ,
          vista_r_luat_esp_hipcr.NO_NOMB_CEN_COST_HIPO_RLEH ,
          vista_r_luat_esp_hipcr.CD_CODI_CEN_COST_HIPO_RLEH ,
          vista_r_luat_esp_hipcr.CD_CODI_TIAT_RLEH ,
          vista_movi_cargos_ser_ele.LUAT_ESP_TIAT_ESELE_MC ,
          vista_movi_cargos_ser_ele.NU_NUME_CONV_MOVI ,
          vista_movi_cargos_ser_ele.VL_TOTAL_CONTA ,
          vista_movi_cargos_ser_ele.VL_RADI_CREDITO ,
          vista_movi_cargos_ser_ele.FE_FECH_MOVI 
     FROM vista_r_luat_esp_hipcr 
     INNER JOIN vista_movi_cargos_ser_ele    
          ON vista_r_luat_esp_hipcr.LUAT_ESP_TIAT_ESELE_RLEH = vista_movi_cargos_ser_ele.LUAT_ESP_TIAT_ESELE_MC;