CREATE OR REPLACE PROCEDURE H3i_SP_REGIS_FORMA_PAGO_CUOTA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NO_RECIBO NUMBER,
    V_MONTO NUMBER,
    V_FORMA_PAGO NUMBER,
    V_NO_CONEXION NUMBER
)	
AS

BEGIN
    INSERT INTO DETALLE_PAGO_ABONO(
        NU_NUME_ABRC_DPA,
        NU_NUME_FOPA_DPA,
        VL_VAL_MONTO,
        NU_CONE_DPA)
    VALUES(
        V_NO_RECIBO,
        V_FORMA_PAGO,
        V_MONTO,
        V_NO_CONEXION);


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
