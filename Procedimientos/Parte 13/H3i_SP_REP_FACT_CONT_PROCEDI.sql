CREATE OR REPLACE PROCEDURE H3i_SP_REP_FACT_CONT_PROCEDI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_FECHA_INI IN DATE,
  v_FECHA_FIN IN DATE,
  v_PROCEDIMI IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT EPS.CD_NIT_EPS ,
            NU_NUME_FACO ,
            CASE NU_ESTA_FACO
                WHEN '1' THEN 
                    'ACTIVA'
                WHEN '0' THEN 
                    'ANULADO'
                WHEN '2' THEN 
                    'CERRADO'   
            END ESTADO  ,
            NO_NOMB_SER ,
            EPS ,
            CD_NOMB_CONV ,
            VL_TOTA_FACO ,
            VL_RECU_FACO ,
            ROUND((SUM(VL_UNID_MOVI)  - SUM(VL_COPA_MOVI) ), 0) VL_ADMIN  ,
            FE_FECH_FACO 
        FROM FACTURAS_CONTADO 
        INNER JOIN MOVI_CARGOS    
            ON NU_NUME_FACO = NU_NUME_FACO_MOVI
        INNER JOIN EPS        
            ON NO_NOMB_EPS = EPS
        INNER JOIN CONVENIOS    
            ON NU_NUME_CONV_MOVI = NU_NUME_CONV
        INNER JOIN LABORATORIO LABORATORIO   
            ON ( LABORATORIO.NU_NUME_MOVI_LABO = MOVI_CARGOS.NU_NUME_MOVI )
        INNER JOIN SERVICIOS SERVICIOS   
            ON ( SERVICIOS.CD_CODI_SER = LABORATORIO.CD_CODI_SER_LABO )
        WHERE  FE_FECH_FACO BETWEEN v_FECHA_INI AND v_FECHA_FIN
            AND CD_CODI_TISE_SER = v_PROCEDIMI
        GROUP BY NU_NUME_FACO,NU_ESTA_FACO,
            EPS,CD_NOMB_CONV,
            VL_TOTA_FACO,VL_RECU_FACO,
            FE_FECH_FACO,CD_NIT_EPS,
            NO_NOMB_SER ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;