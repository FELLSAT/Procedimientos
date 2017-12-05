CREATE OR REPLACE FUNCTION FN_PESO_EDAD --FUNCIÓN PARA DETERMINAR TALLA PESO -> DESVIACIÓN ESTANDAR DE AIEPI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumHist IN VARCHAR2,
    v_PESO_ACTUAL IN NUMBER
)
RETURN VARCHAR2
AS
    v_FECHANACE DATE;
    v_EDADMESES NUMBER(10,0);
    v_SEXO NUMBER(10,0);
    v_RTA VARCHAR2(80);
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
   
    BEGIN
        SELECT(
            CASE 
                WHEN v_PESO_ACTUAL < a.DESNEG3 
                    THEN 'Desnutrición Global Severa'
                WHEN v_PESO_ACTUAL >= a.DESNEG3 AND v_PESO_ACTUAL < a.DESNEG2 
                    THEN 'Desnutrición Global'
                WHEN v_PESO_ACTUAL >= a.DESNEG2 AND v_PESO_ACTUAL < a.DESNEG1 
                    THEN 'Riesgo de peso bajo para la edad'
                WHEN v_PESO_ACTUAL >= a.DESNEG2 AND v_PESO_ACTUAL < a.DESNEG1 
                    THEN 'Peso adecuado para la edad'
                WHEN v_PESO_ACTUAL >= a.DESNEG1 AND v_PESO_ACTUAL < a.DESCERO 
                    THEN 'Peso adecuado para la edad'
                WHEN v_PESO_ACTUAL >= a.DESCERO AND v_PESO_ACTUAL < a.DESPOS1 
                    THEN 'Peso adecuado para la edad'
                WHEN v_PESO_ACTUAL >= a.DESPOS1 AND v_PESO_ACTUAL < a.DESPOS2 
                    THEN 'Peso adecuado para la edad'
                WHEN v_PESO_ACTUAL >= a.DESPOS2 AND v_PESO_ACTUAL < a.DESPOS3 
                    THEN 'Peso adecuado para la edad'
                WHEN v_PESO_ACTUAL >= a.DESPOS3 
                    THEN 'Peso adecuado para la edad'   
            END) 
        INTO v_RTA
        FROM GRA_CYD_PESO_EDAD_0A5 a
        WHERE  a.GENERO = v_SEXO
           AND a.meses = v_EDADMESES;   
    END;

    RETURN v_RTA;--return @SEXO

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;