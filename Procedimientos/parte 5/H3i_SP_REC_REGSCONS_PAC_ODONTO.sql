CREATE OR REPLACE PROCEDURE H3i_SP_REC_REGSCONS_PAC_ODONTO -- PROCEDIMIENTO ALMACENADO PARA RECUPERACION DE REGISTROS CONSULTAS PACIENTE ODONTOGRAMA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
(
  v_CD_CONSULTA IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_REG_CONSULTA ,
             CD_LOG_CONS ,
             NU_DIENTE ,
             SUP_DIENTE ,
             TIPO_DIENTE ,
             ESTADO_DIENTE ,
             CD_ICDAS ,
             DE_ACTIV_ICDAS ,
             CD_MEJARE ,
             DEF_ODI ,
             DEF_ODE ,
             DEF_H ,
             LES_ABR ,
             LES_ABF ,
             LES_EROS ,
             LES_ATRI ,
             DEF_EXT 
        FROM HIST_ODONTO_REG_CONS 
       WHERE  CD_LOG_CONS = v_CD_CONSULTA
        ORDER BY CD_REG_CONSULTA ASC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;