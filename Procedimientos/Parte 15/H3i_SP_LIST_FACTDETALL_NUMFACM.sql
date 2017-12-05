CREATE OR REPLACE PROCEDURE H3i_SP_LIST_FACTDETALL_NUMFACM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NUM_FACTURAM IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT fac.NU_NUME_FAC NUMFAC_M  ,
            fa.NU_NUME_FACO NUMFAC_DT  ,
            fa.VL_TOTA_FACO VALOR_DT  ,
            se.NO_NOMB_SER DESC_DT  ,
            M.NU_NUME_MOVI NUME_MOVI  
        FROM MOVI_CARGOS M
        INNER JOIN FACTURAS_CONTADO fa   
            ON fa.NU_NUME_FACO = M.NU_NUME_FACO_MOVI
        INNER JOIN LABORATORIO la   
            ON la.NU_NUME_MOVI_LABO = M.NU_NUME_MOVI
        INNER JOIN SERVICIOS se   
            ON la.CD_CODI_SER_LABO = se.CD_CODI_SER
        INNER JOIN FACTURAS fac   
            ON fac.NU_NUME_FAC = M.NU_NUME_FAC_MOVI ;-- where fac.NU_NUME_FAC = @factura_Grd
   -- SE COMENTO POR QUE LA DB DE PRUEBAS NO CUENTA CON REGISTROS PARA MOSTRAR

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;