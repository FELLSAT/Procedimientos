CREATE OR REPLACE PROCEDURE H3i_SP_VERIFICAR_CAMBIO_HICL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_HICL IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_NUME_HBH ,
             NU_NUME_HICL_HBH ,
             FE_FECH_HICL_HBH ,
             FE_FECH_HBH ,
             TX_JUS_HBH ,
             NU_SES_HBH 
        FROM HIST_BITACORA_HORA 
       WHERE  NU_NUME_HICL_HBH = v_HICL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;