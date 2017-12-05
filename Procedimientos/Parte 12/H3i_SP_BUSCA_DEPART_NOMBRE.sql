CREATE OR REPLACE PROCEDURE H3i_SP_BUSCA_DEPART_NOMBRE
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
        SELECT CD_CODI_DPTO ,
            NO_NOMB_DPTO ,
            NU_NUME_TF_DPTO ,
            NU_NUME_PD_DPTO ,
            NU_NUME_PAP_DPTO ,
            CD_CODI_PAIS_DPTO 
        FROM DEPARTAMENTOS 
        WHERE NO_NOMB_DPTO LIKE '%' || v_NOMBRE || '%' ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;