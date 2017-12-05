CREATE OR REPLACE FUNCTION ObtieneMaxMinMul_CajaZ
(
    v_NumZETA IN NUMBER,
    v_NumCaja IN VARCHAR2,
    v_Operacion IN NUMBER
)
RETURN NUMBER
AS
    v_RTA NUMBER;
    v_MAXMIN_MULT NUMBER;

BEGIN
    IF v_Operacion = 1 THEN
    
        BEGIN
            SELECT MIN(ID_ABONOS_ABN)  
            INTO v_MAXMIN_MULT
            FROM ABONOS_MULTAS 
            WHERE  NU_NUME_CAJA_ABN = v_NumCaja
                AND NU_NUME_ZETA_ABN = v_NumZETA;

            v_RTA := v_MAXMIN_MULT ;

        END;
   END IF;

   IF v_Operacion = 2 THEN
    
        BEGIN
            SELECT MAX(ID_ABONOS_ABN)  
            INTO v_MAXMIN_MULT
            FROM ABONOS_MULTAS 
            WHERE  NU_NUME_CAJA_ABN = v_NumCaja
                AND NU_NUME_ZETA_ABN = v_NumZETA;
        
            v_RTA := v_MAXMIN_MULT ;
        END;

    END IF;
    
    RETURN v_Rta;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;