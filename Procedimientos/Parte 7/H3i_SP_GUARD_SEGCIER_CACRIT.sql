CREATE OR REPLACE PROCEDURE H3i_SP_GUARD_SEGCIER_CACRIT
(
  v_CODIGO IN NUMBER,
  v_NUMHCLI IN VARCHAR2,
  v_CODUSR IN VARCHAR2,
  v_NOMUSR IN VARCHAR2,
  v_NUMSESS IN NUMBER,
  v_DOCSESS IN VARCHAR2,
  v_CODUSRREG IN VARCHAR2,
  v_NOMUSRREG IN VARCHAR2,
  v_CODPROFES IN VARCHAR2,
  v_NOMPROFES IN VARCHAR2,
  v_FECHAREG IN DATE,
  v_OBSERVACIONES IN VARCHAR2,
  v_ESSEGUIM IN NUMBER,
  v_ESCIERRE IN NUMBER,
  v_NUMPLANT IN VARCHAR2,
  v_NOMPLANT IN VARCHAR2,
  v_NUMLABO IN NUMBER,
  v_NUMCARGO IN NUMBER
)
AS

BEGIN

   IF v_CODIGO = 0 THEN
    
   BEGIN
      INSERT INTO CASO_CRITICO_HIST
        ( NU_HISTPAC_CASCRIT, CD_CODPAC_CASCRIT, NO_NOMPAC_CASCRIT, NU_NUMSESS_CASCRIT, NU_DOCSESS_CASCRIT, CD_CODUSRREG_CASCRIT, NO_NOMUSRREG_CASCRIT, CD_CODPROFREG_CASCRIT, NO_NOMPROFREG_CASCRIT, FE_FECHAREG_CASCRIT, TX_OBSERV_CASCRIT, ES_SEGUIM_CASCRIT, ES_CIERRE_CASCRIT, NU_NUM_PLANT_CASCRIT, NO_NOMB_PLANT_CASCRIT, NU_NUMLABO_CASCRIT, NU_NUMCARGO_CASCRIT )
        VALUES ( v_NUMHCLI, v_CODUSR, v_NOMUSR, v_NUMSESS, v_DOCSESS, v_CODUSRREG, v_NOMUSRREG, v_CODPROFES, v_NOMPROFES, TO_DATE(v_FECHAREG,'dd/mm/yyyy'), v_OBSERVACIONES, v_ESSEGUIM, v_ESCIERRE, v_NUMPLANT, v_NOMPLANT, v_NUMLABO, v_NUMCARGO );
   
   END;
   ELSE
   
   BEGIN
      UPDATE CASO_CRITICO_HIST
         SET NU_HISTPAC_CASCRIT = v_NUMHCLI,
             CD_CODPAC_CASCRIT = v_CODUSR,
             NO_NOMPAC_CASCRIT = v_NOMUSR,
             NU_NUMSESS_CASCRIT = v_NUMSESS,
             NU_DOCSESS_CASCRIT = v_DOCSESS,
             CD_CODUSRREG_CASCRIT = v_CODUSRREG,
             NO_NOMUSRREG_CASCRIT = v_NOMUSRREG,
             CD_CODPROFREG_CASCRIT = v_CODPROFES,
             NO_NOMPROFREG_CASCRIT = v_NOMPROFES,
             FE_FECHAREG_CASCRIT = v_FECHAREG,
             TX_OBSERV_CASCRIT = v_OBSERVACIONES,
             ES_SEGUIM_CASCRIT = v_ESSEGUIM,
             ES_CIERRE_CASCRIT = v_ESCIERRE,
             NU_NUM_PLANT_CASCRIT = v_NUMPLANT,
             NO_NOMB_PLANT_CASCRIT = v_NOMPLANT,
             NU_NUMLABO_CASCRIT = v_NUMLABO,
             NU_NUMCARGO_CASCRIT = v_NUMCARGO
       WHERE  CD_CASCRIT_HC = v_CODIGO;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;