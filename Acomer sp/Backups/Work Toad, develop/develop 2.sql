SELECT * FROM INV00018;
SELECT * FROM TABCOPYINV00018;
SELECT * FROM DETMESA;
SELECT * FROM VEN0004;
SELECT * FROM TABCOPYVEN0004;
SELECT * FROM VEN0104;
SELECT * FROM TABCOPYVEN0104;
SELECT * FROM COPYUNIONMESA;
SELECT * FROM UNIONMESA;
SELECT * FROM CAB_FACTURA_GRAL;
SELECT * FROM VEN0008 WHERE FACEMPC = '901.023.461-1' or FACEMPC = '901.023.461-2';
SELECT * FROM VEN00081 WHERE FACEMPC = '901.023.461-1' or FACEMPC = '901.023.461-2';
SELECT * FROM TAB_FACTURA_CLIENTE;
SELECT * FROM TAB_FACTURAS_REVERSADAS;

/*
BEGIN
  UPDATE INV00018 SET MESESTADO = 'Activo', MESDOCREQ = '', MESNUMREQ = '', MESNUMREQ2 = '', MESNUMREQ3 = '', MESNUMREQ4 = '', MESUSUREQ ='', MESHORAPED = '';
  UPDATE DETMESA SET PUESTOS = 0;
  DELETE FROM VEN0004;
  DELETE FROM VEN0104;
  DELETE FROM UNIONMESA;
  DELETE FROM VEN0008 WHERE FACEMPC = '901.023.461-1' OR FACEMPC = '901.023.461-2';
  DELETE FROM VEN00081 WHERE FACEMPC = '901.023.461-1' OR FACEMPC = '901.023.461-2';
  DELETE FROM CAB_FACTURA_GRAL;
  DELETE FROM TAB_FACTURA_CLIENTE;
  DELETE TABCOPYINV00018;
  DELETE TABCOPYVEN0004;
  DELETE TABCOPYVEN0104;
  DELETE TAB_FACTURAS_REVERSADAS;
  DELETE PEDCAN;
  DELETE PEDDETCAN;
  DELETE Histcocina;
  DELETE COPYUNIONMESA;
END;
*/
