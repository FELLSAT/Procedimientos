CREATE OR REPLACE FUNCTION FN_TALLA_PESO_DE_AIEPI --FUNCIÓN PARA DETERMINAR TALLA PESO -> DESVIACIÓN ESTANDAR DE AIEPI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumHist IN VARCHAR2,
    v_Talla IN NUMBER,
    v_PESO_ACTUAL IN NUMBER
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
   ---- ANTES
   --IF @EDADMESES <=24 
   --BEGIN
   --	SELECT	@RTA = ( 
   --					CASE
   --						WHEN @PESO_ACTUAL <= NU_NEG3SD_TAPE THEN '-3'
   --						WHEN @PESO_ACTUAL > NU_NEG3SD_TAPE AND @PESO_ACTUAL <= NU_NEG2SD_TAPE THEN '-2'
   --						WHEN @PESO_ACTUAL > NU_NEG2SD_TAPE AND @PESO_ACTUAL <= NU_NEG1SD_TAPE THEN '-1'
   --						WHEN @PESO_ACTUAL > NU_NEG2SD_TAPE AND @PESO_ACTUAL <= NU_NEG1SD_TAPE THEN '-1'
   --						WHEN @PESO_ACTUAL > NU_1SD_TAPE AND @PESO_ACTUAL <= NU_M_TAPE THEN 'M'
   --						WHEN @PESO_ACTUAL > NU_M_TAPE AND @PESO_ACTUAL <= NU_1SD_TAPE THEN '1'
   --						WHEN @PESO_ACTUAL > NU_1SD_TAPE AND @PESO_ACTUAL <= NU_2SD_TAPE THEN '2'
   --						WHEN @PESO_ACTUAL > NU_2SD_TAPE THEN '3'
   --						ELSE 'No definido'
   --					END)
   --	FROM	TALLA_PESO_0_2_AIEPI
   --	WHERE	(NU_TALLA_TAPE - @Talla) between 0 and 0.5
   --	AND		NU_SEXO_TAPE = @SEXO
   --END
   --ELSE
   --BEGIN
   --	SELECT	@RTA = ( 
   --					CASE
   --						WHEN @PESO_ACTUAL <= NU_NEG3SD_TAPE THEN '-3'
   --						WHEN @PESO_ACTUAL > NU_NEG3SD_TAPE AND @PESO_ACTUAL <= NU_NEG2SD_TAPE THEN '-2'
   --						WHEN @PESO_ACTUAL > NU_NEG2SD_TAPE AND @PESO_ACTUAL <= NU_NEG1SD_TAPE THEN '-1'
   --						WHEN @PESO_ACTUAL > NU_NEG2SD_TAPE AND @PESO_ACTUAL <= NU_NEG1SD_TAPE THEN '-1'
   --						WHEN @PESO_ACTUAL > NU_1SD_TAPE AND @PESO_ACTUAL <= NU_M_TAPE THEN 'M'
   --						WHEN @PESO_ACTUAL > NU_M_TAPE AND @PESO_ACTUAL <= NU_1SD_TAPE THEN '1'
   --						WHEN @PESO_ACTUAL > NU_1SD_TAPE AND @PESO_ACTUAL <= NU_2SD_TAPE THEN '2'
   --						WHEN @PESO_ACTUAL > NU_2SD_TAPE THEN '3'
   --						ELSE 'No definido'
   --					END)
   --	FROM	TALLA_PESO_AIEPI
   --	WHERE	(NU_TALLA_TAPE - @Talla) between 0 and 0.5
   --	AND		NU_SEXO_TAPE = @SEXO
   --END
   ---- AHORA  DE 0  A 5 AÑOS
    IF v_EDADMESES <= 24 THEN
    
        BEGIN
            SELECT (
                CASE 
                    WHEN v_PESO_ACTUAL < NU_NEG2SD_TAPE 
                        THEN '-3'
                    WHEN v_PESO_ACTUAL >= NU_NEG2SD_TAPE AND v_PESO_ACTUAL < NU_NEG1SD_TAPE 
                        THEN '-2'
                    WHEN v_PESO_ACTUAL >= NU_NEG1SD_TAPE AND v_PESO_ACTUAL < NU_M_TAPE 
                        THEN '-1'
                    WHEN v_PESO_ACTUAL >= NU_M_TAPE AND v_PESO_ACTUAL < NU_1SD_TAPE 
                        THEN '0'
                    WHEN v_PESO_ACTUAL >= NU_1SD_TAPE AND v_PESO_ACTUAL < NU_2SD_TAPE 
                        THEN '1'
                    WHEN v_PESO_ACTUAL >= NU_2SD_TAPE AND v_PESO_ACTUAL < NU_3SD_TAPE 
                        THEN '2'
                    WHEN v_PESO_ACTUAL >= NU_3SD_TAPE 
                        THEN '3'   
                END)
            INTO v_RTA
            FROM TALLA_PESO_0_2_AIEPI 
            WHERE  (NU_TALLA_TAPE - v_Talla) BETWEEN 0 AND 0.5
                AND NU_SEXO_TAPE = v_SEXO;       
        END;
    ELSE
   
        BEGIN
            SELECT (
                CASE 
                    WHEN v_PESO_ACTUAL < NU_NEG2SD_TAPE 
                        THEN '-3'
                    WHEN v_PESO_ACTUAL >= NU_NEG2SD_TAPE AND v_PESO_ACTUAL < NU_NEG1SD_TAPE 
                        THEN '-2'
                    WHEN v_PESO_ACTUAL >= NU_NEG1SD_TAPE AND v_PESO_ACTUAL < NU_M_TAPE 
                        THEN '-1'
                    WHEN v_PESO_ACTUAL >= NU_M_TAPE AND v_PESO_ACTUAL < NU_1SD_TAPE 
                        THEN '0'
                    WHEN v_PESO_ACTUAL >= NU_1SD_TAPE AND v_PESO_ACTUAL < NU_2SD_TAPE 
                        THEN '1'
                    WHEN v_PESO_ACTUAL >= NU_2SD_TAPE AND v_PESO_ACTUAL < NU_3SD_TAPE 
                        THEN '2'
                    WHEN v_PESO_ACTUAL >= NU_3SD_TAPE 
                        THEN '3'   
                END)
            INTO v_RTA
            FROM TALLA_PESO_AIEPI 
            WHERE  (NU_TALLA_TAPE - v_Talla) BETWEEN 0 AND 0.5
                AND NU_SEXO_TAPE = v_SEXO;  
        END;
    END IF;

    
    RETURN v_RTA;--return @SEXO

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;