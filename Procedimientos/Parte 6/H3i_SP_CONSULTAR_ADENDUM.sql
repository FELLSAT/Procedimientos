CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTAR_ADENDUM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_HICL IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_NUME_ADENDUM ,
             NU_NUME_HICL ,
             TX_DESCRIP_ADENDUM ,
             FE_FECH_CREACION ,
             BT_ESTADO_ADENDUM ,
             NU_PROG_ADENDUM 
        FROM HIST_ADENDUM 
       WHERE  NU_NUME_HICL = v_NU_NUME_HICL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;