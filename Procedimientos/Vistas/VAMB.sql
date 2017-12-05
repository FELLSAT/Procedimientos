CREATE OR REPLACE VIEW VAMB
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
    SELECT SERVICIOS.NO_NOMB_SER ,
      TO_CHAR(COUNT(SERVICIOS.NO_NOMB_SER)) CANTIDAD,
      SUM(PAQUETES.VL_VALO_PAQU) VALOR  
    FROM MOVI_CARGOS 
    INNER JOIN PAQUETES    
        ON MOVI_CARGOS.NU_NUME_MOVI = PAQUETES.NU_NUME_MOVI_PAQU
    INNER JOIN SERVICIOS    
        ON PAQUETES.CD_CODI_SER_PAQU = SERVICIOS.CD_CODI_SER
    WHERE (MOVI_CARGOS.NU_NUME_PAQU_MOVI = 0)
        AND (MOVI_CARGOS.NU_ESTA_MOVI <> 2)
        AND (MOVI_CARGOS.NU_NUME_FACO_MOVI <> 0)
        AND (MOVI_CARGOS.NU_NUME_FAC_MOVI = 216)
        AND ((SELECT CD_ALT2_RST 
              FROM R_SER_TARB 
              WHERE  CD_CODI_SER_PAQU = CD_CODI_SER_RST
                  AND CD_ALT2_RST IS NOT NULL) IN ( 'A_CMG1','A_MM1','A_MM','A_ODU1','A_TOTC1','A_TOTO1','A_TOTE1' ))
    GROUP BY SERVICIOS.NO_NOMB_SER;