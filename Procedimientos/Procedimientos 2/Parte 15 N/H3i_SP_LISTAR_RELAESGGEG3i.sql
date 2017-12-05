CREATE OR REPLACE PROCEDURE H3i_SP_LISTAR_RELAESGGEG3i
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT TX_CODIGO_GEGL_REG ,
            TX_CODIGO_ESGL_REG ,
            ( ( SELECT TX_NOMBRE_GEGL 
                FROM GENERAL_GLOSA3i 
                WHERE  TX_CODIGO_GEGL = TX_CODIGO_GEGL_REG ) 
              || ', ' || 
              ( SELECT TX_NOMBRE_ESGL 
                FROM ESPECIFICO_GLOSA3i 
                WHERE  LTRIM(TX_CODIGO_ESGL) = LTRIM(TX_CODIGO_ESGL_REG) )) DESCMOTIVO  
        FROM R_ESG_GEG ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;