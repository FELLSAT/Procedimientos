CREATE OR REPLACE PROCEDURE H3i_SP_CONS_GRUPS_DOC_ESP_RANG
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_MED_DOC_GEDE IN VARCHAR2,
  v_CD_CODI_ESP_RMP IN VARCHAR2,
  v_FECHA_INICIO_GEDE IN DATE,
  v_FECHA_FINAL_GEDE IN DATE,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_GRUP_EST_DOC_ESP ,
             CD_CODI_MED_DOC_GEDE ,
             CD_CODI_ESP_DOC_GEDE ,
             FECHA_INICIO_GEDE ,
             FECHA_FINAL_GEDE 
        FROM GRUPOS_ESTS_POR_DOC_ESP 
       WHERE  CD_CODI_MED_DOC_GEDE = v_CD_CODI_MED_DOC_GEDE
                AND CD_CODI_ESP_DOC_GEDE = v_CD_CODI_ESP_RMP
                AND ( FECHA_INICIO_GEDE BETWEEN v_FECHA_INICIO_GEDE AND v_FECHA_FINAL_GEDE )
                AND ( FECHA_FINAL_GEDE BETWEEN v_FECHA_INICIO_GEDE AND v_FECHA_FINAL_GEDE ) ;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONS_GRUPS_DOC_ESP_RANG;