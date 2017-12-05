CREATE OR REPLACE PROCEDURE H3i_SP_BUSCADX --	PROCEDIMIENTO ALMACENADO QUE PERMITE BSCAR Dx
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CIE IN NUMBER DEFAULT 10 ,
  v_TIPOBUSQUEDA IN NUMBER DEFAULT 1 ,
  v_CRITERIO IN VARCHAR2 DEFAULT ' ' ,
  v_SEXO IN NUMBER DEFAULT 1 ,-- 1 HOMBRE,   2 MUJER   
  v_EDAD IN NUMBER DEFAULT 1 ,
  v_v_MAXREG IN NUMBER DEFAULT 50 ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT * 
      FROM( 
            SELECT CD_CODI_DIAG ,
                DE_DESC_DIAG ,
                TO_NUMBER(NU_NOTI_DIAG) NU_NOTI_DIAG,
                NU_EDIN_DIAG ,
                NU_EDFI_DIAG ,
                NU_APLI_DIAG ,
                CD_CODI_DIAG_REL 
            FROM DIAGNOSTICO 
            WHERE  NU_CIE_DIAG = v_CIE
                AND NU_APLI_DIAG IN ( 0,v_SEXO )
                AND CD_CODI_DIAG LIKE CASE v_TIPOBUSQUEDA
                                          WHEN 0 THEN 
                                              ('%' || v_CRITERIO || '%')
                                          ELSE 
                                              CD_CODI_DIAG
                                      END
                AND DE_DESC_DIAG LIKE CASE v_TIPOBUSQUEDA
                                          WHEN 1 THEN 
                                              ('%' || v_CRITERIO || '%')
                                          ELSE 
                                              DE_DESC_DIAG
                                      END
                AND v_EDAD BETWEEN NU_EDIN_DIAG AND NU_EDFI_DIAG
                AND ( NU_APLI_DIAG = 0
                OR NU_APLI_DIAG = v_SEXO )
            ORDER BY (
                      CASE v_TIPOBUSQUEDA
                          WHEN 0 THEN CD_CODI_DIAG
                          ELSE DE_DESC_DIAG
                      END
                    ))
      WHERE ROWNUM <= v_v_MAXREG ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;