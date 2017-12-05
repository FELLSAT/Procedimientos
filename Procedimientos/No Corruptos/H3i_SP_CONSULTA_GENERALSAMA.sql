CREATE OR REPLACE PROCEDURE HIMS.H3i_SP_CONSULTA_GENERALSAMA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
(
  v_CODIGOHISTORICO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT U.NO_NOMB_USUA AU_AUD_REP  ,
            FE_FEC_REP ,
            VA_VAL_TOT_FAC_REP ,
            NU_NUM_AUD_REP ,
            VA_VAL_TOT_GLO_REP ,
            NU_NUM_FOR_GLO_REP ,
            VA_VAL_RET_REP ,
            NU_NUM_FOR_GLO_PAG_REP ,
            VA_VAL_PAG_REP ,
            NU_NUM_FOR_FOR_PAG_REP ,
            VA_VAL_CON_REP ,
            NU_NUM_FAC_CON_REP ,
            VA_VAL_MED_NUM_REP ,
            VA_VAL_DEM_CTC_REP ,
            VAL_VAL_MED_TUT_REP ,
            AN_ANA_REP ,
            VA_VAL_MED_CAN_TUT_REP ,
            NU_NUM_FOR_EJE_REP ,
            NU_NUM_FOR_ARM_REP ,
            NUM_NUM_FOR_FAC_REP 
        FROM AUDI_REPO_GENE 
        INNER JOIN USUARIOS U   
            ON U.ID_IDEN_USUA = TO_CHAR(AU_AUD_REP)
        WHERE  NU_AUTO_GEN_HIST = v_CODIGOHISTORICO ;

    EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
/