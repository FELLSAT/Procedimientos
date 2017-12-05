CREATE OR REPLACE VIEW VW_ZETAS_CAJA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
     SELECT C.CD_CODI_CAJA ,
          Z.NU_NUME_ZETA ,
          Z.FE_FECH_ZETA ,
          Z.DE_HORA_ZETA ,
          Z.NU_CONSE_FACFIN_ZETA ,
          Z.NU_CONSE_FACINI_ZETA ,
          ObtieneCantFac_CajaZ(Z.NU_NUME_ZETA, C.CD_CODI_CAJA, NULL, NULL) CANTIDADFACTURAS  ,
          Z.CD_CODI_COMPROBANTE_ZETA ,
          Z.VL_ZETA 
     FROM ZETAS Z
     INNER JOIN CAJAS C   
          ON Z.DE_IPDIR_CAJA_ZETA = C.DE_IPDIR_CAJA;