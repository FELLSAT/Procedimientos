TABLA:

ALTER TABLE INV00018
	DROP COLUMN MESUSUREQ;

ALTER TABLE INV00018
	ADD ( MESNUMREQ2  CHAR(10),
		 MESNUMREQ3  CHAR(10),
		 MESUSUREQ  CHAR(10));