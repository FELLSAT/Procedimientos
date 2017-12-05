CREATE OR REPLACE PROCEDURE H3i_SP_INSER_PRES_ESTADOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_ID_ESTADO IN NUMBER,
    v_DES_ESTADO IN VARCHAR2
)
AS
    v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN

        SELECT 1 
        INTO v_temp
        FROM DUAL
        WHERE ( ( SELECT COUNT(*)  
                  FROM PRES_ESTADOS 
                  WHERE  ID_ESTADO = v_ID_ESTADO ) = 1 );

    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    IF v_temp = 1 THEN

        BEGIN

            UPDATE PRES_ESTADOS
            SET DES_ESTADO = v_DES_ESTADO
            WHERE  ID_ESTADO = v_ID_ESTADO;

        END;
    ELSE
        
        BEGIN

            INSERT INTO PRES_ESTADOS( 
                ID_ESTADO, DES_ESTADO )
            VALUES( 
                v_ID_ESTADO, v_DES_ESTADO );

        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;