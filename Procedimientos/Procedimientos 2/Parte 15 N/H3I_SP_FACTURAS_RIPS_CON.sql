CREATE OR REPLACE PROCEDURE       H3I_SP_FACTURAS_RIPS_CON
(
  v_IDCONVENIO IN NUMBER,
  v_FECHAINICIAL IN DATE,
  v_FECHAFINAL IN DATE,
  v_TIPOFACO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   DELETE FROM tt_TMP;
   UTILS.IDENTITY_RESET('tt_TMP');
   
   INSERT INTO tt_TMP ( 
   	SELECT DISTINCT F.FAC ,
                    NU_NUME_CONV_MOVI ,
                    COUNT(DISTINCT NU_NUME_MOVI)  CANTIDADCARGOS  ,
                    F.FECHAFACTURA ,
                    UTILS.CONVERT_TO_NUMBER(1,1,0) ESTADO  ,
                    M.NU_NUME_MOVI 
   	  FROM MOVI_CARGOS M
             JOIN ( SELECT NU_NUME_FACO FAC  ,
                           FE_FECH_FACO FECHAFACTURA  
                    FROM FACTURAS_CONTADO 
                     WHERE  NU_NUME_FACO = CASE v_TIPOFACO
                                                          WHEN 0 THEN NU_NUME_FACO
                            ELSE -1
                               END
                    UNION ALL 
                    SELECT NU_NUME_FAC FAC  ,
                           FE_FECH_FAC 
                    FROM FACTURAS 
                     WHERE  NU_NUME_FAC = CASE v_TIPOFACO
                                                         WHEN 1 THEN NU_NUME_FAC
                            ELSE -1
                               END ) F   ON CASE v_TIPOFACO
                                                           WHEN 0 THEN NU_NUME_FACO_MOVI
           ELSE NU_NUME_FAC_MOVI
              END = F.FAC
   	 WHERE  NU_ESTA_MOVI <> 2
              AND M.NU_NUME_CONV_MOVI = v_IDCONVENIO
              AND FECHAFACTURA BETWEEN v_FECHAINICIAL AND v_FECHAFINAL
   	  GROUP BY NU_NUME_CONV_MOVI,F.FAC,F.FECHAFACTURA,NU_NUME_MOVI );
   MERGE INTO tt_TMP 
   USING (SELECT tt_TMP.ROWID row_id, 0
   FROM tt_TMP 
          JOIN LABORATORIO    ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
    WHERE ID_ESTA_ASIS_LABO = 0) src
   ON ( tt_TMP.ROWID = src.row_id )
   WHEN MATCHED THEN UPDATE SET ESTADO = 0;
   OPEN  cv_1 FOR
      SELECT DISTINCT FAC ,
                      CANTIDADCARGOS ,
                      FECHAFACTURA ,
                      ESTADO ,
                      v_TIPOFACO TIPOFACO  
        FROM tt_TMP  ;
   EXECUTE IMMEDIATE ' TRUNCATE TABLE tt_TMP ';

EXCEPTION WHEN OTHERS THEN utils.handleerror(SQLCODE,SQLERRM);
END;