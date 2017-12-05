CREATE OR REPLACE PROCEDURE H3i_SP_EDITAR_SCOP_OPCION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_SO IN NUMBER,
  v_NU_NUME_SV_SO IN NUMBER,
  v_TX_NOMB_SO IN VARCHAR2,
  v_NU_PUNT_SO IN NUMBER,
  v_ESTADO IN NUMBER
)
AS

BEGIN

   UPDATE SCOP_OPCION
      SET NU_NUME_SV_SO = v_NU_NUME_SV_SO,
          TX_NOMB_SO = v_TX_NOMB_SO,
          NU_PUNT_SO = v_NU_PUNT_SO,
          ESTADO = v_ESTADO
    WHERE  NU_NUME_SO = v_NU_NUME_SO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;