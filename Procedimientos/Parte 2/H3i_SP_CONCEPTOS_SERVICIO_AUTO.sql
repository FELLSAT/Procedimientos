CREATE OR REPLACE PROCEDURE H3i_SP_CONCEPTOS_SERVICIO_AUTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NOMBRE IN VARCHAR2,
  v_TIPOBUSQUEDA IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   IF ( v_TIPOBUSQUEDA = 0 ) THEN
    
   BEGIN
      OPEN  cv_1 FOR
         SELECT CD_CODI_COSE CODIGO  ,
                NO_NOMB_COSE NOMBRE  ,
                ID_CLAS_COSE 
           FROM CONCEPTOS_SERV 
          WHERE  NO_NOMB_COSE LIKE '%' || v_NOMBRE || '%' ;
   
   END;
   ELSE
      IF ( v_TIPOBUSQUEDA = 1 ) THEN
       
      BEGIN
         OPEN  cv_1 FOR
            SELECT CD_CODI_COSE CODIGO  ,
                   NO_NOMB_COSE NOMBRE  ,
                   ID_CLAS_COSE 
              FROM CONCEPTOS_SERV 
             WHERE  CD_CODI_COSE = v_NOMBRE ;
      
      END;
      END IF;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONCEPTOS_SERVICIO_AUTO;