
Delete from ven0104 where pednro=4;
Delete from ven0004 where pednro=4;
Commit;
DECLARE 
  VUSUARIO CHAR(10);
  VDOCUMENTO CHAR(3);
  VEMPRESA CHAR(13);
  VCLIENTE CHAR(11);
  VNUMDOC NUMBER;
  VITEM NUMBER;
  VPROCOD CHAR(20);
  VLisPreDesc CHAR(30);
  VCantd number;
  VMesCod NUMBER;
  VPuesto character(3);
BEGIN 
  VUSUARIO := '1234567';
  VDOCUMENTO := 'PD';
  VEMPRESA := '901.023.461-1';
  VCLIENTE := '15373820';
  VNUMDOC := NULL;
  VITEM := 1;
  VPROCOD:='CHUR-0001';
  VLisPreDesc:='Nada';
  VCantd:=1;
  VMesCod:=15;
  VPuesto:= '01';

  USR_AWA.CREAPEDIDOCAB ( VUSUARIO, VDOCUMENTO, 
        VEMPRESA, VCLIENTE, VNUMDOC,VLisPreDesc,VMesCod);
  DBMS_OUTPUT.PUT_LINE('VLisPreDesc: '||VLisPreDesc);
  USR_AWA.CreaPedidoDet ( VUSUARIO, VDOCUMENTO, 
        VEMPRESA, VITEM, VNUMDOC,VPROCOD,VCantd,VLisPreDesc,vpuesto );
  --COMMIT; 
END; 


Select * from ven0004


Update gen0012 a 
set docnro = '20150086' 
Where a.doccod='PD' 
and a.emppaic='169' 
and a.empcod = '901.023.461-1';
         

SELECT * FROM V$SESSION WHERE STATUS = 'ACTIVE'


SELECT * FROM DBA_OBJECTS WHERE OBJECT_TYPE = 'TABLE' AND OBJECT_NAME = 'GEN0012'

alter system kill session '152,0457';

59586

SELECT O.OBJECT_NAME, S.SID, S.SERIAL#, P.SPID, S.PROGRAM,SQ.SQL_FULLTEXT, S.LOGON_TIME 
FROM V$LOCKED_OBJECT L, DBA_OBJECTS O, V$SESSION S, V$PROCESS P, V$SQL SQ 
WHERE L.OBJECT_ID = O.OBJECT_ID AND L.SESSION_ID = S.SID AND S.PADDR = P.ADDR AND S.SQL_ADDRESS = SQ.ADDRESS;

SELECT s.inst_id,
   s.sid,
   s.serial#,
   p.spid,
   s.username,
   s.program FROM   gv$session s
   JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id;
   
   ALTER SYSTEM KILL SESSION 'sid,serial#'