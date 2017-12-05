CREATE OR REPLACE FUNCTION COSTOPROMAL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_pFecha IN VARCHAR2,
    v_pArticulo IN VARCHAR2
)
RETURN FLOAT
AS
    v_Exist NUMBER(19,0);
    v_FechaIN VARCHAR2(10);
    v_CtIN NUMBER(19,0);
    v_CostUnIN FLOAT(53);
    v_CostoPromedio FLOAT(53);

    CURSOR IN_CURSOR IS 
        SELECT TO_CHAR(FE_FECH_ENTR,'DD/MM/YYYY') ,
            CT_CANT_ENAR ,
            VL_COUN_ENAR 
        FROM ENTRADA_ALMACEN 
        INNER JOIN R_ENTRA_ARTI    
            ON CD_CODI_ENTR = CD_ENTR_ENAR
        WHERE  FE_FECH_ENTR <= TO_DATE(v_pFecha,'DD/MM/YYYY')
            AND CD_ARTI_ENAR = v_pArticulo
        ORDER BY FE_FECH_ENTR;

BEGIN
    v_costopromedio := 0 ;

    OPEN IN_CURSOR;
    FETCH IN_CURSOR INTO v_FechaIN,v_CtIN,v_CostUnIN;

    WHILE (IN_CURSOR%FOUND) 
    LOOP 

        BEGIN
            SELECT ExistenciasDepAl(TO_CHAR(TO_DATE('12/12/1993','DD/MM/YYYY') - 1,'DD/MM/YYYY'), 'TODAS', v_pArticulo) 
            INTO v_Exist
            FROM DUAL;


            IF v_CostoPromedio = 0 THEN
                v_CostoPromedio := v_CostUnIN ;
            END IF;

            IF v_CostoPromedio > 0 THEN
                v_CostoPromedio := ((v_Exist * v_CostoPromedio) + (v_CtIN * v_CostUnIN)) / CASE 
                                                                                              WHEN (v_Exist + v_CtIN) = 0 THEN 1
                                                                                              ELSE (v_Exist + v_CtIN)
                                                                                            END ;
            END IF;

            FETCH IN_CURSOR INTO v_FechaIN,v_CtIN,v_CostUnIN;
        END;

    END LOOP;

    RETURN v_CostoPromedio;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;