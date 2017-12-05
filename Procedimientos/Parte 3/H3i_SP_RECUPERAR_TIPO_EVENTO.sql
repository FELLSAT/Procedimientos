CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_TIPO_EVENTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_TIPO_EVENTO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT DISTINCT TE.CD_TIPO_EVENTO ,
                      TE.NOM_EVENTO ,
                      TE.NUM_SECUENCIA ,
                      CASE 
                           WHEN TE.NUM_SECUENCIA_PADRE IS NULL THEN 0
                      ELSE TE.NUM_SECUENCIA_PADRE
                         END NUM_SECUENCIA_PADRE  
        FROM TIPO_EVENTO_ADVERSO TE
               LEFT JOIN TIPO_EVENTO_ADVERSO CE   ON TE.NUM_SECUENCIA_PADRE = CE.NUM_SECUENCIA
       WHERE  TE.CD_TIPO_EVENTO = v_CD_TIPO_EVENTO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_RECUPERAR_TIPO_EVENTO;