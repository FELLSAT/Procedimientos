create or replace procedure factura_pedido
(
  VDocCod In gen0012.doccod%type, --pedido PD
  VPais In gen0006.emppaic%type,  --pais
  Vempresa In gen0006.empcod%type, -- codigo de la empresa
  VNroDoc In cnt00071.movdocnro%type, -- numero de pedido PEDNUMDOC
  VUsuario In seg0001.usuid%type,     -- usuario
  VMesa inv00018.mescod%type          -- mesa
) 
Is 
  VContador Numeric(6);                      
  VDocumento gen0012.doccod%type;          
  Vfacnro ven0008.facnro%type;
  Vcadena cnt0021.erodes%type;          
  VSenten cnt0021.erosentencia%type;        
  VBander gen0012.docnumaut%type;
  VNro cnt0021.eronro%type; 
Begin   
   VDocumento := 'FV';       
   VNro:=20170001;
   ----------------------------------------------------
   -- NUMERO DE FACTURA SIGUIENTE SI NO EXISTE LE ASIGNA LA PRIMERA YA QUE NO HAY REGISTRO
  Begin      
    Select Max(facnro) + 1 
    Into Vfacnro 
    from  ven0008  
    where facpaic = VPais 
    and facempc = Vempresa;
  Exception When No_data_found Then
    Vfacnro:=1;
  End;
    
  Begin
    ---------------------------------------------------  
    Insert into ven0008 (
      facpaic, facempc,
      faccoddoc,facnro,
      facnumdoc,facfech,
      facmc,cprpaic,
      cprempc,fpdocc,
      fpdocn,fcprnro,
      dircod,forpagcod,
      facvencod,facbodc,
      factipmov,facusuario,
      factotfac1,facotm,      
      totalfactura,emppaic,
      empcod,clicod,
      suctercod,facpais,
      facempresa,mescod)
    Select VPais ,Vempresa, 
      VDocumento, Vfacnro, 
      a.pednumdoc, a.pedfech,
      'FACTURA',VPais, 
      Vempresa,a.pedcoddoc,
      a.pednumdoc, a.pednro, 
      a.pdircod, a.pfpgcod, 
      a.pedvencod, a.pedbodcod,
      'P', VUsuario, 
      sum(b.pedvaliva) + sum(b.pedvaltun),'N', 
      sum(b.pedvaliva) + sum(b.pedvaltun),VPais, 
      Vempresa, a.pclicod,
      a.psuccli,VPais,
      Vempresa,VMesa
    from ven0104 a 
    Left Join ven0004 b 
      on a.PedPaic=b.PedPaic 
      and a.PedEmpc=b.PedEmpc 
      and a.PedCodDoc=b.PedCodDoc 
      and a.PedNro=b.PedNro
    Where a.pedpaic=VPais 
      and a.pedempc=Vempresa 
      and  a.pedcoddoc=VDocCod 
      and a.pednumdoc=VNroDoc 
    Group by a.pednumdoc,a.pedfech,
      a.pedcoddoc,a.pednro, 
      a.pdircod, a.pfpgcod, 
      a.pedvencod, a.pedbodcod, 
      a.pclicod,a.psuccli;               
        
    ---------------------------------------------------
    insert into ven00081(
      facpaic,facempc,
      faccoddoc,facnro,
      faclin,fpropc,
      fproec,facprocod,
      bodcodlin,funicpr,
      facuni,facunid,
      facvaluni,facdip,
      facvaliva,facvaltun,
      facdcp,facsucdet,
      facfranum,facclicod,
      facfecded,facvendet,
      facneto,faccco,
      facalias,
      factipoiva,
      facdetpai,facdetemp)        
    Select '169' facpaic, '901.023.461-1' facempc,
      'FV' faccoddoc,'5024454' facnro, 
      a.pedlin faclin, '169' fpropc, 
      '901.023.461-1' fproec,a.pedprocod facprocod,
      a.pedbodl bodcodlin,a.PedFacC funicpr,
      a.PedFacC facuni,a.PedFacC facunid,
      a.pedval facvaluni,PedPorIVA facdip,
      a.pedvaliva facvaliva,a.pedvaltun facvaltun,
      a.pedpordc facdcp,a.pedsucdet facsucdet,
      '5024' facfranum,b.PCliCod facclicod,
      b.pedfech facfecded,pedvencod facvendet,
      a.pedvaliva + a.pedvaltun facneto,a.ccocod faccco, 
      a.pedalias facalias, 
      case when pedvaliva > 0 
        then 'Gravado' 
        else 'SinIVA' 
      end factipoiva,  
      '169' facdetpai, '901.023.461-1' facdetemp
    from ven0004 a
    Left Join ven0104 b 
      on a.PedPaic = b.PedPaic 
      and a.PedEmpc = b.PedEmpc 
      and a.PedCodDoc = b.PedCodDoc 
      and a.PedNro = b.PedNro
    Where a.PedCodDoc = 'PD' 
      and b.PedNumDoc = '20150120';
   End;            
   Return;          
End factura_pedido;