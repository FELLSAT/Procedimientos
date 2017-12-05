CREATE OR REPLACE PROCEDURE H3i_SP_HIST_HIGIENEORAL_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    iv_NOHICL IN NUMBER,
    v_ORDEN IN NUMBER,
    v_NUMHISPAC IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS
   v_NOHICL NUMBER(10,0) := iv_NOHICL;

BEGIN

    IF ( v_NOHICL != 0 ) THEN
    
        BEGIN
            OPEN  cv_1 FOR
                SELECT NU_NUME_HICL_HIHI ,
                    NU_ORDEN_HIHI ,
                    NU_DIENTE_HIHI ,
                    NU_SUPERFICIE1_HIHI ,
                    NU_SUPERFICIE2_HIHI ,
                    NU_SUPERFICIE3_HIHI ,
                    NU_SUPERFICIE4_HIHI ,
                    NU_SUPERFICIE5_HIHI 
                FROM HIST_HIGIENE_ORAL 
                WHERE  NU_NUME_HICL_HIHI = v_NOHICL
                    AND NU_ORDEN_HIHI = v_ORDEN ;   
        END;

    ELSE
   
        BEGIN
            SELECT *
            INTO v_NOHICL
            FROM (  SELECT NU_NUME_HICL 
                    FROM HISTORIACLINICA 
                    INNER JOIN LABORATORIO    
                        ON NU_NUME_LABO = NU_NUME_LABO_HICL
                    INNER JOIN MOVI_CARGOS    
                        ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
                    INNER JOIN R_PLAN_CONC    
                        ON NU_NUME_PLHI_RPC = NU_NUME_PLHI_HICL
                    INNER JOIN CONCEPTO_HIST    
                        ON NU_NUME_COHI = NU_NUME_COHI_RPC
                        AND NU_TIPO_COHI = 81
                    WHERE  NU_ESTA_MOVI <> 2
                        AND NU_ESTA_LABO <> 2
                        AND NU_HIST_PAC_MOVI = v_NUMHISPAC
                    ORDER BY FE_FECH_HICL DESC )
            WHERE ROWNUM <= 1;


            OPEN  cv_1 FOR
                SELECT NU_NUME_HICL_HIHI ,
                    NU_ORDEN_HIHI ,
                    NU_DIENTE_HIHI ,
                    NU_SUPERFICIE1_HIHI ,
                    NU_SUPERFICIE2_HIHI ,
                    NU_SUPERFICIE3_HIHI ,
                    NU_SUPERFICIE4_HIHI ,
                    NU_SUPERFICIE5_HIHI 
                FROM HIST_HIGIENE_ORAL 
                WHERE  NU_NUME_HICL_HIHI = v_NOHICL ;   
        END;

    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;