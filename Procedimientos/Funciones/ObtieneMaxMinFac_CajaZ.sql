CREATE OR REPLACE FUNCTION ObtieneMaxMinFac_CajaZ
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumZETA IN NUMBER,
    v_NumCaja IN VARCHAR2,
    v_Operacion IN NUMBER
)
RETURN NUMBER
AS
    v_RTA NUMBER;
    v_MAXMIN_FACO NUMBER;
    v_MAXMIN_FACT NUMBER;

BEGIN
    IF v_Operacion = 1 THEN

        BEGIN
            SELECT MIN(NU_CONSE_FACCAJA_FACO) 
            INTO v_MAXMIN_FACO
            FROM FACTURAS_CONTADO 
            WHERE  NU_NUME_CAJA_FACO = v_NumCaja
            AND NU_NUME_ZETA_FACO = v_NumZETA;

            SELECT MIN(NU_CONSE_FACCAJA_FACT)  
            INTO v_MAXMIN_FACT
            FROM FACTURAS 
            WHERE  NU_NUME_CAJA_FACT = v_NumCaja
            AND NU_NUME_ZETA_FACT = v_NumZETA;

            IF v_MAXMIN_FACO <= v_MAXMIN_FACT THEN
                v_RTA := v_MAXMIN_FACO ;
            ELSE
                v_RTA := v_MAXMIN_FACT ;
            END IF;
       
        END;
  
    END IF;


    IF v_Operacion = 2 THEN
    
        BEGIN
            SELECT MAX(NU_CONSE_FACCAJA_FACO)  
            INTO v_MAXMIN_FACO
            FROM FACTURAS_CONTADO 
            WHERE  NU_NUME_CAJA_FACO = v_NumCaja
            AND NU_NUME_ZETA_FACO = v_NumZETA;


            SELECT MAX(NU_CONSE_FACCAJA_FACT)  
            INTO v_MAXMIN_FACT
            FROM FACTURAS 
            WHERE  NU_NUME_CAJA_FACT = v_NumCaja
            AND NU_NUME_ZETA_FACT = v_NumZETA;

            IF v_MAXMIN_FACO >= v_MAXMIN_FACT THEN
                v_RTA := v_MAXMIN_FACO ;
            ELSE
                v_RTA := v_MAXMIN_FACT ;
            END IF;   
        END;
    END IF;

    
    RETURN v_Rta;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;