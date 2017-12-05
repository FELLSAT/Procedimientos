    Select 169 ,'901.023.461-1', 
      'FV', 1, 
      a.pednumdoc, a.pedfech,
      'FACTURA',169, 
      '901.023.461-1',a.pedcoddoc,
      a.pednumdoc, a.pednro, 
      a.pdircod, a.pfpgcod, 
      a.pedvencod, a.pedbodcod,
      'P', '1234567', 
      sum(b.pedvaltun),'N', 
      sum(b.pedvaltun),169, 
      '901.023.461-1', a.pclicod,
      a.psuccli,169,
      '901.023.461-1','1'
    from ven0104 a 
    Left Join ven0004 b 
      on a.PedPaic=b.PedPaic 
      and a.PedEmpc=b.PedEmpc 
      and a.PedCodDoc=b.PedCodDoc 
      and a.PedNro=b.PedNro
    Where a.pedpaic='169' 
      and a.pedempc='901.023.461-1' 
      and  a.pedcoddoc='PD' 
      and a.pednumdoc='20150153' 
    Group by a.pednumdoc,a.pedfech,
      a.pedcoddoc,a.pednro, 
      a.pdircod, a.pfpgcod, 
      a.pedvencod, a.pedbodcod, 
      a.pclicod,a.psuccli;      
      
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
      and b.PedNumDoc = '20150153'
      and a.ccocod = '03';