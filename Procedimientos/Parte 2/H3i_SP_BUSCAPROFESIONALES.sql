CREATE OR REPLACE PROCEDURE H3i_SP_BUSCAPROFESIONALES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  iv_MaxReg IN NUMBER DEFAULT 0 ,
  v_Codigo IN VARCHAR2 DEFAULT NULL ,
  iv_Nombre IN VARCHAR2 DEFAULT NULL ,
  v_Especialidad IN VARCHAR2 DEFAULT NULL ,
  v_Usuario IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_MaxReg NUMBER(10,0) := iv_MaxReg;
   v_Nombre VARCHAR2(255) := iv_Nombre;

BEGIN

   IF v_MaxReg IS NULL THEN
    v_MaxReg := 0 ;
   END IF;
   IF v_NOMBRE = '*' THEN
    v_NOMBRE := ' ' ;
   END IF;
   OPEN  cv_1 FOR
      SELECT * 
        FROM ( SELECT CD_CODI_MED ,
                      NO_APEL1_MED ,
                      NO_APEL2_MED ,
                      NO_NOMB1_MED ,
                      NO_NOMB2_MED ,
                      M.NU_TIPD_MED ,
                      M.NU_DOCU_MED ,
                      M.DE_REGI_MED ,
                      NO_NOMB_MED ,
                      NU_DOCENTE_MEDI ,
                      NU_TIPO_MEDI ,
                      TX_CODIGO_MOCO_MEDI 
        FROM MEDICOS M
               JOIN R_MEDI_ESPE R   ON M.CD_CODI_MED = R.CD_CODI_MED_RMP
       WHERE  M.NU_ESTA_MED = 1
                AND R.NU_ESTADO_RMP = 1
                AND NVL(M.CD_CODI_MED, '-1') LIKE '%' || NVL(v_CODIGO, NVL(M.CD_CODI_MED, '-1')) || '%'
                AND NVL(M.NO_NOMB_MED, '-1') LIKE '%' || NVL(v_NOMBRE, NVL(M.NO_NOMB_MED, '-1')) || '%'
                AND NVL(R.CD_CODI_ESP_RMP, '-1') = NVL(v_Especialidad, NVL(R.CD_CODI_ESP_RMP, '-1'))
                AND R.CD_CODI_ESP_RMP IN ( SELECT CD_CODI_ESP 
                                           FROM R_USU_ESP 
                                            WHERE  ID_IDEN_USUA = v_Usuario )

        ORDER BY 2,
                 3,
                 4,
                 5 )
        WHERE ROWNUM <= CASE v_MaxReg
                                     WHEN 0 THEN 9999999
      ELSE v_MaxReg
         END ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_BUSCAPROFESIONALES;