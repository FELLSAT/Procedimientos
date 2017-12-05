CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_PRESTADOR 
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT ENTIDAD ,
            NIT ,
            ID_TIPO_IDEN_ENTI ,
            CD_CODI_PSS_ENTI ,
            DE_DIRE_ENTI ,
            DE_TELE_ENTI ,
            NO_NOMB_REPR_ENTI ,
            CD_CODI_DPTO_ENTI ,
            CD_CODI_MUNI_ENTI ,
            TX_RUTAIMGPUB_ENTI ,
            NU_AUTO_ENTI 
        FROM ENTIDAD  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;