CREATE OR REPLACE PROCEDURE H3i_SP_LIQUIDOS_ELIMINADOS_INS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NumCone IN NUMBER,
  v_Via IN VARCHAR2,
  v_Cantidad IN NUMBER,
  v_NumReg IN NUMBER,
  v_DeAdmin IN VARCHAR2,
  v_Unidades IN NUMBER,
  v_Observaciones IN VARCHAR2,
  v_Equivalencia IN VARCHAR2,
  v_FechaAdministra IN DATE
)
AS
   v_Fecha DATE;

BEGIN

    v_Fecha := SYSDATE ;
    INSERT INTO LIQ_ELIMINADOS( 
        FE_FECHA_LIQELI, DE_CANTIDAD_LIQELI, 
        DE_VIA_LIQELI, NU_NUME_REG, 
        NU_NUME_CONE, DE_ADMIN_LIQELI, 
        DE_OBSERV_LIQELI, NU_UNIDAD_LIQELI, 
        NU_EQ_MANUAL, FE_FECHA_ADMINISTRA)
     VALUES ( 
        TO_DATE(v_Fecha,'dd/mm/yyyy'), v_Cantidad, 
        v_Via, v_NumReg, 
        v_NumCone, v_DeAdmin, 
        v_Observaciones, v_Unidades, 
        v_Equivalencia, TO_DATE(v_FechaAdministra,'dd/mm/yyyy'));

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;