CREATE OR REPLACE PROCEDURE H3i_SP_AUDI_CREA_CONCENTRACION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CD_COD_MACO IN VARCHAR2,
    v_DESCRIPCION_MACO IN VARCHAR2,
    v_ESTADO_MACO IN NUMBER
)
AS
    v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE EXISTS( SELECT DESCRIPCION_MACO 
                      FROM AUDI_CONCENTRACION 
                      WHERE  CD_COD_MACO = v_CD_COD_MACO );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN
    
        BEGIN
          UPDATE AUDI_CONCENTRACION
          SET DESCRIPCION_MACO = v_DESCRIPCION_MACO,
              ESTADO_MACO = v_ESTADO_MACO
          WHERE  CD_COD_MACO = v_CD_COD_MACO;
        END;

    ELSE

        BEGIN
            INSERT INTO AUDI_CONCENTRACION( 
                CD_COD_MACO, DESCRIPCION_MACO, ESTADO_MACO )
            VALUES ( 
                v_CD_COD_MACO, v_DESCRIPCION_MACO, v_ESTADO_MACO );
        END;

    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;