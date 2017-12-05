CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_FOP_FACO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_NUME_FACO_RFF IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_NUME_FACO_RFF ,
            NU_NUME_FOPA_RFF ,
            FORMA_PAGO.DE_DESC_FOPA ,
            NU_MONTO_RFF 
        FROM R_FOP_FACO, FORMA_PAGO 
        WHERE  R_FOP_FACO.NU_NUME_FOPA_RFF = FORMA_PAGO.NU_NUME_FOPA
        AND NU_NUME_FACO_RFF = v_NU_NUME_FACO_RFF ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;