CREATE TABLE SPTYT.ARTICULO
(
  CD_CODI_ARTI       VARCHAR2(16 CHAR)          NOT NULL,
  NO_NOMB_ARTI       VARCHAR2(255)             NOT NULL,
  DE_DESC_ARTI       VARCHAR2(255),
  CD_GRUP_ARTI       VARCHAR2(20 CHAR)          NOT NULL,
  CD_USOS_ARTI       VARCHAR2(20 CHAR)          NOT NULL,
  DE_UNME_ARTI       VARCHAR2(255),
  CT_CNVR_ARTI       FLOAT(126)                 DEFAULT (0),
  DE_UNCO_ARTI       VARCHAR2(30 CHAR),
  DE_CTRA_ARTI       VARCHAR2(30 CHAR),
  CT_MAXI_ARTI       FLOAT(126)                 DEFAULT (0),
  CT_MINI_ARTI       FLOAT(126)                 DEFAULT (0),
  FE_VENC_ARTI       DATE,
  ID_GRAV_ARTI       VARCHAR2(1 CHAR)           NOT NULL,
  PR_IMPU_ARTI       FLOAT(126)                 DEFAULT (0),
  VL_ULCO_ARTI       FLOAT(126)                 DEFAULT (0),
  VL_COPR_ARTI       FLOAT(126)                 DEFAULT (0),
  CT_EXIS_ARTI       FLOAT(126)                 DEFAULT (0),
  DE_OBSE_ARTI       VARCHAR2(70 CHAR),
  ID_TIPO_ARTI       NUMBER(3)                  DEFAULT (0),
  DE_FOFA_ARTI       VARCHAR2(60 CHAR),
  CD_RIPS_ARTI       VARCHAR2(16 CHAR),
  DE_UBIC_ARTI       VARCHAR2(60 CHAR),
  NU_INDPYP_ARTI     NUMBER(3),
  CD_ALT2_ARTI       CHAR(15 CHAR),
  NU_ESLIQ_ARTI      NUMBER(3)                  DEFAULT (0),
  NU_CONF_GRUP_USOS  NUMBER(3)                  DEFAULT (0)                   NOT NULL,
  VL_AJUVAL_ARTI     FLOAT(126)                 DEFAULT (0),
  ID_ARTI_DESCR      VARCHAR2(4000 CHAR),
  TX_FEVENC_ARTI     VARCHAR2(1 CHAR)           DEFAULT 'N'                   NOT NULL,
  NU_ESTA_ARTI       NUMBER(3)                  DEFAULT (1)                   NOT NULL,
  CD_NUME_CARI_ARTI  VARCHAR2(20 CHAR),
  NU_INDDONA_ARTI    VARCHAR2(2 CHAR),
  NU_ES_CONTROLADO   NUMBER(1)                  DEFAULT (0)                   NOT NULL,
  NU_ES_RESTRINGIDO  NUMBER(1)                  DEFAULT (0)                   NOT NULL
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