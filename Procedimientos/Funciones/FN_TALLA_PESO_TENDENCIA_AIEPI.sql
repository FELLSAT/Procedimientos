CREATE OR REPLACE FUNCTION FN_TALLA_PESO_TENDENCIA_AIEPI --FUNCIÓN PARA DETERMINAR TENDENCIA DE TALLA VS PESO-> AIEPI
-- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumHist IN VARCHAR2,
    v_TALLA_ACTUAL IN NUMBER,
    v_PESO_ACTUAL IN NUMBER
)
RETURN NVARCHAR2
AS
    v_FECHANACE DATE;
    v_EDADMESES NUMBER(10,0);
    v_SEXO NUMBER(10,0);
    v_RTA VARCHAR2(30);

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

    IF v_EDADMESES <= 24 THEN
    
        BEGIN
            SELECT (
                CASE 
                    WHEN v_PESO_ACTUAL < NU_NEG3SD_TAPE 
                        THEN 'Peso muy bajo para la talla o Desnutrición Aguda Severa'
                    WHEN v_PESO_ACTUAL >= NU_NEG3SD_TAPE AND v_PESO_ACTUAL < NU_NEG2SD_TAPE 
                        THEN 'Peso bajo para la talla o Desnutrición Aguda'
                    WHEN v_PESO_ACTUAL >= NU_NEG2SD_TAPE AND v_PESO_ACTUAL < NU_NEG1SD_TAPE 
                        THEN 'Riesgo Peso Bajo para la talla'
                    WHEN v_PESO_ACTUAL >= NU_NEG1SD_TAPE AND v_PESO_ACTUAL <= NU_1SD_TAPE 
                        THEN 'Peso Adecuado para la talla'
                    WHEN v_PESO_ACTUAL > NU_1SD_TAPE AND v_PESO_ACTUAL <= NU_2SD_TAPE 
                        THEN 'Sobrepeso'
                    WHEN v_PESO_ACTUAL > NU_2SD_TAPE 
                        THEN 'Obesidad'
                    ELSE 'No definido'
                END) 
            INTO v_RTA
            FROM TALLA_PESO_0_2_AIEPI 
            WHERE  (NU_TALLA_TAPE - v_TALLA_ACTUAL) BETWEEN 0 AND 0.5
                AND NU_SEXO_TAPE = v_SEXO;
        END;
    ELSE
   
        BEGIN
            SELECT (
                CASE 
                    WHEN v_PESO_ACTUAL < NU_NEG3SD_TAPE 
                        THEN 'Peso muy bajo para la talla o Desnutrición Aguda Severa'
                    WHEN v_PESO_ACTUAL >= NU_NEG3SD_TAPE AND v_PESO_ACTUAL < NU_NEG2SD_TAPE 
                        THEN 'Peso bajo para la talla o Desnutrición Aguda'
                    WHEN v_PESO_ACTUAL >= NU_NEG2SD_TAPE AND v_PESO_ACTUAL < NU_NEG1SD_TAPE 
                        THEN 'Riesgo Peso Bajo para la talla'
                    WHEN v_PESO_ACTUAL >= NU_NEG1SD_TAPE AND v_PESO_ACTUAL <= NU_1SD_TAPE 
                        THEN 'Peso Adecuado para la talla'
                    WHEN v_PESO_ACTUAL > NU_1SD_TAPE AND v_PESO_ACTUAL <= NU_2SD_TAPE 
                        THEN 'Sobrepeso'
                    WHEN v_PESO_ACTUAL > NU_2SD_TAPE 
                        THEN 'Obesidad'
                    ELSE 'No definido'
                END) 
            INTO v_RTA
            FROM TALLA_PESO_AIEPI 
            WHERE  (NU_TALLA_TAPE - v_TALLA_ACTUAL) BETWEEN 0 AND 0.5
                AND NU_SEXO_TAPE = v_SEXO;
       
        END;
    END IF;


    RETURN v_RTA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;