CREATE OR REPLACE PROCEDURE H3i_SP_BUSCAR_ENTIDADES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NOMBRE IN VARCHAR2,
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
        FROM ENTIDAD 
       WHERE  ENTIDAD LIKE v_NOMBRE || '%' ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_BUSCAR_ENTIDADES;