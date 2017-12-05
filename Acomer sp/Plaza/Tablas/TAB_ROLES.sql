CREATE TABLE TAB_ROLES(
	IDROL VARCHAR2(10) NOT NULL,
	NOMBREROL VARCHAR2(50) NOT NULL,
	DESCRIPCIONROL VARCHAR(200),
	VALROL NUMBER NOT NULL
);

INSERT ALL 
	INTO TAB_ROLES (IDROL,NOMBREROL,DESCRIPCIONROL,VALROL) VALUES('ATNMES','MESERO','Atencion en mesas',1)
	INTO TAB_ROLES (IDROL,NOMBREROL,DESCRIPCIONROL,VALROL) VALUES('ATNCOC','COCINERO','Atencion en COCINA',1)
SELECT 1 FROM DUAL;