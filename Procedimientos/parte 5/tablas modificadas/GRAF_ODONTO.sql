CREATE TABLE SPTYT.GRAF_ODONTO
(
  CD_CODI_GRAF  VARCHAR2(4 CHAR)                NOT NULL,
  NO_NOMB_GRAF  VARCHAR2(40 CHAR),
  GR_ICON_GRAF  VARCHAR2(4000),
  TI_TIPO_GRAF  VARCHAR2(1 CHAR)
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