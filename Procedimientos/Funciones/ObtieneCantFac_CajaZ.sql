CREATE OR REPLACE FUNCTION ObtieneCantFac_CajaZ
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumZETA IN NUMBER,
    v_NumCaja IN VARCHAR2,
    v_Usuario IN VARCHAR2 DEFAULT NULL ,
    v_Estado IN NUMBER DEFAULT NULL 
)
RETURN NUMBER
AS
    v_CANTFACO NUMBER(10,0);
    v_CANTFACR NUMBER(10,0);

BEGIN
    IF v_Usuario IS NOT NULL THEN
    
        BEGIN
            SELECT COUNT(DISTINCT NU_NUME_FACO)  
            INTO v_CANTFACO
            FROM FACTURAS_CONTADO 
            WHERE  NU_ESTA_FACO = NVL(v_Estado, NU_ESTA_FACO)
                AND CAJERO = v_Usuario
                AND NU_NUME_ZETA_FACO = v_NumZeta
                AND NU_NUME_CAJA_FACO = v_NumCaja;  
            ----------------------------------------------------

            SELECT COUNT(DISTINCT NU_NUME_FAC)  
            INTO v_CANTFACR
            FROM FACTURAS 
            WHERE  NU_ESTA_FAC = NVL(v_Estado, NU_ESTA_FAC)
                AND CAJERO_FACT = v_Usuario
                AND NU_NUME_ZETA_FACT = v_NumZeta
                AND NU_NUME_CAJA_FACT = v_NumCaja;
   
        END;

    ELSE
   
        BEGIN
            SELECT COUNT(DISTINCT NU_NUME_FACO) 
            INTO v_CANTFACO
            FROM FACTURAS_CONTADO 
            WHERE  NU_ESTA_FACO = NVL(v_Estado, NU_ESTA_FACO)
                AND NU_NUME_ZETA_FACO = v_NumZeta
                AND NU_NUME_CAJA_FACO = v_NumCaja;
            ---------------------------------------------------

            SELECT COUNT(DISTINCT NU_NUME_FAC)  
            INTO v_CANTFACR
            FROM FACTURAS 
            WHERE  NU_ESTA_FAC = NVL(v_Estado, NU_ESTA_FAC)
                AND NU_NUME_ZETA_FACT = v_NumZeta
                AND NU_NUME_CAJA_FACT = v_NumCaja;
        END;
    END IF;

    RETURN v_CANTFACO + v_CANTFACR;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;