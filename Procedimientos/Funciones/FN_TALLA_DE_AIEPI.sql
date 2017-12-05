CREATE OR REPLACE FUNCTION FN_TALLA_DE_AIEPI --	FUNCIÓN PARA DETERMINAR TALLA -> DESVIACIÓN ESTANDAR PARA LA EDAD DE AIEPI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumHist IN NVARCHAR2,
    v_TallaActual IN NUMBER
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
                  WHEN v_SEXO = 0 
                      THEN 1
                  ELSE 2
              END ;

    IF v_EDADMESES >= 24 THEN    
        BEGIN
            SELECT (
                 ---- ANTES
                 --(CASE 
                 --	WHEN @TallaActual <= NU_NEG3SD_TAAI THEN '-3'
                 --	WHEN @TallaActual > NU_NEG3SD_TAAI AND @TallaActual <= NU_NEG2SD_TAAI THEN '-2'
                 --	WHEN @TallaActual > NU_NEG2SD_TAAI AND @TallaActual <= NU_NEG1SD_TAAI THEN '-1'
                 --	WHEN @TallaActual > NU_NEG1SD_TAAI AND @TallaActual <= NU_M_TAAI THEN 'Medio'
                 --	WHEN @TallaActual > NU_M_TAAI AND @TallaActual <= NU_1SD_TAAI THEN '1'									
                 --	WHEN @TallaActual > NU_1SD_TAAI AND @TallaActual <= NU_2SD_TAAI THEN '2'
                 --	WHEN @TallaActual > NU_2SD_TAAI THEN '3'
                 --END ) 
                 ---- AHORA
                CASE 
                    WHEN v_TallaActual < NU_NEG2SD_TAAI 
                        THEN '-3'
                    WHEN v_TallaActual >= NU_NEG2SD_TAAI AND v_TallaActual < NU_NEG1SD_TAAI 
                        THEN '-2'
                    WHEN v_TallaActual >= NU_NEG1SD_TAAI AND v_TallaActual < NU_M_TAAI 
                        THEN '-1'
                    WHEN v_TallaActual >= NU_M_TAAI AND v_TallaActual < NU_1SD_TAAI 
                        THEN '0'
                    WHEN v_TallaActual >= NU_1SD_TAAI AND v_TallaActual < NU_2SD_TAAI 
                        THEN '1'
                    WHEN v_TallaActual >= NU_2SD_TAAI AND v_TallaActual < NU_3SD_TAAI 
                        THEN '2'
                    WHEN v_TallaActual >= NU_3SD_TAAI 
                        THEN '3'   
                END) 
            INTO v_RTA
            FROM TALLA_AIEPI 
            WHERE  NU_MESES_TAAI = v_EDADMESES
                AND NU_SEXO_TAAI = v_SEXO;       
       END;
    ELSE   
        BEGIN
            SELECT (
                CASE 
                    WHEN v_TallaActual <= NU_NEG3SD_LOAI 
                        THEN '-3'
                    WHEN v_TallaActual > NU_NEG3SD_LOAI AND v_TallaActual <= NU_NEG2SD_LOAI 
                        THEN '-2'
                    WHEN v_TallaActual > NU_NEG2SD_LOAI AND v_TallaActual <= NU_NEG1SD_LOAI 
                        THEN '-1'
                    WHEN v_TallaActual > NU_NEG1SD_LOAI AND v_TallaActual <= NU_M_LOAI 
                        THEN 'Medio'
                    WHEN v_TallaActual > NU_M_LOAI AND v_TallaActual <= NU_1SD_LOAI 
                        THEN '1'
                    WHEN v_TallaActual > NU_1SD_LOAI AND v_TallaActual <= NU_2SD_LOAI 
                        THEN '2'
                    WHEN v_TallaActual > NU_2SD_LOAI 
                        THEN '3'   
                END) 
            INTO v_RTA
            FROM LONGITUD_AIEPI 
            WHERE  NU_MESES_LOAI = v_EDADMESES
                AND NU_SEXO_LOAI = v_SEXO;   
      END;
   END IF;
   
   RETURN v_RTA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;