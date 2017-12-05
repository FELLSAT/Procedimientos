CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_DET_NPOSM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_AUTO_NOPM_DNOP IN NUMBER DEFAULT NULL ,
  v_NU_TIPO_DNOP IN NUMBER DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_AUTO_DNOP ,
             NU_AUTO_NOPM_DNOP ,
             NU_TIPO_DNOP ,
             TX_CODI_MED_DNOP ,
             TX_PRINCIP_DNOP ,
             TX_GRUPOT_DNOP ,
             TX_FORMA_DNOP ,
             NU_DIASTRAT_DNOP ,
             NU_DOSISD_DNOP ,
             NU_CANTMES_DNOP ,
             TX_VIAADM_DNOP ,
             TX_INVIMA_DNOP 
        FROM DET_NPOSM 
       WHERE  NU_AUTO_NOPM_DNOP = NVL(v_NU_AUTO_NOPM_DNOP, NU_AUTO_NOPM_DNOP)
                AND NU_TIPO_DNOP = NVL(v_NU_TIPO_DNOP, NU_TIPO_DNOP) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;