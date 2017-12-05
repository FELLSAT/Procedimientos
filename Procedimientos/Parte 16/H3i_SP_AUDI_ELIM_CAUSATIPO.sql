CREATE OR REPLACE PROCEDURE H3i_SP_AUDI_ELIM_CAUSATIPO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_COD_CAUSA_TIPO IN VARCHAR2
)
AS
    v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE ( SELECT COUNT(AUTO_SEGU_DOC_ITEM)  
                FROM AUDITAR_GLOSADO_SEGUIM_ITEMS 
                WHERE  COD_CAUSA_TIPO_AGSI = v_COD_CAUSA_TIPO ) = 0;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    IF v_temp = 1 THEN
        --SE TRATA DE UN NUEVO USUARIO  
        BEGIN
            DELETE AUDITAR_CAUSA_TIPOS
            WHERE  COD_CAUSA_TIPO = v_COD_CAUSA_TIPO;
        END;

    ELSE

        BEGIN
            RAISE_APPLICATION_ERROR( 0 , 'No se puede eliminar por existir registros' );
        END;
        
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;