CREATE OR REPLACE PROCEDURE H3i_SP_RESULTADOLABO_CON /*PROCEDIMIENTO ALMACENADO QUE PERMITE CONSULTAR LOS RESULTADOS DE LABORATORIO OBTENIDOS MEDIANTE INTERFACE PARA SER MOSTRADOS EN HC*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NUMPROCEDIMIENTO IN NUMBER ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_AUTO_RELA ,
             NU_NUME_HPRO_RELA ,
             FE_PROCESA_RELA ,
             FE_REGISTRA_RELA ,
             TX_SECCION_RELA ,
             TX_PARAMETRO_RELA ,
             TX_VALOR_RELA ,
             TX_RANGO_RELA ,
             TX_LABORATORIO_RELA ,
             TX_APPREPORTA_RELA 
        FROM RESULTADO_LABCLI 
       WHERE  NU_NUME_HPRO_RELA = v_NUMPROCEDIMIENTO ;

 EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;