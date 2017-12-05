CREATE TABLE SPTYT.USUARIOS
(
  ID_IDEN_USUA        VARCHAR2(30 CHAR)         NOT NULL,
  PS_PASS_USUA        VARCHAR2(15 CHAR),
  NO_NOMB_USUA        VARCHAR2(170 CHAR),
  NU_TIPD_USUA        NUMBER(3)                 DEFAULT (0),
  NU_DOCU_USUA        VARCHAR2(12 CHAR),
  CD_CODI_PERF_USUA   VARCHAR2(50 CHAR),
  CD_CODI_GRUP_USUA   NUMBER(3)                 DEFAULT (0),
  NU_FIRMA            LONG RAW,
  NU_ULCON_USUA       NUMBER(18)                DEFAULT (0),
  CD_CODI_PERIN_USUA  VARCHAR2(50 CHAR)         DEFAULT (1),
  NU_CAMBCLAVE_USUA   NUMBER(1)                 DEFAULT (0)                   NOT NULL,
  NU_ESTADO_USUA      NUMBER(10)                DEFAULT (1)                   NOT NULL,
  TX_NOMBRE1_USUA     VARCHAR2(40)             DEFAULT (' ')                 NOT NULL,
  TX_NOMBRE2_USUA     VARCHAR2(40)             DEFAULT NULL,
  TX_APELLIDO1_USUA   VARCHAR2(40)             DEFAULT (' ')                 NOT NULL,
  TX_APELLIDO2_USUA   VARCHAR2(40)             DEFAULT NULL,
  NU_AUTO_ENTI_USUA   NUMBER(10)                DEFAULT (1)                   NOT NULL,
  CD_CODI_LUAT_FACO   VARCHAR2(2 CHAR),
  CA_PASSWORD         DATE,
  PS_PASS_USUA1       VARCHAR2(2 CHAR)          DEFAULT (8),
  CD_CODI_ROL_USUA    NUMBER(10),
  TX_DIRECCION        VARCHAR2(50 CHAR)         DEFAULT NULL,
  TX_TELEFONO         VARCHAR2(30 CHAR)         DEFAULT NULL,
  TX_TEL_CEL          VARCHAR2(30 CHAR)         DEFAULT NULL,
  TX_CORREO           VARCHAR2(30 CHAR)         DEFAULT NULL,
  CD_CODI_CARGO       NUMBER(10)                DEFAULT NULL,
  CD_CODI_MODALID     VARCHAR2(10 CHAR)         DEFAULT NULL,
  NU_TRABAJO_AUDI     NUMBER(10)
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


CREATE UNIQUE INDEX SPTYT.PKUSUARIOS ON SPTYT.USUARIOS
(ID_IDEN_USUA)
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