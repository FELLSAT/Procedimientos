CREATE OR REPLACE PROCEDURE H3i_SP_ACT_DETGLOSA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGO IN NUMBER DEFAULT 0 ,
    v_IDGLOSA IN NUMBER,
    v_FACTURA IN VARCHAR2,
    v_TIPOFACTURA IN NUMBER,
    v_GENERAL IN VARCHAR2,
    v_ESPECIFICO IN VARCHAR2,
    v_OBSERVACION IN VARCHAR2,
    v_MOVIMIENTO IN NUMBER DEFAULT 0 ,
    v_DETALLEMOVI IN NUMBER DEFAULT 0 ,
    v_VALOR IN NUMBER,
    v_VALORACEPTADO IN NUMBER,
    v_ULTIMO OUT NUMBER
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE EXISTS (  SELECT * 
                        FROM DETALLE_GLOSA3i 
                        WHERE  NU_AUTO_DEGL = v_CODIGO );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN

        BEGIN
            UPDATE DETALLE_GLOSA3i
            SET NU_AUTO_GLOS_DEGL = v_IDGLOSA,
                NU_NUME_FACU_DEGL = v_FACTURA,
                NU_TIPOFACU_DEGL = v_TIPOFACTURA,
                TX_CODIGO_GEGL_DEGL = v_GENERAL,
                TX_CODIGO_ESGL_DEGL = v_ESPECIFICO,
                TX_OBSERVACION_DEGL = v_OBSERVACION,
                NU_NUME_MOVI_DEGL = v_MOVIMIENTO,
                NU_IDDETALLEMOVI_DEGL = v_DETALLEMOVI,
                NU_VALOR_DEGL = v_VALOR,
                NU_VALORACEPTADO_DEGL = v_VALORACEPTADO
            WHERE  NU_AUTO_DEGL = v_CODIGO;
                v_ULTIMO := v_CODIGO ;
        END;

    ELSE
   
        BEGIN
            INSERT INTO DETALLE_GLOSA3i( 
                NU_AUTO_GLOS_DEGL, NU_NUME_FACU_DEGL, 
                NU_TIPOFACU_DEGL, TX_CODIGO_GEGL_DEGL, 
                TX_CODIGO_ESGL_DEGL, TX_OBSERVACION_DEGL, 
                NU_NUME_MOVI_DEGL, NU_IDDETALLEMOVI_DEGL, 
                NU_VALOR_DEGL, NU_VALORACEPTADO_DEGL )
            VALUES ( 
                v_IDGLOSA, v_FACTURA, 
                v_TIPOFACTURA, v_GENERAL, 
                v_ESPECIFICO, v_OBSERVACION, 
                v_MOVIMIENTO, v_DETALLEMOVI, 
                v_VALOR, v_VALORACEPTADO);

            SELECT NU_AUTO_DEGL 
            INTO v_ULTIMO 
            FROM DETALLE_GLOSA3i
            WHERE NU_AUTO_DEGL = (SELECT MAX(NU_AUTO_DEGL) FROM DETALLE_GLOSA3i);   
        END;
        
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;