CREATE OR REPLACE FUNCTION FN_Dx_HIPERTENSION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_PASS IN NUMBER,
    v_PADS IN NUMBER,
    v_PASP IN NUMBER,
    v_PADP IN NUMBER,
    v_PASA IN NUMBER,
    v_PADA IN NUMBER
)
RETURN VARCHAR2
AS
    v_RTA VARCHAR2(4000);
    v_Promedio_PAS NUMBER(18,2);
    v_Promedio_PAD NUMBER(18,2);

BEGIN
    v_Promedio_PAS := (v_PASS + v_PASP + v_PASA) / 3 ;
    v_Promedio_PAD := (v_PADS + v_PADP + v_PADA) / 3 ;

    IF ( v_Promedio_PAS BETWEEN 0 AND 120 ) AND ( v_Promedio_PAD BETWEEN 0 AND 80 ) THEN
        v_RTA := 'P.A. OPTIMA' ;
    ELSE
        IF ( v_Promedio_PAS BETWEEN 121 AND 130 ) AND ( v_Promedio_PAD BETWEEN 81 AND 85 ) THEN
            v_RTA := 'P.A. NORMAL' ;
        ELSE
            IF ( v_Promedio_PAS BETWEEN 131 AND 139 ) AND ( v_Promedio_PAD BETWEEN 86 AND 89 ) THEN
                v_RTA := 'P.A. NORMAL ALTA' ;
            ELSE
                IF ( v_Promedio_PAS BETWEEN 140 AND 159 ) AND ( v_Promedio_PAD BETWEEN 90 AND 99 ) THEN
                    v_RTA := 'HIPERTENSIÓN ESTADIO 1' ;
                ELSE
                    IF ( v_Promedio_PAS BETWEEN 160 AND 179 ) AND ( v_Promedio_PAD BETWEEN 100 AND 109 ) THEN
                        v_RTA := 'HIPERTENSIÓN ESTADIO 2' ;
                    ELSE
                        IF ( v_Promedio_PAS BETWEEN 180 AND 209 ) AND ( v_Promedio_PAD BETWEEN 110 AND 119 ) THEN
                            v_RTA := 'HIPERTENSIÓN ESTADIO 3' ;
                        ELSE
                            v_RTA := 'NO DETERMINADA' ;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;

    RETURN v_RTA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;