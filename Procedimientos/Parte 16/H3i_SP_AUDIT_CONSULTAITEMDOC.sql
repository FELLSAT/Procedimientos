CREATE OR REPLACE PROCEDURE H3i_SP_AUDIT_CONSULTAITEMDOC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	  v_CODITIPODOC IN VARCHAR2,
	  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   	OPEN  cv_1 FOR
      	SELECT CD_CODI_ATDI ,
			CD_CODI_ATD_ATDI ,
			DE_DESC_ATDI ,
			ES_GLOSADO_COMPLETO 
        FROM AUDITAR_TIPO_DOCU_ITEM 
       	WHERE  CD_CODI_ATD_ATDI = v_CODITIPODOC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;