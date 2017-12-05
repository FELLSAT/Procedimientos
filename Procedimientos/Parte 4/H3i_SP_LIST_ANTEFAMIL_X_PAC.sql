CREATE OR REPLACE PROCEDURE H3i_SP_LIST_ANTEFAMIL_X_PAC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_HIS_PAC_PAF IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_NUME_PAF ,
             NU_HIST_PAC_PAF ,
             CD_CODI_PARE_PAF ,
             TX_DESC_PAF ,
             DE_DESC_PARE 
        FROM PAC_ANTE_FAMI 
               JOIN PARENTESCO    ON CD_CODI_PARE = CD_CODI_PARE_PAF
       WHERE  NU_HIST_PAC_PAF = v_NU_HIS_PAC_PAF ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;