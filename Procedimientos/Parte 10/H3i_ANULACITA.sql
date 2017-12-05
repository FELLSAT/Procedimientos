CREATE OR REPLACE PROCEDURE H3i_ANULACITA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_numerocita IN NUMBER,
  v_encargado IN VARCHAR2,
  v_justificacion IN VARCHAR2,
  v_idMotivo IN NUMBER
)
AS
   v_CD_CODI_MED_CIT VARCHAR2(4000);
   v_CD_CODI_SER_CIT VARCHAR2(4000);
   v_NU_DURA_CIT NUMBER(10,0);
   v_FE_HORA_CIT VARCHAR2(4000);
   v_ID_MOVI NUMBER(10,0);
   v_temp NUMBER(1, 0) := 0;

BEGIN

   INSERT INTO CITAS_ANULADAS
     ( CD_CODI_MED_CIAN, CD_CODI_SER_CIAN, NU_HIST_PAC_CIAN, NU_DURA_CIAN, FE_ELAB_CIAN, FE_FECH_CIAN, NU_DIA_CIAN, NU_NUME_MOVI_CIAN, NU_PRIM_CIAN, FE_HORA_CIAN, NU_NUME_CONE_CIAN, NU_CONE_CALL_CIAN, CD_CODI_ESP_CIAN, CD_CODI_CONS_CIAN, NU_NUME_CONV_CIAN, NU_TIPO_CIAN, DE_DESC_CIAN, CD_CODI_MOTI_CIAN, NU_CONE_ANUL_CIAN, TX_USER_CIAN, FE_MODIFI_CIAN, ME_OBSMOD_CIAN, TX_INDMOV_CIAN, NU_NUME_CIT_CIAN, CD_MEDI_ORDE_CIAN, TX_CODI_EQUI_CIAN, NU_TIPOJO_CIAN, NU_CITEXT_CIAN, CD_CODI_MED_EST_CIAN, CD_CODI_MOANCI_CIT )
     ( SELECT CD_CODI_MED_CIT ,
              CD_CODI_SER_CIT ,
              NU_HIST_PAC_CIT ,
              NU_DURA_CIT ,
              FE_ELAB_CIT ,
              FE_FECH_CIT ,
              NU_DIA_CIT ,
              NU_NUME_MOVI_CIT ,
              NU_PRIM_CIT ,
              FE_HORA_CIT ,
              NU_NUME_CONE_CIT ,
              NU_CONE_CALL_CIT ,
              CD_CODI_ESP_CIT ,
              CD_CODI_CONS_CIT ,
              NU_NUME_CONV_CIT ,
              NU_TIPO_CIT ,
              DE_DESC_CIT ,
              NULL ,
              NULL ,
              v_encargado ,
              NULL ,
              v_justificacion ,
              NULL ,
              NULL ,
              CD_MEDI_ORDE_CIT ,
              TX_CODI_EQUI_CIT ,
              NU_TIPOJO_CIT ,
              NU_CITEXT_CIT ,
              CD_CODI_MED_EST_CIT ,
              v_idMotivo 
       FROM CITAS_MEDICAS 
        WHERE  NU_NUME_CIT = v_numerocita
                 AND FE_FECH_CIT > SYSDATE );
   SELECT CD_CODI_MED_CIT ,
          CD_CODI_SER_CIT ,
          NU_DURA_CIT ,
          FE_HORA_CIT ,
          NU_NUME_MOVI_CIT 

     INTO v_CD_CODI_MED_CIT,
          v_CD_CODI_SER_CIT,
          v_NU_DURA_CIT,
          v_FE_HORA_CIT,
          v_ID_MOVI
     FROM CITAS_MEDICAS 
    WHERE  NU_NUME_CIT = v_numerocita AND ROWNUM <= 1;
   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE ( SELECT COUNT(NU_NUME_CIT)  
               FROM CITAS_MEDICAS 
                WHERE  CD_CODI_MED_CIT = v_CD_CODI_MED_CIT
                         AND CD_CODI_SER_CIT = v_CD_CODI_SER_CIT
                         AND NU_DURA_CIT = v_NU_DURA_CIT
                         AND FE_HORA_CIT = v_FE_HORA_CIT ) = 1;
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      INSERT INTO CITAS_DISPONIBLES
        ( NU_TUME_CIDI, CD_MED_CIDI, FE_FECH_CIDI, FE_HOIN_CIDI, FE_HOFI_CIDI, NU_DURA_CIDI )
        ( SELECT DISTINCT NU_NUME_TUME NU_TUME_CIDI  ,
                          CD_CODI_MED_CIT CD_MED_CIDI  ,
                          TO_CHAR(FE_FECH_CIT) FE_FECH_CIDI  ,
                          TO_CHAR(FE_FECH_CIT) FE_HOIN_CIDI  ,
                          TO_CHAR(FE_FECH_CIT + NU_DURA_CIT / 1440) FE_HOFI_CIDI  ,
                          NU_DURA_CIT NU_DURA_CIDI  
          FROM CITAS_MEDICAS 
                 JOIN TURNOS_MEDICOS    ON ( TO_CHAR(FE_FECH_TUME) = TO_CHAR(FE_FECH_CIT)
                 AND CD_CODI_MED_CIT = CD_MED_TUME )
           WHERE  NU_NUME_CIT = v_numerocita
                    AND CD_CODI_MED_CIT = v_CD_CODI_MED_CIT );
   
   END;
   END IF;
   DELETE LABORATORIO

    WHERE  NU_NUME_MOVI_LABO = v_ID_MOVI;
   DELETE MOVI_CARGOS

    WHERE  NU_NUME_MOVI = v_ID_MOVI;
   -- Borro la asignación de estudiante a la cita.
   DELETE ASIG_CITA_DOCENTE_ESTUDIANTE

    WHERE  NU_NUME_CIT_ACDE = v_numerocita;
   --    DELETE FROM CITAS_CONFIRMADAS WHERE NU_NUME_CIT = @numerocita
   DELETE CITAS_MEDICAS

    WHERE  NU_NUME_CIT = v_numerocita;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;