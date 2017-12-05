CREATE OR REPLACE VIEW VISTA_MOVI_CARGOS_SER
 -- =============================================      
 -- Author:
 -- =============================================

AS 
    SELECT MOVI_CARGOS.NU_ESTA_MOVI ,
      MOVI_CARGOS.NU_NUME_MOVI ,
      MOVI_CARGOS.CD_CODI_LUAT_MOVI || '-' || 
        LABORATORIO.CD_CODI_ESP_LABO || '-' || 
        TO_CHAR(MOVI_CARGOS.NU_TIAT_MOVI) || '-' || 
        '0' LUAT_ESP_TIAT_ESELE_MC,
      LABORATORIO.VL_UNID_LABO * LABORATORIO.CT_CANT_LABO VL_TOTAL_CONTA  ,
      LABORATORIO.VL_UNID_LABO * LABORATORIO.CT_CANT_LABO - LABORATORIO.VL_COPA_LABO VL_RADI_CREDITO  ,
      MOVI_CARGOS.NU_NUME_CONV_MOVI ,
      MOVI_CARGOS.FE_FECH_MOVI ,
      ESPECIALIDADES.NO_NOMB_ESP 
    FROM MOVI_CARGOS 
    INNER JOIN LABORATORIO    
        ON MOVI_CARGOS.NU_NUME_MOVI = LABORATORIO.NU_NUME_MOVI_LABO
    INNER JOIN ESPECIALIDADES    
        ON LABORATORIO.CD_CODI_ESP_LABO = ESPECIALIDADES.CD_CODI_ESP
    WHERE (MOVI_CARGOS.NU_ESTA_MOVI <> 2 );