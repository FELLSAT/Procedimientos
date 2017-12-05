ALTER TABLE TELEPRU.T_MENU
 DROP PRIMARY KEY CASCADE;

DROP TABLE TELEPRU.T_MENU CASCADE CONSTRAINTS;

CREATE TABLE TELEPRU.T_MENU
(
  COD_MENU     NUMBER                           NOT NULL,
  NOM_MENU     VARCHAR2(80 BYTE)                NOT NULL,
  DESCRIPCION  VARCHAR2(200 BYTE)
)
TABLESPACE TELEFONICA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


--  There is no statement for index TELEPRU.SYS_C0015725.
--  The object is created when the parent object is created.

CREATE OR REPLACE PUBLIC SYNONYM T_MENU FOR TELEPRU.T_MENU;


ALTER TABLE TELEPRU.T_MENU ADD (
  PRIMARY KEY
  (COD_MENU)
  USING INDEX
    TABLESPACE TELEFONICA
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);
