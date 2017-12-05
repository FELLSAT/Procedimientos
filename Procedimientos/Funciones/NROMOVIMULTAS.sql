CREATE OR REPLACE FUNCTION NROMOVIMULTAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    -- Add the parameters for the function here
    v_NroMulta IN NUMBER
)
RETURN NUMBER
AS
    -- Declare the return variable here
    v_NroMovi NUMBER;

BEGIN
    -- Add the T-SQL statements to compute the return value here
    SELECT NU_NUME_MOVI_MULT 
    INTO v_NroMovi
    FROM MULTA 
    INNER JOIN ABONOS_MULTAS    
        ON NU_NUME_MULT = NU_NUME_MULT_ABN
    WHERE  ID_ABONOS_ABN = v_NroMulta;
   
    -- Return the result of the function
    RETURN v_NroMovi;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;