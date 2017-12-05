CREATE TABLE PEDDETCAN(
	PEDPAIC CHAR(4 BYTE) NOT NULL, 
	PEDEMPC CHAR(13 BYTE) NOT NULL, 
	PEDCODDOC CHAR(3 BYTE) NOT NULL, 
	PEDNRO NUMBER(10,0) NOT NULL, 
	PEDLIN NUMBER(4,0) NOT NULL, 
	PEPC CHAR(4 BYTE), 
	PEC CHAR(13 BYTE), 
	PEDPROCOD CHAR(20 BYTE), 
	PEDBODL CHAR(3 BYTE), 
	CCOCOD CHAR(3 BYTE), 
	SCOCOD CHAR(3 BYTE), 
	PEDUNI NUMBER(17,2), 
	PEDVAL NUMBER(17,2), 
	PEDVALCPI NUMBER(17,2), 
	PEDPORIVA NUMBER(17,2), 
	PEDVALIVA NUMBER(17,2), 
	PEDVALTUN NUMBER(17,2), 
	PEDDREF1 CHAR(10 BYTE), 
	PEDDREF2 CHAR(10 BYTE), 
	PEDPORDV NUMBER(17,2), 
	PEDDVVAL NUMBER(17,2), 
	PEDPORDC NUMBER(17,2), 
	PEDDCVAL NUMBER(17,2), 
	PEDPORDP NUMBER(17,2), 
	PEDDRVAL NUMBER(17,2), 
	PEDPORDCP1 NUMBER(17,2), 
	PEDDCPVAL NUMBER(17,2), 
	PEDPORDCP2 NUMBER(17,2), 
	PEDDCP2VAL NUMBER(17,2), 
	PEDSUCDET CHAR(3 BYTE), 
	CEUCOD CHAR(3 BYTE), 
	SCUCOD CHAR(3 BYTE), 
	PEDREMC NUMBER(17,2), 
	PEDFACC NUMBER(17,2), 
	PEDVALOM NUMBER(17,3), 
	PEDVIOM NUMBER(17,2), 
	PEDVLOM NUMBER(17,2), 
	PEDDVOM NUMBER(17,2), 
	PEDDCOM NUMBER(17,2), 
	PEDDPOM NUMBER(17,2), 
	PEDDCPOM NUMBER(17,2), 
	PEDDCP2OM NUMBER(17,2), 
	PEDOBSDET VARCHAR2(600 BYTE), 
	PEDALIAS CHAR(10 BYTE), 
	PEDDLPOR NUMBER(6,3), 
	PEDDLVAL NUMBER(17,2), 
	PEDDLVOM NUMBER(17,2), 
	PEDDDPGL NUMBER(6,3), 
	PEDDDVGL NUMBER(17,2), 
	PEDDDVGOM NUMBER(17,2), 
	PEDCHECK NUMBER(1,0), 
	PEDSAL CHAR(1 BYTE)
);

ALTER TABLE PEDDETCAN
ADD CONSTRAINT CONS_PRIMARY_PEDDETCAN PRIMARY KEY (PEDPAIC, PEDEMPC, PEDCODDOC, PEDNRO, PEDLIN);