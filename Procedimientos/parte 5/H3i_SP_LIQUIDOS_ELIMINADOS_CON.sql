CREATE OR REPLACE PROCEDURE H3i_SP_LIQUIDOS_ELIMINADOS_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NumReg IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT FE_FECHA_LIQELI ,
             TO_NUMBER(DE_CANTIDAD_LIQELI,10.0) AS DE_CANTIDAD_LIQELI  ,
             DE_VIA_LIQELI ,
             NU_NUME_REG ,
             NU_NUME_CONE ,
             DE_ADMIN_LIQELI ,
             DE_OBSERV_LIQELI ,
             NU_UNIDAD_LIQELI ,
             TX_ABREV_UDME ,
             NU_EQ_MILILIT ,
             NU_EQ_MANUAL ,
             FE_FECHA_ADMINISTRA 
        FROM LIQ_ELIMINADOS 
               LEFT JOIN UNIDADES_MEDIDA    ON LIQ_ELIMINADOS.NU_UNIDAD_LIQELI = UNIDADES_MEDIDA.NU_AUTO_UNME
       WHERE  NU_NUME_REG = v_NumReg
        ORDER BY FE_FECHA_LIQELI DESC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;