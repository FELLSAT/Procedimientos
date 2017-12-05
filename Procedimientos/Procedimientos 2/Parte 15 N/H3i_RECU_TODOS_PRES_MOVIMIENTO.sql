CREATE OR REPLACE PROCEDURE H3i_RECU_TODOS_PRES_MOVIMIENTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_AUTO_PRES_MOV ,
            CD_CODI_MED_PM ,
            ID_ELEMENTO_PM ,
            CANTIDAD ,
            FEC_PRESTAMO ,
            FEC_DEVOLUCION ,
            ID_ESTADO_PM 
        FROM PRES_MOVIMIENTO 
        WHERE  FEC_DEVOLUCION IS NULL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;