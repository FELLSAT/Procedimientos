CREATE TABLE SPTYT.MEDICOS
(
  CD_CODI_MED          VARCHAR2(10 CHAR)        NOT NULL,
  NU_DOCU_MED          VARCHAR2(16 CHAR),
  NO_NOMB_MED          VARCHAR2(70 CHAR),
  NU_TIPD_MED          NUMBER(3)                DEFAULT (0),
  DE_DIRE_MED          VARCHAR2(1413 CHAR),
  DE_TELE_MED          VARCHAR2(50 CHAR),
  DE_CARG_MED          VARCHAR2(88 CHAR),
  NU_MICO_MED          NUMBER(3)                DEFAULT (0),
  NU_INDI_MED          NUMBER(10)               DEFAULT (0),
  NU_ESTA_MED          NUMBER(3),
  NU_CONSE_ADSC_MED    NUMBER(10),
  NU_MAXC_MED          NUMBER(10),
  DE_REGI_MED          VARCHAR2(30 CHAR),
  NU_FIRMA_MED         LONG RAW,
  NU_DIAS_MED          NUMBER(10),
  CD_CODI_CONC_MED     VARCHAR2(4 CHAR),
  NO_NOMB1_MED         VARCHAR2(100 CHAR),
  NO_NOMB2_MED         VARCHAR2(100 CHAR),
  NO_APEL1_MED         VARCHAR2(100 CHAR),
  NO_APEL2_MED         VARCHAR2(100 CHAR),
  NU_MIPRO_MED         NUMBER(10)               DEFAULT (0),
  NU_DOCENTE_MEDI      NUMBER(1)                DEFAULT (0)                   NOT NULL,
  NU_TIPO_MEDI         NUMBER(3)                DEFAULT (0)                   NOT NULL,
  DE_CELU_MED          VARCHAR2(50 CHAR),
  DE_MAIL_MED          VARCHAR2(100 CHAR),
  TX_CODIGO_MOCO_MEDI  VARCHAR2(10),
  PERM_CITA_WEB        NUMBER(1)                DEFAULT (1)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


CREATE UNIQUE INDEX SPTYT.PKMEDICOS ON SPTYT.MEDICOS
(CD_CODI_MED)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );