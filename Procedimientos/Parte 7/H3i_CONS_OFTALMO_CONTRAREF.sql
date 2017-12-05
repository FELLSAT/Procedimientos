CREATE OR REPLACE PROCEDURE H3i_CONS_OFTALMO_CONTRAREF
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN NUMBER,
  v_TIPO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT OD_DESCRIBE ,
             OI_DESCRIBE 
        FROM CONTRAREF_OFTALMOSCOPIA CO
       WHERE  CO.CD_CONTRAREFERENCIA = v_CODIGO
                AND CO.TIPO_OF = v_TIPO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;