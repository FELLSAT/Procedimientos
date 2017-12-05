CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_OPCIONES /*PROCEDIMIENTO ALMACENADO QUE PERMITE CONSULTAR LAS OPCIONES DE SEGURIDAD*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODOPCION IN NVARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_OPCI ,
             DE_DESC_OPCI ,
             CASE CD_CODI_PADR_OPCI
                                   WHEN 'CNT' THEN '0'
             ELSE CD_CODI_PADR_OPCI
                END CD_CODI_PADR_OPCI  
        FROM OPCIONES 
       WHERE  CD_CODI_OPCI = NVL(v_CODOPCION, CD_CODI_OPCI)
        ORDER BY CD_CODI_OPCI,
                 CD_CODI_PADR_OPCI ;

EXCEPTION
  WHEN OTHERS 
      THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_OPCIONES;