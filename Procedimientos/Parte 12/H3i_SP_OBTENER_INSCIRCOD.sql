CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_INSCIRCOD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CD_CODI_CIR IN NUMBER,
    v_CD_CODI_PRO IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_COD_ARTSERCIR CODIGO  ,
             CD_SOLI_CIRUG CD_CODI_CIR  ,
             CD_COD_ART_ARTSERCIR CD_CODI_ARTI_RAS  ,
             CD_COD_SERV_ARTSERCIR CD_CODI_SER_RAS  ,
             CANTIDAD_INSUMS_ARTSERCIR CANTIDAD  ,
             TXT_OBS_ARTSERCIR TX_OB_R_ART_SER  ,
             FE_FECHAREG_ARTSERCIR FECHAREG  ,
             FE_FECHAUPD_ARTSERCIR FECHAUPD  
        FROM R_ART_SER_CIR 
        WHERE  CD_SOLI_CIRUG = v_CD_CODI_CIR
            AND CD_COD_SERV_ARTSERCIR = v_CD_CODI_PRO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;