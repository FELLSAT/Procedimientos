CREATE OR REPLACE PROCEDURE H3i_SP_DAT_FIJO_DISENIO_FORM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ID IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT TX_TBLBASE_COHI ,
             TX_CODBASE_COHI ,
             TX_NOMBASE_COHI ,
             TX_CONDBAS_COHI ,
             TX_TABLACT_COHI ,
             TX_CAMPACT_COHI ,
             TX_APLICTS_COHI ,
             TX_VERDATO_COHI ,
             TX_CONDACT_COHI ,
             TX_GETCACT_COHI ,
             NU_AUTOCOLUMNA_COHI ,
             NU_AUTOFILA_CONC 
        FROM CONCEPTO_HIST 
       WHERE  NU_NUME_COHI = v_ID ;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;