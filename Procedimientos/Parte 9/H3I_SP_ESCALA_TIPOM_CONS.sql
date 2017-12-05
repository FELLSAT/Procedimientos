CREATE OR REPLACE PROCEDURE H3I_SP_ESCALA_TIPOM_CONS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TIPOM IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   -- H3I_SP_ESCALA_TIPOM_CONS 0
   OPEN  cv_1 FOR
      SELECT NU_AUTO_ESMO CODIGO  ,
             TX_DESC_ESMO DESCRIPCION  
        FROM ESCALA_MOTRICIDAD 
       WHERE  NU_AUTO_ESMO = CASE 
                                  WHEN v_TIPOM = 0 THEN NU_AUTO_ESMO
              ELSE v_TIPOM
                 END ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;