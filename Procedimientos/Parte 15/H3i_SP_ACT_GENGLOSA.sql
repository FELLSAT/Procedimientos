CREATE OR REPLACE PROCEDURE H3i_SP_ACT_GENGLOSA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGO IN VARCHAR2,
    v_NOMBRE IN VARCHAR2,
    v_ESTADO IN NUMBER
)
AS
    v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE EXISTS( SELECT * 
                      FROM GENERAL_GLOSA3i 
                      WHERE  TX_CODIGO_GEGL = v_CODIGO );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN    
        BEGIN
            UPDATE GENERAL_GLOSA3i
            SET TX_NOMBRE_GEGL = v_NOMBRE,
                NU_ESTADO_GEGL = v_ESTADO
            WHERE  TX_CODIGO_GEGL = v_CODIGO;   
        END;
   ELSE
   
        BEGIN
            INSERT INTO GENERAL_GLOSA3i( 
                TX_CODIGO_GEGL, TX_NOMBRE_GEGL, NU_ESTADO_GEGL )
            VALUES( 
                v_CODIGO, v_NOMBRE, v_ESTADO );
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;