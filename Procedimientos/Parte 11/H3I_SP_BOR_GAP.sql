CREATE OR REPLACE PROCEDURE H3I_SP_BOR_GAP --PROCEDIMIENTO ALMACENADO PARA BORRAR GRUPOS ACADEMICOS ASOCIADOS A ASIGNATURAS EN UN PERIODO ACADEMICO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_CODIGO_GRAP IN NUMBER,
  v_TX_CODIGO_ASIG_GRAP IN VARCHAR2,
  v_NU_AUTO_PEAC_GRAP IN NUMBER
)
AS

BEGIN

   -- Borramos relaciones de Medicos de reemplazo
  DELETE R_MEDI_REEMP_HOGR
  WHERE  NU_AUTO_GRAP_RMRH = v_NU_CODIGO_GRAP;
   -- Borramos relaciones de GrupoHorario
  DELETE HORARIO_GRUPO
  WHERE  NU_AUTO_GRAP_HOGR = v_NU_CODIGO_GRAP;

  DELETE GRUPO_ASIGNATURA_PERIODO
  WHERE  NU_CODIGO_GRAP = v_NU_CODIGO_GRAP
      AND TX_CODIGO_ASIG_GRAP = v_TX_CODIGO_ASIG_GRAP
      AND NU_AUTO_PEAC_GRAP = v_NU_AUTO_PEAC_GRAP;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;