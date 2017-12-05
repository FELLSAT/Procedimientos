CREATE OR REPLACE FUNCTION FN_PESO_DE_AIEPI
(
    v_NumHist IN VARCHAR2,
    iv_PesoActual IN NUMBER
)
RETURN VARCHAR2
AS
    v_PesoActual NUMBER(18,2) := iv_PesoActual;
    v_FECHANACE DATE;
    v_EDADMESES NUMBER(10,0);
    v_SEXO NUMBER(10,0);
    v_RTA VARCHAR2(60);

BEGIN
    SELECT FE_NACI_PAC ,
    NU_SEXO_PAC 
    INTO v_FECHANACE,
    v_SEXO
    FROM PACIENTES 
    WHERE  NU_HIST_PAC = v_NumHist;

    v_EDADMESES := TO_CHAR(SYSDATE,'MM') - TO_CHAR(v_FECHANACE,'MM');
    v_SEXO := CASE 
                  WHEN v_SEXO = 0 THEN 1
                  ELSE 2
              END ;
   
    v_PesoActual := v_PesoActual ;   
    SELECT (
        CASE 
            ---- ANTES
              ----WHEN @PesoActual <= NU_NEG3SD_PEAI THEN '-3'
              ----WHEN @PesoActual > NU_NEG3SD_PEAI AND @PesoActual <= NU_NEG2SD_PEAI THEN '-2'
              ----WHEN @PesoActual > NU_NEG2SD_PEAI AND @PesoActual <= NU_NEG1SD_PEAI THEN '-1'
              ----WHEN @PesoActual > NU_NEG1SD_PEAI AND @PesoActual <= NU_MEDIAN_PEAI THEN 'Medio'										
              ----WHEN @PesoActual > NU_MEDIAN_PEAI AND @PesoActual <= NU_1SD_PEAI THEN '1'
              ----WHEN @PesoActual > NU_1SD_PEAI AND @PesoActual <= NU_2SD_PEAI THEN '2'
              ----WHEN @PesoActual > NU_2SD_PEAI THEN '3'
            ---- AHORA					
            WHEN v_PesoActual < NU_NEG2SD_PEAI 
                THEN 'Peso muy bajo para la talla o Desnutrición Aguda severa'
            WHEN v_PesoActual >= NU_NEG2SD_PEAI AND v_PesoActual < NU_NEG1SD_PEAI 
                THEN 'Peso bajo para la talla o Desnutrición Aguda'
            WHEN v_PesoActual >= NU_NEG1SD_PEAI AND v_PesoActual < NU_MEDIAN_PEAI 
                THEN 'Riesgo de peso bajo para la talla'
            WHEN v_PesoActual >= NU_MEDIAN_PEAI AND v_PesoActual < NU_1SD_PEAI 
                THEN 'Peso adecuado para la talla'
            WHEN v_PesoActual >= NU_1SD_PEAI AND v_PesoActual < NU_2SD_PEAI 
                THEN 'Sobrepeso'
            WHEN v_PesoActual >= NU_2SD_PEAI AND v_PesoActual < NU_3SD_PEAI 
                THEN 'Sobrepeso'
            WHEN v_PesoActual >= NU_3SD_PEAI 
                THEN 'Obesidad'   
        END) 
    INTO v_RTA
    FROM PESO_AIEPI 
    WHERE  NU_MESES_PEAI = v_EDADMESES
    AND NU_SEXO_PEAI = v_SEXO;

    RETURN v_RTA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;