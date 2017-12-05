cREATE OR REPLACE PROCEDURE H3i_SP_INSER_PRES_ELEMENTOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ID_ELEMENTO IN NUMBER,
  v_DESCRIPCION IN VARCHAR2,
  v_ID_TIP_ELEMENTO IN NUMBER
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE ( SELECT COUNT(*)  
                FROM PRES_ELEMENTOS 
                WHERE  ID_ELEMENTO = v_ID_ELEMENTO ) = 1;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN

        BEGIN
            UPDATE PRES_ELEMENTOS
            SET DESCRIPCION = v_DESCRIPCION,
            ID_TIP_ELEMENTO = v_ID_TIP_ELEMENTO
            WHERE  ID_ELEMENTO = v_ID_ELEMENTO;
        END;
    ELSE
        INSERT INTO PRES_ELEMENTOS( 
              ID_ELEMENTO, DESCRIPCION, ID_TIP_ELEMENTO )
        VALUES( 
              v_ID_ELEMENTO, v_DESCRIPCION, v_ID_TIP_ELEMENTO );
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;