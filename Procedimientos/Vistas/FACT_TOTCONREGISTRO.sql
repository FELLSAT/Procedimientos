CREATE OR REPLACE VIEW FACT_TOTCONREGISTRO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
        SELECT * 
        FROM FACT_RegNoPaquElem 
    UNION ALL 
        SELECT * 
        FROM FACT_RegNoPaquServ 
    UNION ALL 
        SELECT * 
        FROM FACT_RegPaqu 
    UNION ALL 
        SELECT * 
        FROM FACT_RegPaquDetEle 
    UNION ALL 
        SELECT * 
        FROM FACT_RegPaquDetServ 
    UNION ALL 
        SELECT * 
        FROM FACTANUL_RegNoPaquElem
    UNION ALL 
        SELECT * 
        FROM FACTANUL_RegNoPaquServ 
    UNION ALL 
        SELECT * 
        FROM FACTANUL_RegPaqu
    UNION ALL 
        SELECT * 
        FROM FACTANUL_RegPaquDetEle 
    UNION ALL 
        SELECT * 
        FROM FACTANUL_RegPaquDetServ; 

    