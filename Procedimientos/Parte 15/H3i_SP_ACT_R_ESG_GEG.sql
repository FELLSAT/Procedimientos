CREATE OR REPLACE PROCEDURE H3i_SP_ACT_R_ESG_GEG
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGOGENERAL IN VARCHAR2,
    v_CODIGOESPECIF IN VARCHAR2,
    v_BORRAR IN NUMBER DEFAULT 0 
)
AS
    v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE NOT EXISTS (  SELECT * 
                            FROM R_ESG_GEG 
                            WHERE  TX_CODIGO_ESGL_REG = v_CODIGOESPECIF
                                AND TX_CODIGO_GEGL_REG = v_CODIGOGENERAL );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN    
        BEGIN
            INSERT INTO R_ESG_GEG( 
                TX_CODIGO_ESGL_REG, TX_CODIGO_GEGL_REG )
            VALUES ( 
                v_CODIGOESPECIF, v_CODIGOGENERAL );  
        END;
    ELSE
        IF v_BORRAR = 1 THEN
            DELETE R_ESG_GEG
            WHERE  TX_CODIGO_ESGL_REG = v_CODIGOESPECIF
                AND TX_CODIGO_GEGL_REG = v_CODIGOGENERAL;
        END IF;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;