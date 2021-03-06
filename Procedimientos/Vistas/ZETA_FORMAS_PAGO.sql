CREATE OR REPLACE VIEW ZETA_FORMAS_PAGO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
        SELECT 
            CASE NU_FOPA_FACO
                WHEN 0 THEN 'Efectivo'
                WHEN 1 THEN 'Cheque'
                WHEN 2 THEN 'Tarjeta'
                WHEN 3 THEN 'Pagare'   
            END FORMA_PAGO_COP  ,
            SUM(MOVI_CARGOS.VL_COPA_MOVI)  VALOR  ,
            FACTURAS_CONTADO.NU_NUME_ZETA_FACO ,
            FACTURAS_CONTADO.NU_NUME_CAJA_FACO ,
            COUNT(DISTINCT FACTURAS_CONTADO.NU_NUME_FACO)  Reg  
        FROM FACTURAS_CONTADO 
        INNER JOIN MOVI_CARGOS    
            ON FACTURAS_CONTADO.NU_NUME_FACO = MOVI_CARGOS.NU_NUME_FACO_MOVI
        WHERE (FACTURAS_CONTADO.NU_NUME_FACO <> 0 )
            AND (MOVI_CARGOS.NU_ESTA_MOVI <> 2 )
            AND (FACTURAS_CONTADO.NU_CONSE_FACCAJA_FACO <> 0 )
            AND (FACTURAS_CONTADO.NU_CONE_ANUL_FACO IS NULL )
        GROUP BY FACTURAS_CONTADO.NU_FOPA_FACO,FACTURAS_CONTADO.NU_NUME_ZETA_FACO,
            FACTURAS_CONTADO.NU_NUME_CAJA_FACO
    UNION ALL 
        SELECT 'CREDITO' FORMA_PAGO_COP  ,
            SUM(MOVI_CARGOS.VL_UNID_MOVI - MOVI_CARGOS.VL_COPA_MOVI)  Expr1  ,
            FACTURAS_CONTADO.NU_NUME_ZETA_FACO ,
            FACTURAS_CONTADO.NU_NUME_CAJA_FACO ,
            COUNT(DISTINCT FACTURAS_CONTADO.NU_NUME_FACO)  Expr2  
        FROM FACTURAS_CONTADO 
        INNER JOIN MOVI_CARGOS    
            ON FACTURAS_CONTADO.NU_NUME_FACO = MOVI_CARGOS.NU_NUME_FACO_MOVI
        WHERE (FACTURAS_CONTADO.NU_NUME_FACO <> 0 )
        AND (MOVI_CARGOS.NU_ESTA_MOVI <> 2 )
        AND (FACTURAS_CONTADO.NU_CONSE_FACCAJA_FACO <> 0 )
        AND (FACTURAS_CONTADO.NU_CONE_ANUL_FACO IS NULL )
        GROUP BY FACTURAS_CONTADO.NU_FOPA_FACO,FACTURAS_CONTADO.NU_NUME_ZETA_FACO,
            FACTURAS_CONTADO.NU_NUME_CAJA_FACO;