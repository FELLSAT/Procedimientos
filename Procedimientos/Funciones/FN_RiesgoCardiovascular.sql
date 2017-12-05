CREATE OR REPLACE FUNCTION FN_RiesgoCardiovascular
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_Fr1 IN NUMBER,
    iv_Fr2 IN NUMBER,
    v_Fr3 IN NUMBER,
    v_Fr4 IN NUMBER,
    v_Fr5 IN NUMBER,
    v_Fr6 IN NUMBER,
    v_Fr7 IN NUMBER,
    v_Fr8 IN NUMBER,
    v_Fr9 IN NUMBER,
    v_Fr10 IN NUMBER,
    v_Fr11 IN NUMBER,
    v_Fr12 IN NUMBER,
    v_LOB IN NUMBER,
    v_DM_I IN NUMBER,
    v_DM_II IN NUMBER,
    v_Dx_HIPERTENSION IN VARCHAR2
)
RETURN VARCHAR2
AS
    v_Fr2 NUMBER := iv_Fr2;
    v_RTA VARCHAR2(4000);
    v_FactoresRiesgo NUMBER;

BEGIN
    IF v_Fr2 = 0 THEN
        v_Fr2 := 1 ;
    ELSE
        v_Fr2 := 0 ;
    END IF;

    -----------------------------------
    v_RTA := 'EVALUADO' ;
    v_FactoresRiesgo := v_Fr1 + v_Fr2 + v_Fr3 + v_Fr4 + v_Fr5 + v_Fr6 + v_Fr7 + v_Fr8 + v_Fr9 + v_Fr10 + v_Fr11 + v_Fr12 ;
    
    -----------------------------------
    IF v_FactoresRiesgo = 0 AND v_DM_I = 0 AND v_DM_II = 0 AND v_LOB = 0 THEN

        IF v_Dx_HIPERTENSION = 'P.A. OPTIMA' OR v_Dx_HIPERTENSION = 'P.A. NORMAL' OR v_Dx_HIPERTENSION = 'P.A. NORMAL ALTA' THEN
            v_RTA := 'Riesgo Promedio' ;
        END IF;

    END IF;

    -----------------------------------
    IF v_Dx_HIPERTENSION = 'HIPERTENSIÓN ESTADIO 1' AND v_FactoresRiesgo = 0 AND v_DM_I = 0 AND v_DM_II = 0 AND v_LOB = 0 THEN
        v_RTA := 'Riesgo Bajo' ;
    END IF;

    -----------------------------------
    IF ( v_Dx_HIPERTENSION = 'P.A. OPTIMA' OR v_Dx_HIPERTENSION = 'P.A. NORMAL'
        OR v_Dx_HIPERTENSION = 'P.A. NORMAL ALTA' ) AND ( ( v_FactoresRiesgo BETWEEN 1 AND 2 )
        AND v_DM_I = 0 AND v_DM_II = 0 AND v_LOB = 0 ) THEN
            v_RTA := 'Riesgo Bajo' ;
    END IF;

    -----------------------------------
    IF v_Dx_HIPERTENSION = 'HIPERTENSIÓN ESTADIO 1' AND ( ( v_FactoresRiesgo BETWEEN 1 AND 2 )
        AND v_DM_I = 0 AND v_DM_II = 0 AND v_LOB = 0 ) THEN
            v_RTA := 'Riesgo Moderado' ;
    END IF;

    -----------------------------------
    IF v_Dx_HIPERTENSION = 'HIPERTENSIÓN ESTADIO 2' AND ( ( v_FactoresRiesgo BETWEEN 0 AND 2 )
      AND v_DM_I = 0 AND v_DM_II = 0 AND v_LOB = 0 ) THEN
          v_RTA := 'Riesgo Moderado' ;
    END IF;

    -----------------------------------
    IF ( v_Dx_HIPERTENSION = 'P.A. OPTIMA' OR v_Dx_HIPERTENSION = 'P.A. NORMAL'
        OR v_Dx_HIPERTENSION = 'P.A. NORMAL ALTA' ) AND ( ( v_FactoresRiesgo > 2 )
        OR v_DM_I = 1 OR v_DM_II = 1 OR v_LOB = 1 ) THEN
            v_RTA := 'Riesgo Moderado' ;  
    END IF;

    -----------------------------------
    IF v_Dx_HIPERTENSION = 'HIPERTENSIÓN ESTADIO 3' AND ( ( v_FactoresRiesgo = 0 )
        AND v_DM_I = 0 AND v_DM_II = 0 AND v_LOB = 0 ) THEN
            v_RTA := 'Riesgo Alto' ;
    END IF;

    -----------------------------------
    IF ( v_Dx_HIPERTENSION = 'P.A. OPTIMA' OR v_Dx_HIPERTENSION = 'P.A. NORMAL'
        OR v_Dx_HIPERTENSION = 'P.A. NORMAL ALTA' ) AND ( ( v_FactoresRiesgo > 2 )
        OR v_DM_I = 1 OR v_DM_II = 1 OR v_LOB = 1 ) THEN
            v_RTA := 'Riesgo Alto' ;
    END IF;

    -----------------------------------
    IF v_Dx_HIPERTENSION = 'HIPERTENSIÓN ESTADIO 1' AND ( ( v_FactoresRiesgo > 2 )
        OR v_DM_I = 1 OR v_DM_II = 1 OR v_LOB = 1 ) THEN
            v_RTA := 'Riesgo Alto' ;
    END IF;

    -----------------------------------
    IF v_Dx_HIPERTENSION = 'HIPERTENSIÓN ESTADIO 2' AND ( ( v_FactoresRiesgo > 2 )
        OR v_DM_I = 1 OR v_DM_II = 1 OR v_LOB = 1 ) THEN
            v_RTA := 'Riesgo Alto' ;
    END IF;

    -----------------------------------
    IF v_Dx_HIPERTENSION = 'HIPERTENSIÓN ESTADIO 3' AND ( ( v_FactoresRiesgo > 0 )
        OR v_DM_I = 1 OR v_DM_II = 1 OR v_LOB = 1 ) THEN
            v_RTA := 'Riesgo Muy Alto' ;
    END IF;


    RETURN v_RTA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;