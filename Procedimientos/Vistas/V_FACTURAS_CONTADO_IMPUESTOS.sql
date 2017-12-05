CREATE OR REPLACE VIEW V_FACTURAS_CONTADO_IMPUESTOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
    SELECT TB3.NU_NUME_FACO_MOVI FACT  ,
        TB4.DE_NOMB_IMPU IMPUESTO  ,
        ((TB2.VL_UNID_LABO * TB2.CT_CANT_LABO) - TB2.VL_COPA_LABO) BASE  ,
        CASE TB4.NU_TCOBRO_IMPU
            WHEN 1 THEN TB4.PR_PORC_IMPU
            ELSE 0
        END PORCENTAJE  ,
        TB1.VL_IMPUESTO_RLI VALOR  
    FROM R_LABO_IMPU TB1
    INNER JOIN LABORATORIO TB2   
        ON TB2.NU_NUME_LABO = TB1.NU_NUME_LABO_RLI
    INNER JOIN MOVI_CARGOS TB3   
        ON TB3.NU_NUME_MOVI = TB2.NU_NUME_MOVI_LABO
    inner JOIN TC_IMPUESTOS TB4   
        ON TB4.CD_CODI_IMPU = TB1.CD_CODI_IMPU_RLI
    WHERE  TB1.ID_PAGADOPOR_RLI = 0;