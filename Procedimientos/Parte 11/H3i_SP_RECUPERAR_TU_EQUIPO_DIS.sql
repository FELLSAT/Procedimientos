CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_TU_EQUIPO_DIS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_INICIO IN DATE,
  v_FIN IN DATE,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_AUTO_TUEQ ,
             TX_CODI_EQUI_TUEQ ,
             FE_HOIN_TUEQ ,
             FE_HOFI_TUEQ ,
             ID_DISP_TUEQ ,
             TX_MOTINHA_TUEQ ,
             TX_CODI_EQUI_TUEQ ,
             TX_NOMB_EQUI 
        FROM TURNO_EQUIPO 
              INNER JOIN EQUIPO    ON TX_CODI_EQUI_TUEQ = TX_CODI_EQUI
       WHERE  FE_HOIN_TUEQ <= v_INICIO
                AND FE_HOFI_TUEQ >= v_FIN
                AND ID_DISP_TUEQ = '1'
                AND NU_AUTO_TUEQ NOT IN ( SELECT NU_AUTO_TUEQ_TEDI 
                                          FROM TURNO_EQUIPO_DISP 
                                           WHERE  FE_HOIN_TEDI <= v_INICIO
                                                    AND FE_HOFI_TEDI >= v_FIN )

                AND NU_AUTO_TUEQ NOT IN ( SELECT NU_AUTO_TUEQ_TEDI 
                                          FROM TURNO_EQUIPO_DISP 
                                           WHERE  FE_HOIN_TEDI >= v_INICIO
                                                    AND FE_HOFI_TEDI <= v_FIN )

        ORDER BY TX_NOMB_EQUI ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;