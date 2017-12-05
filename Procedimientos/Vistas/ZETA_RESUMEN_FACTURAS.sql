CREATE OR REPLACE VIEW ZETA_RESUMEN_FACTURAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
AS 
  SELECT FACTURAS_CONTADO.NU_NUME_ZETA_FACO ,
      FACTURAS_CONTADO.NU_NUME_CAJA_FACO ,
      ObtieneMaxMinFac_CajaZ(FACTURAS_CONTADO.NU_NUME_ZETA_FACO, FACTURAS_CONTADO.NU_NUME_CAJA_FACO, 1) INICIO ,
      ObtieneMaxMinFac_CajaZ(FACTURAS_CONTADO.NU_NUME_ZETA_FACO, FACTURAS_CONTADO.NU_NUME_CAJA_FACO, 2) FINAL ,
      ObtieneCantFac_CajaZ(FACTURAS_CONTADO.NU_NUME_ZETA_FACO, FACTURAS_CONTADO.NU_NUME_CAJA_FACO, NULL, 0) + 
        ObtieneCantFac_CajaZ( FACTURAS_CONTADO.NU_NUME_ZETA_FACO,  FACTURAS_CONTADO.NU_NUME_CAJA_FACO, NULL, 1) CANTIDAD_FACTURAS  ,
      SUM(MOVI_CARGOS.VL_UNID_MOVI)  VALOR  
  FROM FACTURAS_CONTADO 
  INNER JOIN MOVI_CARGOS    
      ON FACTURAS_CONTADO.NU_NUME_FACO = MOVI_CARGOS.NU_NUME_FACO_MOVI
  WHERE (FACTURAS_CONTADO.NU_NUME_FACO <> 0)
      AND (MOVI_CARGOS.NU_ESTA_MOVI <> 2)
      AND (FACTURAS_CONTADO.NU_CONSE_FACCAJA_FACO <> 0)
  GROUP BY  FACTURAS_CONTADO.NU_NUME_ZETA_FACO, FACTURAS_CONTADO.NU_NUME_CAJA_FACO;