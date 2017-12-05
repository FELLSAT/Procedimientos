CREATE OR REPLACE FUNCTION FN_PESO_TENDENCIA_AIEPI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NumHist IN VARCHAR2,
  iv_PesoActual IN NUMBER
)
RETURN NVARCHAR2
AS
   v_PesoActual NUMBER(10) := iv_PesoActual;
   v_FECHANACE DATE;
   v_EDADMESES NUMBER(10,0);
   v_SEXO NUMBER(10,0);
   v_RTA NVARCHAR2(60);

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
    -- SET @PesoActual= @PesoActual/1000  -- SE DIVIDE POR 1000 YA QUE SE CAPTURA EN GRAMOS Y EN LA TABLA SE MANEJA COMO KILOGRAMOS
    v_PesoActual := v_PesoActual ;
    SELECT (
          ---- ANTES
          --(CASE 
            --	WHEN @PesoActual < NU_NEG3SD_PEAI THEN 'Muy Bajo'
            --	WHEN @PesoActual >= NU_NEG3SD_PEAI AND @PesoActual < NU_NEG2SD_PEAI THEN 'Bajo'
            --	WHEN @PesoActual >= NU_NEG2SD_PEAI AND @PesoActual < NU_NEG1SD_PEAI THEN 'Riesgo'										
            --	WHEN @PesoActual >= NU_NEG1SD_PEAI AND @PesoActual <= NU_1SD_PEAI THEN 'Adecuado'
            --	WHEN @PesoActual > NU_1SD_PEAI THEN 'Alto'
            --END )           
          ---- AHORA
        CASE 
            WHEN v_PesoActual < NU_NEG3SD_PEAI 
                THEN 'Peso muy bajo o desnutrición global severa'
            WHEN v_PesoActual >= NU_NEG3SD_PEAI AND v_PesoActual < NU_NEG2SD_PEAI 
                THEN 'Peso bajo para la edad o desnitrición global'
            WHEN v_PesoActual >= NU_NEG2SD_PEAI AND v_PesoActual < NU_NEG1SD_PEAI 
                THEN 'Riesgo de peso bajo para la edad'
            WHEN v_PesoActual >= NU_NEG1SD_PEAI AND v_PesoActual <= NU_1SD_PEAI 
                THEN 'Peso adecuado para la edad'            
            WHEN v_PesoActual > NU_1SD_PEAI 
                THEN 'Alto'   END) 
            INTO v_RTA
            FROM PESO_AIEPI 
            WHERE  NU_MESES_PEAI = v_EDADMESES
                AND NU_SEXO_PEAI = v_SEXO;

    RETURN v_RTA;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;