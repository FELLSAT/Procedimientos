CREATE OR REPLACE PROCEDURE H3i_SP_ACT_ESTADOGLOSA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_ID IN NUMBER DEFAULT 0 ,
    v_Nombre IN VARCHAR2
)
AS

BEGIN

    IF v_id <> 0 THEN
    
        BEGIN
            UPDATE ESTADO_GLOSA3i
            SET TX_NOMBRE_ESGLO = v_Nombre
            WHERE  NU_AUTO_ESGLO = v_ID;
        END;

    ELSE

        BEGIN
            INSERT INTO ESTADO_GLOSA3i
            ( TX_NOMBRE_ESGLO )
            VALUES ( v_Nombre );
        END;
    
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;