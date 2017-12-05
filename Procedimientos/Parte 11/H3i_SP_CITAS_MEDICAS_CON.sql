CREATE OR REPLACE PROCEDURE H3i_SP_CITAS_MEDICAS_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODMEDICO IN VARCHAR2,
  v_TIPOCITA IN NUMBER,
  v_FECHA_INICIO IN DATE,
  v_FECHA_FINAL IN DATE,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_DURA_CIT ,
             FE_HORA_CIT ,
             FE_FECH_CIT ,
             NO_NOMB_MED 
        FROM CITAS_MEDICAS 
              INNER JOIN MEDICOS    ON CD_CODI_MED_CIT = CD_CODI_MED
       WHERE  CD_CODI_MED_CIT = v_CODMEDICO
                AND NU_TIPO_CIT = v_TIPOCITA
                AND NU_ESTA_CIT IN ( 0,1 )

                AND FE_FECH_CIT >= v_FECHA_INICIO
                AND FE_FECH_CIT < v_FECHA_FINAL
        ORDER BY FE_FECH_CIT ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;