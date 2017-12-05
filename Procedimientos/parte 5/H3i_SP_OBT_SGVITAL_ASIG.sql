CREATE OR REPLACE PROCEDURE H3i_SP_OBT_SGVITAL_ASIG
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_REG IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT FE_FECHA_SIGVI ,
             DE_SIGNO_SIGVI ,
             DE_VALOR_SIGVI 
        FROM SIGNOS_VITALES 
       WHERE  NU_NUME_REG = v_NU_NUME_REG ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;