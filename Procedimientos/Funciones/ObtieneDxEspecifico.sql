CREATE OR REPLACE FUNCTION ObtieneDxEspecifico
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NUMLABO IN NUMBER,
    v_TIPOREG IN NUMBER,
    v_TIPO_DIAG IN VARCHAR2
)
RETURN VARCHAR2
AS
    v_Rta VARCHAR2(6);

BEGIN
    SELECT CD_CODI_DIAG_RLAD 
    INTO v_Rta
    FROM R_LABO_DIAG 
    WHERE  NU_NUME_LABO_RLAD = v_NUMLABO
        AND ID_TIPO_RLAD = v_TIPOREG
        AND ID_TIPO_DIAG_RLAD = v_TIPO_DIAG;

    RETURN v_Rta;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;