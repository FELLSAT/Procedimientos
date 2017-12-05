CREATE OR REPLACE PROCEDURE H3i_SP_LISTAR_BITACORA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_REC IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_NUME_REG_BIREG ,
            FECHA_HORA_BIREG ,
            TXT_NOTA_BIREG ,
            NU_NUME_CONE_BIREG 
        FROM BITACORA_REGISTRO 
        WHERE  NU_NUME_REG_BIREG = v_NU_NUME_REC
        ORDER BY FECHA_HORA_BIREG DESC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;