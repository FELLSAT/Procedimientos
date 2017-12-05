CREATE OR REPLACE PROCEDURE H3i_SP_CREAOCUPACION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN VARCHAR2,
  v_DESC IN VARCHAR2,
  v_ESTADO IN NUMBER,
  v_CODIGOALTER IN VARCHAR2
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE EXISTS ( SELECT CD_CODI_OCUP 
                       FROM OCUPACION 
                       WHERE  CD_CODI_OCUP = v_CODIGO );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN
    
      BEGIN
          UPDATE OCUPACION
          SET DE_DESC_OCUP = v_DESC,
             ESTADO = v_ESTADO,
             CD_CODI_ALTERNA = v_CODIGOALTER
          WHERE  CD_CODI_OCUP = v_CODIGO;
   
      END;

    ELSE
   
        BEGIN
            INSERT INTO OCUPACION
            VALUES ( v_CODIGO, v_DESC, v_ESTADO, v_CODIGOALTER );   
        END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;