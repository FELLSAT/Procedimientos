create or replace procedure         CreaPedidoDet(VUsuario  In seg0001.usuId%type,  --01
VDocumento In gen0012.doccod%type,  --02
Vempresa In gen0006.empcod%type,    --03
VItem In ven0004.pedlin%type,             --04
VnumDoc In ven0104.PedNro%type,      --05
Vprocod in ven0001.procod%type,        --06
VCantd In ven0004.peduni%type,         --07
VLisPreDesc In Out ven0005.tiplisdes%type, --08
VPuesto In gen0009.ccocod%type)              --09
Is   
     VPaisDo gen0006.emppaic%type;               VSenten cnt0021.erosentencia%type;                    VOk Char(1);
     VLisPre gen0022.lipcod%type;                    VValor ven00012.propre%type;                             VPorIVA cnt0014.dedpor%type;
     VValIva cnt00071.movmdeval%type;           VValTun cnt00071.movmdeval%type;                     VProdAli ven0001.proabr%type;
     VPorDes ven0001.rfpordto%type;                VValDesc cnt00071.movmdeval%type;                   
Begin
    Begin --Pais y empresa del usuario recien creado 
       Select a.emppaic Into  VPaisDo from seg0001 a  Left Join seg00011 b on a.usuid=b.usuid Where a.usuid=VUsuario and b.usuempc=Vempresa;       
    Exception
       When No_data_found Then
       VSenten := 'Select a.* from seg0001 a Left Join seg00011 b on a.usuid=b.usuid  where a.usuid='||chr(39)||VUsuario||chr(39)||' and  b.usuempc='||chr(39)||Vempresa||chr(39);
       RAISE_APPLICATION_ERROR(-20000, 'el usuario seleccionado no existe:    ' || VSenten);
    End;--Begin --   Pais y empresa del usuario recien creado
        
    Begin -- Validacion de porcentaje de IVA segun la tabla de codigos de deduccion
       Select b.dedpor, proabr, rfpordto Into VPorIVA, VProdAli, VPorDes
       from ven0001 a
       Left Join cnt0014 b on a.FDedCod = b. dedcod and a.FDedSC =b.dedsubcod and a.FDedAno=b.dedano
       Where a.VenEmpPai = VPaisDo and a.VenEmpC = Vempresa and a.ProCod = Vprocod;
       --VSenten:='where a.VenEmpPai='||chr(39)||VPaisDo||chr(39)||' and a.VenEmpC='||chr(39)||Vempresa||chr(39)||' and a.ProCod = '||chr(39)||Vprocod||chr(39);
       --RAISE_APPLICATION_ERROR(-20000, 'Pruebas para sacar el % iva      ' || VSenten);       
    Exception When No_data_found Then
         VPorIVA:=0;
    End; --Begin -- Validacion de porcentaje de IVA segun la tabla de codigos de deduccion   
    
    Begin
       Select 'S' Into VOk from gen0009 where ccocod = VPuesto and empcod = Vempresa;
    Exception When No_data_found Then 
          RAISE_APPLICATION_ERROR(-20000, 'El puesto digitado no esta creado      ' || VSenten);      
    End;
    
    If VLisPreDesc = 'Ninguna' Then
       Begin 
          Select  Max(a.propre) Into VValor from ven00012 a
          Where a.VenEmpPai = VPaisDo and a.VenEmpC = Vempresa and a.ProCod = Vprocod;
          Begin
             Select a.lipcod, b.lipnom  Into VLisPre, VLisPreDesc from ven00012 a left Join gen0022 b on a.lipcod=b.lipcod Where a.VenEmpPai = VPaisDo and a.VenEmpC = Vempresa and a.ProCod = Vprocod and a.propre=VValor and rownum <=1;
          End;
       Exception When No_data_found Then
          VSenten :='Select a.* from ven000121 a where a.VenEmpPai='||chr(39)||VPaisDo||chr(39)||' and a.VenEmpC='||chr(39)||Vempresa||Chr(39)||' and a.ProCod='||chr(39)||Vprocod||chr(39);
          RAISE_APPLICATION_ERROR(-20000, 'El producto '||chr(39)|| Vprocod  ||chr(39)  || '  No tiene configurada una lista de precio     ' || VSenten);
       End;
    Else
      --RAISE_APPLICATION_ERROR(-20001,'Valor %'||VLisPreDesc||'%');
       Select a.propre Into VValor 
       from ven00012 a
       Left Join  gen0022 b on a.lipcod=b.lipcod
       Where  a.VenEmpC = Vempresa and a.ProCod = Vprocod and b.lipnom Like '%'||VLisPreDesc||'%'; --a.VenEmpPai = VPaisDo and
        --RAISE_APPLICATION_ERROR(-20000, 'Sentencia =     Select a.propre  from ven00012 a Left Join  gen0022 b on a.lipcod=b.lipcod Where  a.VenEmpC='||chr(39)||Vempresa||chr(39)||' and a.ProCod = '||chr(39)||Vprocod ||chr(39)||' and b.lipnom Like %'||chr(39)||VLisPreDesc||chr(39)||'%'); 
    End If;
    
    If VPorIva > 0  Then -- Si la 
       VValIva := (((VValor * VCantd)*VPorIVA)/100);
    End If;--If VPorIva > 0  Then
    
    VValTun := VValor * VCantd;
    
    If VPorDes > 0 Then 
       VValDesc := (((VValor * VCantd)*VPorDes)/100);
    Else
       VValDesc := 0;      VPorDes := 0;
    End If;
    
    
    --RAISE_APPLICATION_ERROR(-20000, 'Valor iva y valor parcial      ' || VValIva||'      -    '||VValTun||'      por iva '||VPorIVA);    
    
    Begin
       Select 'S' Into VOk from ven0004 a where a.pedpaic=VPaisDo and a.pedempc=Vempresa and a.pedcoddoc=VDocumento and a.pednro=VnumDoc and a.pedlin=VItem;
    Exception When No_data_found Then
       --                              1            2               3           4        5            6          7    8      9         10          11           12           13          14             15          16          17           18            19         20        21         22         
       Insert Into ven0004(pedpaic,pedempc,pedcoddoc,pednro,pedlin,pedprocod,pepc,pec,peduni,pedval, pedvalcpi, pedporiva,pedvaliva,pedvaltun,pedsucdet,pedalias, pedpordc, peddcval, pedsal, ccocod, PedFacc, PedBodL)
       --               1            2               3                 4           5           6            7             8             9        10    11       12          13          14      15       16           17           18      19       20           21     22                   
       Values(VPaisDo, Vempresa, VDocumento, VnumDoc, VItem, Vprocod, VPaisDo, Vempresa, VCantd, VValor, 0,  VPorIVA, VValIva, VValTun, '01', VProdAli, VPorDes, VValDesc, 'N', VPuesto, VCantd,'GEN');
    End; 
End CreaPedidoDet;