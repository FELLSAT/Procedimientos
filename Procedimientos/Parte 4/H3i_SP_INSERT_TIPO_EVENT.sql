CREATE OR REPLACE PROCEDURE H3i_SP_INSERT_TIPO_EVENT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NOMBRE IN VARCHAR2,
  v_ESTADO IN NUMBER
)
AS

BEGIN

   INSERT INTO TIPO_EVENTO
     ( NOMBRE, ESTADO )
     VALUES ( v_NOMBRE, v_ESTADO );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;