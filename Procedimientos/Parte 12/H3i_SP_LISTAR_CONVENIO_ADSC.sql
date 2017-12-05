CREATE OR REPLACE PROCEDURE H3i_SP_LISTAR_CONVENIO_ADSC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_COAD ,
            NU_NUME_COAD ,
            VL_CUPO_COAD ,
            VL_SALD_COAD ,
            VL_CUIN_COAD ,
            NU_VIGEN_COAD ,
            FE_INIC_COAD ,
            FE_FINA_COAD ,
            NU_CONSE_ADSC_COAD ,
            DE_DESC_COAD ,
            PR_INTE_COAD ,
            NU_TIPOCON_COAD ,
            NU_UNIMED_COAD ,
            NU_TIEMCON_COAD ,
            NU_PERIO_COAD ,
            VL_UNID_COAD ,
            DE_NOMB_COAD ,
            NU_TILI_COAD ,
            VL_VAL_ALERT 
        FROM CONVENIO_ADSC  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;