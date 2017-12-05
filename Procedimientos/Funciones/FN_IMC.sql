CREATE OR REPLACE FUNCTION FN_IMC --FUNCIÓN PARA DETERMINAR TALLA PESO -> DESVIACIÓN ESTANDAR DE AIEPI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumHist IN VARCHAR2,
    v_IMC IN NUMBER
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
   
    BEGIN
        SELECT (
            CASE 
                WHEN v_IMC < a.DESNEG3 
                    THEN 'Muy Bajo'
                WHEN v_IMC >= a.DESNEG3 AND v_IMC < a.DESNEG2 
                    THEN 'Muy Bajo'
                WHEN v_IMC >= a.DESNEG2 AND v_IMC < a.DESNEG1 
                    THEN 'Bajo'
                WHEN v_IMC >= a.DESNEG1 AND v_IMC < a.DESCERO 
                    THEN 'adecuado'
                WHEN v_IMC >= a.DESCERO AND v_IMC < a.DESPOS1 
                    THEN 'adecuado'
                WHEN v_IMC >= a.DESPOS1 AND v_IMC < a.DESPOS2 
                    THEN 'sobrepeso'
                WHEN v_IMC >= a.DESPOS2 AND v_IMC < a.DESPOS3 
                    THEN 'Obesidad'
                WHEN v_IMC >= a.DESPOS3 
                    THEN 'Obesidad'   
            END) 
        INTO v_RTA
        FROM GRA_CYD_IMC a
        WHERE  a.GENERO = v_SEXO
            AND a.meses = v_EDADMESES;   
    END;

    RETURN v_RTA;--return @SEXO

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;