CREATE OR REPLACE PROCEDURE H3i_SP_EA_RECUPERAR_SEGS
 -- =============================================      
 -- Author:  FELIPE SATIZABALs
 -- =============================================
(
  v_EVENTO_ADVERSO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_NUME_EAS ,
             CD_EVENTO_ADVERSO_EAS ,
             FE_FECH_EAS ,
             TX_MEMO_EAS ,
             TX_RESP_EAS ,
             FE_FECH_SEGP_EAS 
        FROM EVENTO_ADVERSO_SEGUIMIENTO 
       WHERE  CD_EVENTO_ADVERSO_EAS = v_EVENTO_ADVERSO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;