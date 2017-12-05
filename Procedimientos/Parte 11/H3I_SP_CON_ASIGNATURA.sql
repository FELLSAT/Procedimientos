CREATE OR REPLACE PROCEDURE H3I_SP_CON_ASIGNATURA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TX_CODIGO_ASIG IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT TX_CODIGO_ASIG ,
             TX_NOMBRE_ASIG ,
             NU_ESTU_ASIG ,
             NU_MAXCUPOS_ASIG ,
             NU_ESTA_ASIG ,
             NU_CON_ESPECI ,
             CD_CODI_ESP ,
             NO_NOMB_ESP 
        FROM ASIGNATURA 
               LEFT JOIN ESPECIALIDADES    ON CD_CODI_ESPE_ASIG = CD_CODI_ESP
       WHERE  TX_CODIGO_ASIG = NVL(v_TX_CODIGO_ASIG, TX_CODIGO_ASIG)
        ORDER BY 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;