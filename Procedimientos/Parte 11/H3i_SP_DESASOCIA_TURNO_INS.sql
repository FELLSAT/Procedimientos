CREATE OR REPLACE PROCEDURE H3i_SP_DESASOCIA_TURNO_INS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TUMEPPAL IN NUMBER,
  v_TUMESECU IN NUMBER
)
AS

BEGIN

   DELETE ASOCIA_TURNO

    WHERE  NU_NUME_TUME_PPAL_ASTU = v_TUMEPPAL
             AND NU_NUME_TUME_SECU_ASTU = v_TUMESECU;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;