CREATE OR REPLACE PROCEDURE H3I_SP_CONSULTA_ADMINISTRAEPS --Este procedimiento fue dividido de H3i_SP_CONSULTA_ADMINISTRADORAS_CONVENIO porque retornaba dos tablas como resultado, pero con la conexion de Oracle actual solo se puede retornar un resultado por procedimiento
-- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT EPS.CD_NIT_EPS ,
            EPS.CD_INDI_EPS ,
            EPS.NO_NOMB_EPS ,
            EPS.NO_DPTO_EPS ,
            EPS.NO_MUNI_EPS ,
            EPS.DE_DIRE_EPS ,
            EPS.DE_TELE_EPS ,
            EPS.DE_REPR_EPS ,
            EPS.NU_FATO_EPS ,
            EPS.NU_FADE_EPS ,
            EPS.NU_FAAT_EPS ,
            EPS.PR_FADE_EPS ,
            EPS.NU_COEL_EPS ,
            EPS.NU_COLA_EPS ,
            EPS.CD_CODI_EPS 
        FROM EPS EPS
        INNER JOIN CONVENIOS CON   
            ON CON.CD_NIT_EPS_CONV = EPS.CD_NIT_EPS
        GROUP BY EPS.CD_NIT_EPS,EPS.CD_INDI_EPS,
            EPS.NO_NOMB_EPS,EPS.NO_DPTO_EPS,
            EPS.NO_MUNI_EPS,EPS.DE_DIRE_EPS,
            EPS.DE_TELE_EPS,EPS.DE_REPR_EPS,
            EPS.NU_FATO_EPS,EPS.NU_FADE_EPS,
            EPS.NU_FAAT_EPS,EPS.PR_FADE_EPS,
            EPS.NU_COEL_EPS,EPS.NU_COLA_EPS,
            EPS.CD_CODI_EPS;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;