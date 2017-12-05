CREATE OR REPLACE PROCEDURE H3i_SP_OBT_OBSERVA_PREDET_SERV
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_SER IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   -- SET NOCOUNT ON added to prevent extra result sets from
   -- interfering with SELECT statements.
   OPEN  cv_1 FOR
      SELECT CD_CODI_OBSER ,
             CD_CODI_SER ,
             TX_OBSERVACIONES 
        FROM SERVICIOS_OBSERVA_PREDE 
       WHERE  CD_CODI_SER = v_CD_CODI_SER ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;