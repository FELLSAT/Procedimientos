CREATE OR REPLACE FUNCTION EvaluarEdadRiesgo_CLAP -- FUNCIÓN PARA EVALUAR LA EDAD DE RIESGO -> CLAP	SI RETORNA 1 ES UNA EDAD DE RIESGO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_EDAD_ANIOS IN NUMBER
)
RETURN NUMBER
AS

BEGIN

    IF ( v_EDAD_ANIOS < 15 ) THEN
        RETURN 1;
    END IF;

    IF ( v_EDAD_ANIOS > 40 ) THEN
        RETURN 1;
    END IF;

    RETURN 0;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;