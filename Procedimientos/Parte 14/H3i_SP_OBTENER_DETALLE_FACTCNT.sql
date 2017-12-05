CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_DETALLE_FACTCNT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT MOVI_CARGOS.NU_NUME_MOVI Codigo  ,
            SERVICIOS.NO_NOMB_SER Descripcion  ,
            FACTURAS_CONTADO.NU_CONS_MOVI_FACO Cantidad  ,
            MOVI_CARGOS.VL_UNID_MOVI vunitario  ,
            FACTURAS_CONTADO.VL_TOTA_FACO vtotal  ,
            MOVI_CARGOS.VL_COPA_MOVI vcopago  
        FROM PACIENTES PACIENTES
        CROSS JOIN ((LABORATORIO LABORATORIO
            INNER JOIN MOVI_CARGOS MOVI_CARGOS   
                ON (LABORATORIO.NU_NUME_MOVI_LABO = MOVI_CARGOS.NU_NUME_MOVI)) 
            INNER JOIN FACTURAS_CONTADO FACTURAS_CONTADO   
              ON ( MOVI_CARGOS.NU_NUME_FACO_MOVI = FACTURAS_CONTADO.NU_NUME_FACO)) 
        INNER JOIN SERVICIOS SERVICIOS   
            ON ( SERVICIOS.CD_CODI_SER = LABORATORIO.CD_CODI_SER_LABO )
        WHERE  MOVI_CARGOS.NU_NUME_MOVI = v_CODIGO
        GROUP BY MOVI_CARGOS.NU_NUME_MOVI,SERVICIOS.NO_NOMB_SER,
            FACTURAS_CONTADO.NU_CONS_MOVI_FACO,MOVI_CARGOS.VL_UNID_MOVI,
            FACTURAS_CONTADO.VL_TOTA_FACO,MOVI_CARGOS.VL_COPA_MOVI ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;