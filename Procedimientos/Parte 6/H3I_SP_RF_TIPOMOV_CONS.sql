CREATE OR REPLACE PROCEDURE H3I_SP_RF_TIPOMOV_CONS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NUHISTPAC IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_ESTADO NUMBER(10,0);

BEGIN

   SELECT D.TX_TIPOMOVI_DTAR 

     INTO v_ESTADO
     FROM RUTA_ARCHIVO_FISICO r
            inner JOIN DETALLE_ARCHIVO_FISICO D   ON R.NU_AUTO_RUAR = D.NU_AUTO_RUAR_DTAR
            AND D.TX_TIPOMOVI_DTAR IN ( 3,4 )

    WHERE  NU_HIST_PAC_RUAR = v_NUHISTPAC
             AND NU_AUTO_DTAR = ( SELECT MAX(NU_AUTO_DTAR)  
                                  FROM DETALLE_ARCHIVO_FISICO 
                                   WHERE  TX_TIPOMOVI_DTAR IN ( 3,4 )

                                            AND NU_HIST_PAC_RUAR = v_NUHISTPAC );
   OPEN  cv_1 FOR
      SELECT CASE v_ESTADO
                          WHEN 3 THEN '4'
                          WHEN 4 THEN '3'
             ELSE '2'
                END IDMOV  ,
             CASE v_ESTADO
                          WHEN 3 THEN 'DEBE SALIR'
                          WHEN 4 THEN 'DEBE ENTRAR'
             ELSE 'NO HAY'
                END 
        FROM DUAL  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;