CREATE OR REPLACE PROCEDURE H3i_SP_ULTIMAATEN_ODO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NUMPLHI IN NUMBER,
  v_NoHistoriaPaciente IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_ES_EVOLUCION NUMBER(1,0);

BEGIN

   SELECT NU_ESODOEVO_PLHI 

     INTO v_ES_EVOLUCION
     FROM PLANTILLA_HIST 
    WHERE  NU_NUME_PLHI = v_NUMPLHI;


   IF v_ES_EVOLUCION = 1 THEN
    
   BEGIN
      OPEN  cv_1 FOR
         SELECT * 
           FROM ( SELECT FE_FECH_HICL ,
                         NU_NUME_HICL ,
                         NU_INDI_RPC 
           FROM CONCEPTO_HIST CH
                  INNER JOIN R_PLAN_CONC RPC   ON CH.NU_NUME_COHI = RPC.NU_NUME_COHI_RPC
                  INNER JOIN HISTORIACLINICA HC   ON HC.NU_NUME_PLHI_HICL = RPC.NU_NUME_PLHI_RPC
                  INNER JOIN LABORATORIO L   ON L.NU_NUME_LABO = HC.NU_NUME_LABO_HICL
                  INNER JOIN MOVI_CARGOS M   ON ( M.NU_NUME_MOVI = L.NU_NUME_MOVI_LABO
                  AND M.NU_HIST_PAC_MOVI = v_NoHistoriaPaciente )
          WHERE  NU_TIPO_COHI = 80
                   AND NU_ESTA_MOVI <> 2
           ORDER BY 1 DESC )
           WHERE ROWNUM <= 1 ;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;