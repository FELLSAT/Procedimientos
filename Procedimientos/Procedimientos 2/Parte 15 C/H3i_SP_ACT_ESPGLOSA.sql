CREATE OR REPLACE PROCEDURE H3i_SP_ACT_ESPGLOSA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN NVARCHAR2,
  v_NOMBRE IN NVARCHAR2,
  v_ESTADO IN NUMBER
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE EXISTS( SELECT * 
                      FROM ESPECIFICO_GLOSA3i 
                      WHERE  TX_CODIGO_ESGL = v_CODIGO );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN

        BEGIN
            UPDATE ESPECIFICO_GLOSA3i
            SET TX_NOMBRE_ESGL = v_NOMBRE,
                NU_ESTADO_ESGL = v_ESTADO
            WHERE  TX_CODIGO_ESGL = v_CODIGO;
        END;

    ELSE

        BEGIN
            INSERT INTO ESPECIFICO_GLOSA3i( 
                TX_CODIGO_ESGL, TX_NOMBRE_ESGL, 
                NU_ESTADO_ESGL )
            VALUES( 
                v_CODIGO, v_NOMBRE, 
                v_ESTADO );
        END;

    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;