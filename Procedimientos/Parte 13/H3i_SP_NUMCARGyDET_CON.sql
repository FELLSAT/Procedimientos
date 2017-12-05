CREATE OR REPLACE PROCEDURE H3i_SP_NUMCARGyDET_CON --PROCEDIMIENTO ALMACENADO QUE PERMITE CONSULTAR LOS RESULTADOS DE LABORATORIO OBTENIDOS MEDIANTE INTERFACE PARA SER MOSTRADOS EN HC*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NUMCONEX IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS
    v_ULTIMO NUMBER;

BEGIN

    SELECT MAX(NU_NUME_MOVI)
    INTO v_ULTIMO
    FROM MOVI_CARGOS 
    WHERE  NU_NUME_CONE_MOVI = v_NUMCONEX;
    ---------------------------------------------------	
    OPEN  cv_1 FOR
          SELECT v_ULTIMO Numero  ,
              TO_NUMBER(0) TIPO  
          FROM DUAL 

        UNION ALL 

          SELECT NU_NUME_LABO ,
              1 TIPO  
          FROM LABORATORIO 
          WHERE  NU_NUME_MOVI_LABO = v_ULTIMO ;
          
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;