CREATE OR REPLACE FUNCTION FN_IMC_TENDENCIA_AIEPI
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
    SELECT (
        CASE 
            WHEN v_IMC_ACTUAL < NU_NEG3SD_IMAI 
                THEN 'Muy Bajo'
            WHEN v_IMC_ACTUAL >= NU_NEG3SD_IMAI AND v_IMC_ACTUAL < NU_NEG2SD_IMAI 
                THEN 'Bajo'
            WHEN v_IMC_ACTUAL >= NU_NEG1SD_IMAI AND v_IMC_ACTUAL <= NU_1SD_IMAI 
                THEN 'Adecuado'
            WHEN v_IMC_ACTUAL > NU_1SD_IMAI AND v_IMC_ACTUAL <= NU_2SD_IMAI 
                THEN 'Sobrepeso'
            WHEN v_IMC_ACTUAL > NU_2SD_IMAI 
                THEN 'Obesidad'   
        END) 
    INTO v_RTA
    fROM IMC_AIEPI 
    WHERE NU_MESES_IMAI = v_EDADMESES
        AND NU_SEXO_IMAI = v_SEXO;

    RETURN v_RTA;
    
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;