CREATE OR REPLACE VIEW ZETA_IMPUESTOS_ADM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
    SELECT TB4.NU_NUME_ZETA_FACT ZETA,
        TB4.NU_NUME_CAJA_FACT CAJA,
        TB5.DE_NOMB_IMPU IMPUESTO,
        SUM(((TB2.VL_UNID_LABO * TB2.CT_CANT_LABO) - TB2.VL_COPA_LABO)) BASE,
        CASE TB5.NU_TCOBRO_IMPU
            WHEN 1 THEN TB5.PR_PORC_IMPU
            ELSE 0
        END PORCENTAJE  ,
        SUM(TB1.VL_IMPUESTO_RLI)  VALOR  
    FROM R_LABO_IMPU TB1
    INNER JOIN LABORATORIO TB2   
        ON TB2.NU_NUME_LABO = TB1.NU_NUME_LABO_RLI
    INNER JOIN MOVI_CARGOS TB3   
        ON TB3.NU_NUME_MOVI = TB2.NU_NUME_MOVI_LABO
    INNER JOIN FACTURAS TB4   
        ON TB4.NU_NUME_FAC = TB3.NU_NUME_FAC_MOVI
    INNER JOIN TC_IMPUESTOS TB5   
        ON TB5.CD_CODI_IMPU = TB1.CD_CODI_IMPU_RLI
    WHERE  TB4.NU_NUME_FAC <> 0
        AND TB3.NU_ESTA_MOVI <> 2
        AND TB4.NU_CONSE_FACCAJA_FACT <> 0
        AND TB1.ID_PAGADOPOR_RLI = 1    
    GROUP BY TB4.NU_NUME_ZETA_FACT,TB4.NU_NUME_CAJA_FACT,
        TB5.DE_NOMB_IMPU,TB5.NU_TCOBRO_IMPU,
        TB5.PR_PORC_IMPU;