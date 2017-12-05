CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_MED_REEMP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_MEDI_ASIG IN VARCHAR2,
  v_ID_GRUPO IN NUMBER,
  v_ID_HORARIO IN NUMBER,
  v_FECHA_REEMP IN DATE,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_MED ,
             NO_APEL1_MED ,
             NO_APEL2_MED ,
             NO_NOMB1_MED ,
             NO_NOMB2_MED ,
             NO_NOMB_MED ,
             NU_DOCU_MED ,
             DE_REGI_MED ,
             NU_DOCENTE_MEDI ,
             NU_TIPO_MEDI ,
             NU_TIPD_MED 
        FROM R_MEDI_REEMP_HOGR 
               JOIN MEDICOS    ON CD_CODI_MED = CD_CODI_MED_REEMP_RMRH
       WHERE  CD_CODI_MED_ASIG_RMRH = v_CD_MEDI_ASIG
                AND NU_AUTO_GRAP_RMRH = v_ID_GRUPO
                AND NU_AUTO_HOGR_RMRH = v_ID_HORARIO
                AND FE_FECH_REEMP_RMRH = v_FECHA_REEMP ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_MED_REEMP;