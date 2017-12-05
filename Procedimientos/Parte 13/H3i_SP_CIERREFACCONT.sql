CREATE OR REPLACE PROCEDURE H3i_SP_CIERREFACCONT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS

BEGIN

   	UPDATE FACTURAS_CONTADO
    SET NU_ESTA_FACO = '2'
    WHERE  NU_ESTA_FACO = '1';

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;