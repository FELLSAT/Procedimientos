CREATE OR REPLACE FUNCTION ObtieneCantMul_CajaZ
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumZETA IN NUMBER,
    v_NumCaja IN VARCHAR2,
    v_Usuario IN VARCHAR2 DEFAULT NULL ,
    v_Estado IN NUMBER
)
RETURN NUMBER
AS
   v_CANTMULT NUMBER(10,0);

BEGIN
   IF v_Usuario IS NOT NULL THEN
    
        BEGIN
            SELECT COUNT(DISTINCT ID_ABONOS_ABN)  
            INTO v_CANTMULT
            FROM ABONOS_MULTAS 
            WHERE  NU_ESTA_ABN = v_Estado
                AND CAJERO_ABN = v_Usuario
                AND NU_NUME_ZETA_ABN = v_NumZeta
                AND NU_NUME_CAJA_ABN = v_NumCaja;   
        END;

    ELSE
   
        BEGIN
            SELECT COUNT(DISTINCT ID_ABONOS_ABN)  
            INTO v_CANTMULT
            FROM ABONOS_MULTAS 
            WHERE  NU_ESTA_ABN = v_Estado
                AND NU_NUME_ZETA_ABN = v_NumZeta
                AND NU_NUME_CAJA_ABN = v_NumCaja;   
         END;

    END IF;
    RETURN v_CANTMULT;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;