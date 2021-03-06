CREATE OR REPLACE PROCEDURE H3i_SP_REC_CARACTERISTIC_PASS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CONC_CONT ,
             VL_VALO_CONT 
        FROM CONTROL 
       WHERE  CD_CONC_CONT IN ( 'USUARIO_PASS_MAYUSCULAS','USUARIO_PASS_MINUSCULAS','USUARIO_PASS_NUMEROS','USUARIO_PASS_CARACTER_ESPECIAL','USUARIO_PASS_LONGITUD_MINIMA','USUARIO_PASS_CADUCIDAD','NUM_MAX_INTENTOS_LOGIN','CLAVDEFA' )

        ORDER BY CD_CONC_CONT ;

EXCEPTION
  WHEN OTHERS 
      THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_REC_CARACTERISTIC_PASS;