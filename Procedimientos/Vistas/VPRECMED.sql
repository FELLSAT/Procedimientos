CREATE OR REPLACE VIEW VPRECMED
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
AS 
    SELECT( SELECT CD_ALT2_RST 
            FROM R_SER_TARB 
            WHERE  CD_CODI_ELE_FORM = CD_CODI_SER_RST
            AND CD_ALT2_RST IS NOT NULL ) COD_FINAL,
        VL_UNID_FORM * CT_CANT_FORM VALOR  
    FROM MOVI_CARGOS 
    INNER JOIN FORMULAS    
        ON FORMULAS.NU_NUME_MOVI_FORM = MOVI_CARGOS.NU_NUME_MOVI
    WHERE (MOVI_CARGOS.NU_NUME_PAQU_MOVI = 0 )
        AND (MOVI_CARGOS.NU_NUME_FACO_MOVI <> 0 )
        AND NU_NUME_FAC_MOVI = 323;