CREATE OR REPLACE FUNCTION FN_TALLE_TENDENCIA_AIEPI --FUNCIÓN PARA DETERMINAR TENDENCIA DE LA TALLA -> AIEPI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumHist IN VARCHAR2,
    v_TallaActual IN NUMBER
)
RETURN VARCHAR2
AS
    v_FECHANACE DATE;
    v_EDADMESES NUMBER(10,0);
    v_SEXO NUMBER(10,0);
    v_RTA VARCHAR2(255);

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
   
    SELECT (CASE 
                WHEN v_TallaActual < NU_NEG2SD_TAAI 
                    THEN 'Talla baja para la edad o retraso en talla'
                WHEN v_TallaActual >= NU_NEG2SD_TAAI AND v_TallaActual < NU_NEG1SD_TAAI 
                    THEN 'Riesgo de talla baja'
                WHEN v_TallaActual >= NU_NEG1SD_TAAI 
                    THEN 'Talla adecuada para la edad'   
            END)
    INTO v_RTA
    FROM TALLA_AIEPI 
    WHERE  NU_MESES_TAAI = v_EDADMESES
        AND NU_SEXO_TAAI = v_SEXO;

    RETURN v_RTA;

   ---- ANTES
   --IF @EDADMESES >= 24 
   --BEGIN
   -- SELECT  @RTA = 
   --       (CASE 
   --         WHEN @TallaActual < NU_NEG3SD_TAAI THEN 'Muy Bajo'
   --         WHEN @TallaActual >= NU_NEG3SD_TAAI AND @TallaActual < NU_NEG2SD_TAAI THEN 'Bajo'
   --         WHEN @TallaActual >= NU_NEG2SD_TAAI AND @TallaActual < NU_NEG1SD_TAAI THEN 'Riesgo'                   
   --         WHEN @TallaActual >= NU_NEG1SD_TAAI AND @TallaActual <= NU_1SD_TAAI THEN 'Adecuado'
   --         WHEN @TallaActual > NU_1SD_TAAI THEN 'Alto'
   --       END ) 
   -- FROM  TALLA_AIEPI
   -- WHERE NU_MESES_TAAI = @EDADMESES
   -- AND   NU_SEXO_TAAI = @SEXO  
   --END    
   --ELSE
   --BEGIN
   -- SELECT  @RTA = 
   --       (CASE 
   --         WHEN @TallaActual < NU_NEG3SD_LOAI THEN 'Muy Bajo'
   --         WHEN @TallaActual >= NU_NEG3SD_LOAI AND @TallaActual < NU_NEG2SD_LOAI THEN 'Bajo'
   --         WHEN @TallaActual >= NU_NEG2SD_LOAI AND @TallaActual < NU_NEG1SD_LOAI THEN 'Riesgo'                   
   --         WHEN @TallaActual >= NU_NEG1SD_LOAI AND @TallaActual <= NU_1SD_LOAI THEN 'Adecuado'
   --         WHEN @TallaActual > NU_1SD_LOAI THEN 'Alto'
   --       END ) 
   -- FROM  LONGITUD_AIEPI
   -- WHERE NU_MESES_LOAI = @EDADMESES
   -- AND   NU_SEXO_LOAI = @SEXO  
   --END
   ---- AHORA DE 0 A 5 AÑOS


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;