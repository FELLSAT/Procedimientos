CREATE OR REPLACE VIEW FACT_TOTSINREGISTRO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
        SELECT * 
        FROM FACT_NoRegNoPaquElem 
    UNION ALL 
        SELECT * 
        FROM FACT_NoRegNoPaquServ 
    UNION ALL 
        SELECT * 
        FROM FACT_NoRegPaqu 
    UNION ALL 
        SELECT * 
        FROM FACT_NoRegPaquDetElem 
    UNION ALL 
        SELECT * 
        FROM FACT_NoRegPaquDetSer 
    UNION ALL 
        SELECT * 
        FROM FACTANUL_NoRegNoPaquElem 
    UNION ALL 
        SELECT * 
        FROM FACTANUL_NoRegNoPaquServ 
    UNION ALL 
        SELECT * 
        FROM FACTANUL_NoRegPaqu 
    UNION ALL 
        SELECT * 
        FROM FACTANUL_NoRegPaquDetElem 
    UNION ALL 
        SELECT * 
        FROM FACTANUL_NoRegPaquDetSer;