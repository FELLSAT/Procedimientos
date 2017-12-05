CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_AMBITO_ATENCIO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumHistoria IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS
    v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 
        INTO v_temp
        FROM DUAL
        WHERE EXISTS( SELECT R.NU_TIAT_REG 
                      FROM PACIENTES P
                      INNER JOIN REGISTRO R   
                          ON P.NU_NUME_REG_PAC = R.NU_NUME_REG
                      WHERE  P.NU_HIST_PAC = v_NumHistoria );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN
    
        BEGIN
            OPEN  cv_1 FOR
                SELECT R.NU_TIAT_REG 
                FROM PACIENTES P
                INNER JOIN REGISTRO R   
                    ON P.NU_NUME_REG_PAC = R.NU_NUME_REG
                WHERE  P.NU_HIST_PAC = v_NumHistoria;   
        END;

    ELSE
   
        BEGIN
            OPEN  cv_1 FOR
                SELECT 0 NU_TIAT_REG  
                FROM DUAL;  
        END;
        
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;