CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_EQUIPO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO_EQUIPO IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT TX_CODI_EQUI ,
             TX_NOMB_EQUI 
        FROM EQUIPO 
       WHERE  UPPER(TX_CODI_EQUI) = UPPER(v_CODIGO_EQUIPO) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;