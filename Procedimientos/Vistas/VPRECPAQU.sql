CREATE OR REPLACE VIEW VPRECPAQU
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
    SELECT (SELECT CD_ALT2_RST 
            FROM R_SER_TARB 
            WHERE  CD_CODI_SER_PAQU = CD_CODI_SER_RST
                AND CD_ALT2_RST IS NOT NULL ) Cod_Final  ,
            VL_VALO_PAQU VALOR  
    FROM MOVI_CARGOS 
    INNER JOIN PAQUETES    
        ON PAQUETES.NU_NUME_MOVI_PAQU = MOVI_CARGOS.NU_NUME_MOVI
    WHERE (MOVI_CARGOS.NU_NUME_PAQU_MOVI = 0 )
        AND (MOVI_CARGOS.NU_NUME_FACO_MOVI <> 0 )
        AND NU_NUME_FAC_MOVI = 323;