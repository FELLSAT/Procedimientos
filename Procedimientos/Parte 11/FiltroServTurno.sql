CREATE OR REPLACE FUNCTION FiltroServTurno
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODMED IN NVARCHAR2,
  v_CODSER IN NVARCHAR2,
  v_CODESP IN NVARCHAR2,
  v_FEINICIAL IN DATE,
  v_FEFINAL IN DATE
)
RETURN NUMBER
AS
   v_Rta NUMBER(1,0);
   v_HayFiltros NUMBER(10,0);

BEGIN
   SELECT COUNT(*)  

     INTO v_HayFiltros
     FROM R_TUR_SER 
    WHERE  CD_CODI_MED_RTS = v_CODMED
             AND FE_INICIAL_RTS = v_FEINICIAL
             AND FE_FINAL_RTS = v_FEFINAL;
   IF v_HayFiltros = 0 THEN
    v_Rta := 1 ;
   ELSE
   
   BEGIN
      SELECT COUNT(*)  

        INTO v_HayFiltros
        FROM R_TUR_SER 
       WHERE  CD_CODI_MED_RTS = v_CODMED
                AND CD_CODI_SER_RTS = v_CODSER
                AND CD_CODI_ESP_RTS = v_CODESP
                AND FE_INICIAL_RTS = v_FEINICIAL
                AND FE_FINAL_RTS = v_FEFINAL;
      IF v_HayFiltros = 0 THEN
       v_Rta := 0 ;
      ELSE
         v_Rta := 1 ;
      END IF;
   
   END;
   END IF;
   RETURN v_Rta;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;