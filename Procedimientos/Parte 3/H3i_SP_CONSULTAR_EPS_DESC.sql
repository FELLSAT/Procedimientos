CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTAR_EPS_DESC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NO_NOMB_EPS IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_NIT_EPS ,
             CD_INDI_EPS ,
             NO_NOMB_EPS ,
             NO_DPTO_EPS ,
             NO_MUNI_EPS ,
             DE_DIRE_EPS ,
             DE_TELE_EPS ,
             DE_REPR_EPS ,
             NU_FATO_EPS ,
             NU_FADE_EPS ,
             NU_FAAT_EPS ,
             PR_FADE_EPS ,
             NU_COEL_EPS ,
             NU_COLA_EPS ,
             CD_CODI_EPS ,
             NU_COEL_U_EPS ,
             NU_COEL_H_EPS ,
             NU_COLA_U_EPS ,
             NU_COLA_H_EPS 
        FROM EPS 
       WHERE  NO_NOMB_EPS LIKE (v_NO_NOMB_EPS || '%') AND ROWNUM <= 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTAR_EPS_DESC;