CREATE OR REPLACE PROCEDURE H3i_SP_CREAR_ACT_GLOSA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGO IN NUMBER DEFAULT 0 ,
    v_RADICADION IN DATE DEFAULT 'GETDATE' ,
    v_GENERA IN DATE,
    v_IDRADICACION IN NVARCHAR2,
    v_NITEPS IN NVARCHAR2,
    v_CONEX IN NUMBER,
    v_ESTADO IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS
    v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 
        INTO v_temp
        FROM DUAL
        WHERE EXISTS( SELECT * 
                      FROM GLOSA3i 
                      WHERE  NU_AUTO_GLOS = v_CODIGO );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN

        BEGIN
            UPDATE GLOSA3i
            SET FE_RADICACION_GLOS = v_RADICADION,
                FE_GENERA_GLOS = v_GENERA,
                TX_RADICAEXT_GLOS = v_IDRADICACION,
                CD_NIT_EPS_GLOS = v_NITEPS,
                NU_NUME_CONEX_GLOS = v_CONEX,
                NU_AUTO_ESGL_GLOS = v_ESTADO
            WHERE  NU_AUTO_GLOS = v_CODIGO;


                OPEN  cv_1 FOR
                    SELECT v_CODIGO 
                    FROM DUAL  ;
        END;

    ELSE

        BEGIN
            INSERT INTO GLOSA3i( 
                FE_RADICACION_GLOS, FE_GENERA_GLOS, 
                TX_RADICAEXT_GLOS, CD_NIT_EPS_GLOS, 
                NU_NUME_CONEX_GLOS, NU_AUTO_ESGL_GLOS )
            VALUES ( 
                v_RADICADION, v_GENERA, 
                v_IDRADICACION, v_NITEPS, 
                v_CONEX, v_ESTADO );
            

            OPEN  cv_1 FOR
                SELECT NU_AUTO_GLOS 
                FROM GLOSA3i
                WHERE NU_AUTO_GLOS = (SELECT MAX(NU_AUTO_GLOS) FROM GLOSA3i);
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;