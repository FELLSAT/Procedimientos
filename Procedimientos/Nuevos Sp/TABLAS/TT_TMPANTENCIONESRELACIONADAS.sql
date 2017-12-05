CREATE GLOBAL TEMPORARY TABLE TT_TMPANTENCIONESRELACIONADAS(
   NU_NUME_HICL NUMBER(22),
   NU_NUME_PLHI_HICL NUMBER(22),
   NU_NUME_LABO NUMBER(22),
   NU_NUME_MOVI NUMBER(22),
   FE_FECH_HICL DATE,
   CD_CODI_SER_LABO VARCHAR2(12),
   NO_NOMB_SER VARCHAR2(255),
   CD_CODI_ESP_LABO VARCHAR(3),
   NO_NOMB_ESP VARCHAR2(80),
   NU_NUME_REG_MOVI NUMBER(22),
   IDPLANTILLA NUMBER(22),
   IDCONCEPTO NUMBER(22),
   NOORDENCONCEPTO NUMBER(22)
) ON COMMIT PRESERVE ROWS;