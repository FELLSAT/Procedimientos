CREATE TABLE TAB_REL_ROL(
	TERCOD CHAR(11),
	IDROL VARCHAR2(10),
	EMPCOD CHAR(13),
	EMPPAIC CHAR(4)
);

INSERT ALL 
	INTO TAB_REL_ROL (TERCOD,IDROL,EMPCOD,EMPPAIC) VALUES('111112','ATNMES','901.023.461-1','169')
	INTO TAB_REL_ROL (TERCOD,IDROL,EMPCOD,EMPPAIC) VALUES('111112','ATNCOC','901.023.461-1','169')
	INTO TAB_REL_ROL (TERCOD,IDROL,EMPCOD,EMPPAIC) VALUES('951357','ATNMES','901.023.461-2','169')
	INTO TAB_REL_ROL (TERCOD,IDROL,EMPCOD,EMPPAIC) VALUES('654258','ATNCOC','901.023.461-2','169')
SELECT 1 FROM DUAL;