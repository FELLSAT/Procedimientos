CREATE OR REPLACE PROCEDURE H3i_SP_CREA_RIPS_CONSULTA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_FACTURA IN VARCHAR2,
    v_PRESTADOR IN VARCHAR2,
    v_TIPO_IDEN IN VARCHAR2,
    v_NU_IDEN IN VARCHAR2,
    v_FECHA_CONSOL IN DATE,
    v_AUTORIZACION IN VARCHAR2,
    v_CODIGO_CONSULTA IN VARCHAR2,
    v_CODIGO_FINALIDAD IN VARCHAR2,
    v_CAUSA_EXTERNA IN VARCHAR2,
    v_DX_PRINCIPAL IN VARCHAR2,
    v_DX_REL1 IN VARCHAR2,
    v_DX_REL2 IN VARCHAR2,
    v_DX_REL3 IN VARCHAR2,
    v_TIPO_DX IN VARCHAR2,
    v_VALOR_CONSULTA IN NUMBER,
    v_VALOR_CUOTA_MODERADA IN NUMBER,
    v_VALOR_NETO IN NUMBER
)
AS

BEGIN

    INSERT INTO RIPS_CONSULTA( 
        NU_FAC_AC, CD_PRES_AC, TI_IDEN_US_AC, 
        NU_IDEN_US_AC, FE_CONS_AC, NU_AUTO_AC, 
        CD_CONS_AC, CD_FINA_AC, CD_CAUS_EXT_AC, 
        CD_DIAG_PRIN_AC, CD_DIAG_REL1_AC, 
        CD_DIAG_REL2_AC, CD_DIAG_REL3_AC, 
        TP_DIAG_PRIN_AC, VL_CONS_AC, 
        VL_CUOT_MODE_AC, VL_NETO_AC )
    VALUES( 
        v_NU_FACTURA, v_PRESTADOR, 
        v_TIPO_IDEN, v_NU_IDEN, 
        v_FECHA_CONSOL, v_AUTORIZACION, 
        v_CODIGO_CONSULTA, v_CODIGO_FINALIDAD, 
        v_CAUSA_EXTERNA, v_DX_PRINCIPAL, 
        v_DX_REL1, v_DX_REL2, 
        v_DX_REL3, v_TIPO_DX, 
        v_VALOR_CONSULTA, v_VALOR_CUOTA_MODERADA, 
        v_VALOR_NETO );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;