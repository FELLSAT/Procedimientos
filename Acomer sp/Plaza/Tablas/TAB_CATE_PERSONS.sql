CREATE TABLE TAB_CATE_PERSONS(
	CODCATEPER CHAR(5) NOT NULL,
	DESCPER CHAR(30) NOT NULL
);

ALTER TABLE TAB_CATE_PERSONS ADD (
  CONSTRAINT PK_TAB_CATE_PERSONS PRIMARY KEY (CODCATEPER));

-------------------------------------------------------------
-- INSERTS
INSERT ALL
   INTO TAB_CATE_PERSONS (CODCATEPER, DESCPER) VALUES ('PERNI', 'NIÑO')
   INTO TAB_CATE_PERSONS (CODCATEPER, DESCPER) VALUES ('PERJO', 'JOVEN')
   INTO TAB_CATE_PERSONS (CODCATEPER, DESCPER) VALUES ('PERAD', 'ADULTO')
   INTO TAB_CATE_PERSONS (CODCATEPER, DESCPER) VALUES ('PERAN', 'ADULTO MAYOR')
SELECT * FROM DUAL;