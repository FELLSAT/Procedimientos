CREATE OR REPLACE VIEW V_HC_IMPRE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
    SELECT HISTORIACLINICA.NU_NUME_PLHI_HICL ,
        R_PLAN_GRUP.NU_NUME_GRHI_RPG ,
        R_PLAN_CONC.NU_NUME_COHI_RPC ,
        R_PLAN_CONC.NU_NUME_GRHI_RPC ,
        R_PLAN_GRUP.NU_TOP_RPG ,
        R_PLAN_GRUP.NU_LEFT_RPG ,
        R_PLAN_CONC.NU_TOP_RPC ,
        R_PLAN_CONC.NU_LEFT_RPC ,
        R_GRID_PLHI.NU_GRID_ROW * 120 + R_PLAN_GRUP.NU_TOP_RPG + R_PLAN_CONC.NU_TOP_RPC arib  ,
        R_GRID_PLHI.NU_GRID_COL * 120 + R_PLAN_GRUP.NU_LEFT_RPG + R_PLAN_CONC.NU_LEFT_RPC izqu  ,
        R_PLAN_GRUP.NU_INGR_RPG ,
        R_PLAN_GRUP.NU_NUGR_RPG ,
        R_PLAN_GRUP.NU_INDI_RPG ,
        R_PLAN_CONC.NU_INDI_RPC ,
        R_PLAN_CONC.NU_INGR_RPC ,
        GRUPO_HIST.CD_CODI_GRHI ,
        CONCEPTO_HIST.CD_CODI_COHI ,
        R_GRID_PLHI.NU_GRID_VAL 
    FROM PLANTILLA_HIST 
    INNER JOIN R_PLAN_GRUP    
        ON PLANTILLA_HIST.NU_NUME_PLHI = R_PLAN_GRUP.NU_NUME_PLHI_RPG
    INNER JOIN HISTORIACLINICA    
        ON PLANTILLA_HIST.NU_NUME_PLHI = HISTORIACLINICA.NU_NUME_PLHI_HICL
    INNER JOIN R_PLAN_CONC    
        ON R_PLAN_GRUP.NU_NUME_GRHI_RPG = R_PLAN_CONC.NU_NUME_GRHI_RPC
        AND PLANTILLA_HIST.NU_NUME_PLHI = R_PLAN_CONC.NU_NUME_PLHI_RPC
    INNER JOIN CONCEPTO_HIST    
        ON R_PLAN_CONC.NU_NUME_COHI_RPC = CONCEPTO_HIST.NU_NUME_COHI
    INNER JOIN GRUPO_HIST    
        ON R_PLAN_CONC.NU_NUME_GRHI_RPC = GRUPO_HIST.NU_NUME_GRHI
    INNER JOIN R_GRID_PLHI    
        ON CONCEPTO_HIST.NU_NUME_COHI = R_GRID_PLHI.NU_NUME_COHI_G
        AND GRUPO_HIST.NU_NUME_GRHI = R_GRID_PLHI.NU_NUME_GRHI_GRID
        AND HISTORIACLINICA.NU_NUME_PLHI_HICL = R_GRID_PLHI.NU_NUME_PLHI_G;