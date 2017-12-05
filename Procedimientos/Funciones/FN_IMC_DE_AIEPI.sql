CREATE OR REPLACE FUNCTION FN_IMC_DE_AIEPI --	FUNCIÓN PARA DETERMINAR IMC -> DESVIACIÓN ESTANDAR PARA LA EDAD DE AIEPI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumHist IN VARCHAR2,
    v_IMC_ACTUAL IN NUMBER
)
RETURN VARCHAR2
AS
    v_FECHANACE DATE;
    v_EDADMESES NUMBER(10,0);
    v_SEXO NUMBER(10,0);
    v_RTA VARCHAR2(12);

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

    SELECT (
          ---- ANTES
            --(CASE 
            --	WHEN @IMC_ACTUAL <= NU_NEG3SD_IMAI THEN '-3'
            --	WHEN @IMC_ACTUAL > NU_NEG3SD_IMAI AND @IMC_ACTUAL <= NU_NEG2SD_IMAI THEN '-2'
            --	WHEN @IMC_ACTUAL > NU_NEG2SD_IMAI AND @IMC_ACTUAL <= NU_1SD_IMAI THEN '-1'
            --	WHEN @IMC_ACTUAL > NU_NEG1SD_IMAI AND @IMC_ACTUAL <= NU_M_IMAI THEN 'MEDIO'
            --	WHEN @IMC_ACTUAL > NU_M_IMAI AND @IMC_ACTUAL <= NU_1SD_IMAI THEN '1'
            --	WHEN @IMC_ACTUAL > NU_1SD_IMAI AND @IMC_ACTUAL <= NU_2SD_IMAI THEN '2'
            --	WHEN @IMC_ACTUAL >= NU_2SD_IMAI THEN '3'
            --END ) 
          ---- AHORA
        CASE 
            WHEN v_IMC_ACTUAL <= NU_NEG2SD_IMAI 
                THEN '-3'
            WHEN v_IMC_ACTUAL >= NU_NEG2SD_IMAI AND v_IMC_ACTUAL < NU_NEG1SD_IMAI 
                THEN '-2'
            WHEN v_IMC_ACTUAL >= NU_NEG1SD_IMAI AND v_IMC_ACTUAL < NU_M_IMAI 
                THEN '-1'
            WHEN v_IMC_ACTUAL >= NU_M_IMAI AND v_IMC_ACTUAL < NU_1SD_IMAI 
                THEN '0'
            WHEN v_IMC_ACTUAL >= NU_1SD_IMAI AND v_IMC_ACTUAL < NU_2SD_IMAI 
                THEN '1'
            WHEN v_IMC_ACTUAL >= NU_2SD_IMAI AND v_IMC_ACTUAL < NU_3SD_IMAI 
                THEN '2'
            WHEN v_IMC_ACTUAL >= NU_3SD_IMAI 
                THEN '3'   
        END) 

    INTO v_RTA
    FROM IMC_AIEPI 
    WHERE  NU_MESES_IMAI = v_EDADMESES
        AND NU_SEXO_IMAI = v_SEXO;

        
    RETURN v_RTA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;