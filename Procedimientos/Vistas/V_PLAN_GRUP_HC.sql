CREATE OR REPLACE VIEW V_PLAN_GRUP_HC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
     SELECT R_PLAN_GRUP.NU_NUME_PLHI_RPG ,
          R_PLAN_GRUP.NU_NUME_GRHI_RPG ,
          R_PLAN_GRUP.NU_INDI_RPG ,
          R_PLAN_GRUP.NU_INGR_RPG ,
          R_PLAN_GRUP.NU_NUGR_RPG ,
          R_PLAN_GRUP.NU_TOP_RPG ,
          R_PLAN_GRUP.NU_LEFT_RPG ,
          R_PLAN_GRUP.NU_HEIGHT_RPG ,
          R_PLAN_GRUP.NU_WIDTH_RPG ,
          R_PLAN_GRUP.NU_INDIDEP_RPC_RPG ,
          R_PLAN_GRUP.NU_INVACTASO_RPG ,
          R_PLAN_GRUP.TX_BORDES_RPG ,
          R_PLAN_GRUP.TX_hxCOLORROTULO_RPG ,
          R_PLAN_GRUP.TX_hxCOLORLETRA_RPG ,
          R_PLAN_GRUP.NU_ROTULOTOTALANCHO_RPG ,
          R_PLAN_GRUP.NU_ALINEAROTULO_RPG ,
          R_PLAN_GRUP.NU_TAMFUENTE_RPG ,
          R_PLAN_GRUP.NU_ROTULOPERPEN_RPG ,
          R_PLAN_GRUP.NU_ROTULOVISIBLE_RPG ,
          R_PLAN_GRUP.NU_NEGRILLA_RPG ,
          R_PLAN_GRUP.NU_ALINEAROTULOVERTICAL_RPG ,
          GRUPO_HIST.TX_TITULO_GRHI ,
          GRUPO_HIST.NU_NUME_GRHI ,
          GRUPO_HIST.CD_CODI_GRHI 
     FROM R_PLAN_GRUP 
     INNER JOIN GRUPO_HIST    
               ON R_PLAN_GRUP.NU_NUME_GRHI_RPG = GRUPO_HIST.NU_NUME_GRHI;
