CREATE OR REPLACE PROCEDURE H3i_SP_INSER_PRES_TIP_ELEMENT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ID_TIP_ELEMENTO IN NUMBER,
  v_DESCRIPCION IN VARCHAR2,
  v_SE_DEVUELVE IN NUMBER
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE ( SELECT COUNT(*)  
                FROM PRES_TIP_ELEMENTO 
                WHERE  ID_TIP_ELEMENTO = v_ID_TIP_ELEMENTO ) = 1;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN

        BEGIN
            UPDATE PRES_TIP_ELEMENTO
            SET DESCRIPCION = v_DESCRIPCION,
                NU_SE_DEVUELVE = v_SE_DEVUELVE
            WHERE  ID_TIP_ELEMENTO = v_ID_TIP_ELEMENTO;
        END;

    ELSE
    
        BEGIN
            INSERT INTO PRES_TIP_ELEMENTO( 
                ID_TIP_ELEMENTO, DESCRIPCION, 
                NU_SE_DEVUELVE )
            VALUES ( 
                v_ID_TIP_ELEMENTO, v_DESCRIPCION, 
                v_SE_DEVUELVE );
        END;

    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;