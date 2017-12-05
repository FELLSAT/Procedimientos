CREATE OR REPLACE PROCEDURE H3i_SP_GUARDAR_NUEVO_CONCEPTO --PROCEDIMIENTO ALMACENADO QUE GUARDA UN NUEVO CONCEPTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_COHI IN VARCHAR2,
  v_TX_TITULO_COHI IN VARCHAR2,
  v_NU_TIPO_COHI IN NUMBER,
  v_TX_DATFIJO_COHI IN VARCHAR2 DEFAULT 'N' ,
  v_TX_DIAGNOS_COHI IN VARCHAR2 DEFAULT 'N' ,
  v_TX_TBLBASE_COHI IN VARCHAR2 DEFAULT ' ' ,
  v_TX_CODBASE_COHI IN VARCHAR2 DEFAULT ' ' ,
  v_TX_NOMBASE_COHI IN VARCHAR2 DEFAULT ' ' ,
  v_TX_TABLACT_COHI IN VARCHAR2 DEFAULT ' ' ,
  v_TX_CAMPACT_COHI IN VARCHAR2 DEFAULT ' ' ,
  v_TX_APLICTS_COHI IN VARCHAR2 DEFAULT 'T' ,
  v_TX_VERDATO_COHI IN VARCHAR2 DEFAULT 'S' ,
  v_TX_CONDBAS_COHI IN VARCHAR2 DEFAULT NULL ,
  v_TX_CONDACT_COHI IN VARCHAR2 DEFAULT NULL ,
  v_TX_GETCACT_COHI IN VARCHAR2 DEFAULT 'N' ,
  v_TX_EXPREG_COHI IN vARCHAR2 DEFAULT NULL ,
  v_TX_EXPREG_EJEM_COHI IN VARCHAR2 DEFAULT NULL ,
  v_NU_AUTOCOLUMNA_COHI IN NUMBER DEFAULT 0 ,
  v_NU_DXSOLOCOD_COHI IN NUMBER DEFAULT 0 
)
AS

BEGIN

   INSERT INTO CONCEPTO_HIST
     ( CD_CODI_COHI, TX_TITULO_COHI, NU_TIPO_COHI, TX_DATFIJO_COHI, TX_DIAGNOS_COHI, TX_TBLBASE_COHI, TX_CODBASE_COHI, TX_NOMBASE_COHI, TX_TABLACT_COHI, TX_CAMPACT_COHI, TX_APLICTS_COHI, TX_VERDATO_COHI, TX_CONDBAS_COHI, TX_CONDACT_COHI, TX_GETCACT_COHI, TX_EXPREG_COHI, TX_EXPREG_EJEM_COHI, NU_AUTOCOLUMNA_COHI, NU_DXSOLOCOD_COHI )
     VALUES ( v_CD_CODI_COHI, v_TX_TITULO_COHI, v_NU_TIPO_COHI, v_TX_DATFIJO_COHI, v_TX_DIAGNOS_COHI, v_TX_TBLBASE_COHI, v_TX_CODBASE_COHI, v_TX_NOMBASE_COHI, v_TX_TABLACT_COHI, v_TX_CAMPACT_COHI, v_TX_APLICTS_COHI, v_TX_VERDATO_COHI, v_TX_CONDBAS_COHI, v_TX_CONDACT_COHI, v_TX_GETCACT_COHI, v_TX_EXPREG_COHI, v_TX_EXPREG_EJEM_COHI, v_NU_AUTOCOLUMNA_COHI, v_NU_DXSOLOCOD_COHI );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;