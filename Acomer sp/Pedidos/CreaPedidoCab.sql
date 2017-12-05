create or replace procedure         CreaPedidoCab(VUsuario  In seg0001.usuId%type,
VDocumento In gen0012.doccod%type,
Vempresa In gen0006.empcod%type,
VCliente In gen0011.tercod%type, 
VnumDoc In Out ven0104.PedNro%type,
VLisPreDesc In Out gen0022.lipnom%type,
VMesCod In inv00018.mescod%type)

Is  --Select * from gen0012 where doccod='PD' and empcod='901.023.461-1'
     VPaisDo gen0006.emppaic%type;                  VTerRaz   gen0011.terraz%type;                  VPedNro ven0104.PedNro%type;                           
     VDocAut gen0012.docnumaut%type;              VDocNrod gen0012.docnro%type;                 VSenten cnt0021.erosentencia%type;
     VSuctern gen0024.SucTerNom%type;            VForPagCod gen0016.forpagcod%type;         VOk Char(1);
     VVended gen0011.tercod%type;                    VDirCliente ven0003.dircod%type;                 VDireccion ven0003.dirclidir%type;
     VTelClie gen0024.suctertel%type;                  VCiudad gen0003.mponom%type;                 VLisPrec  gen0022.lipcod%type;
     NroPed gen0012.docnro%type;                      VUsuPed seg0001.usuId%type;
Begin
   
   VLisPrec := 0;     
    Begin
    
       Begin Select mesnumreq, mesusureq Into  NroPed, VUsuPed From inv00018 where mescod =  VMesCod and mesestado='Ocupado';
          RAISE_APPLICATION_ERROR(-20000, 'La mesa que digito esta ocupada con el pedido numero '||NroPed||'    del susuario '||VUsuPed);
       Exception When No_data_found Then
          VSenten := 'Podra contuninuar porque la mesa esta vacia ';
       End; 
    
       Select  a.TerRaz Into VTerRaz from gen0011 a Where a.tercod = VCliente;
              
       Begin --Validacion si el tercero existe como cliente       
          Select  a.SucTerNom,a.CliFPC, a.suctertel,b.mponom,LiPCod Into VSuctern, VForPagCod, VTelClie, VCiudad, VLisPrec 
          From gen0024 a
          Left Join gen0003 b on a.CliPaiCod = b.PaiCod and a.CliDptCod = b.DptCod and a.CliMpoCod = b.MpoCod
          where a.Clicod=VCliente and a.suctercod='01';
          
          Begin -- Validacion de la forma de pago
             Select 'S' Into VOk from gen0016 where ForPagCod = VForPagCod;
          Exception When No_data_found Then
             VSenten:='Select a.CliFPC from gen0024 a where a.Clicod=VCliente and a.suctercod='||chr(39)||'01'||chr(39);
             RAISE_APPLICATION_ERROR(-20000, 'La forma de pago '||chr(39)||VForPagCod||chr(39)||' registrada en el cliente no existe en gen0016    ' || VSenten);
          End;           
          
          If VLisPrec <> '        ' and VLisPrec Is Not NUll Then
             Begin --Validacion de que lista de precios este en el maestro
                Select lipnom Into VLisPreDesc from gen0022 Where lipcod = VLisPrec;
             Exception When No_data_found Then
                VSenten:='Select * from gen0022 where lipcod='||chr(39)||VLisPrec||chr(39);              VLisPreDesc := 'Ninguna';
                --RAISE_APPLICATION_ERROR(-20000, 'La lista de precios  '||chr(39)||VLisPrec||chr(39)||'  asociado al cliente  no existe en el maestro de listas de precios     ' || VSenten);
             End;
          End If; 
                    
       Exception When No_data_found Then
          If VCliente = '01' Then--Si el cliente no es generico
             Insert into gen0024(clicod,suctercod,clinom1,sucternom,clifpc,CliAct,CliBlq,CliRpt) Values(VCliente,'01','GENERICO','Principal','01','S','N','N');
          Else
              Insert into gen0024(clicod,suctercod,clinom1,sucternom,clifpc,CliAct,CliBlq,CliRpt) Select a.tercod, '01', a.terraz,'Principal','01','S','N','N' from gen0011 a where a.tercod=VCliente;
          End If;--If VCliente <> '01' Then--Si el cliente no es generico
          VSuctern := 'Principal';
       End;
    Exception
       When No_data_found Then
       VSenten:='Select  a.TerRaz from gen0011 a where a.tercod='||chr(39)||VCliente||Chr(39);
       RAISE_APPLICATION_ERROR(-20000, 'Tercero digitado no existe:    ' || VSenten);
    End;
    
    Begin --   Pais y empresa del usuario recien creado 
       Select a.emppaic, a.UsuCed Into  VPaisDo, VVended from seg0001 a  Left Join seg00011 b on a.usuid=b.usuid Where a.usuid=VUsuario and b.usuempc=Vempresa;
       Begin --Validando la informacion del vendedor
          Select 'S' into VOk from gen0011 where tercod=VVended;
       Exception 
          When No_data_found Then 
          VSenten:='Select * from gen0011 where tercod = '||chr(39)||VVended||chr(39);
          RAISE_APPLICATION_ERROR(-20000, 'El vendedor '||chr(39)||VVended||chr(39)||' configurado en el usuario, no existe en gen0016   ' || VSenten);
       End;
    Exception
       When No_data_found Then
       VSenten := 'Select a.* from seg0001 a Left Join seg00011 b on a.usuid=b.usuid  where a.usuid='||chr(39)||VUsuario||chr(39)||' and  b.usuempc='||chr(39)||Vempresa||chr(39);
       RAISE_APPLICATION_ERROR(-20000, 'el usuario seleccionado no existe:    ' || VSenten);
    End;--Begin --   Pais y empresa del usuario recien creado
    
   Begin -- Select * from ven0003(Direcciones del cliente )
      Select Dircod, dirclidir Into VDirCliente,VDireccion from  ven0003 where clicod = VCliente and suctercod='01' and rownum <= 1;
   Exception When No_data_found then
      VDirCliente := '01';
      Insert Into ven0003(clicod,suctercod,dircod,dirclidir) Values(VCliente,'01','01','Principal');  -- Creando la direccion basica 
   End;--Begin -- Select * from ven0003(Direcciones del cliente )

   Begin -- Validacion de documento     
      Select a.Docnumaut, Cast(docnro + 1 as Numeric) Into VDocAut, VDocNrod from gen0012 a Where a.doccod=VDocumento and a.emppaic=VPaisDo and a.empcod = Vempresa;
      If VDocAut <> 'S' Then
         VSenten :='Select a.Docnumaut from gen0012 a where a.doccod='||chr(39)||VDocumento||chr(39)||'  a.emppaic='||chr(39)||VPaisDo||chr(39)||' and a.empcod='||chr(39)||Vempresa||chr(39);  
         RAISE_APPLICATION_ERROR(-20000, 'El documento '|| Chr(39)|| VDocumento ||chr(39) || ' no es autonumerico  ' || VSenten);      
      Else
         VSenten:='Continua con el proceso de grabacion con el numero de documento '||VDocNrod;
         Update gen0012 a set docnro = VDocNrod Where a.doccod=VDocumento and a.emppaic=VPaisDo and a.empcod = Vempresa;
         
         Begin
            Select Max(pednro) + 1 Into VPedNro from ven0104 where pedpaic = VPaisDo and pedempc = Vempresa;
         Exception 
            When No_data_found  Then
            VPedNro := 1;
         End;
            
         --Select * from ven0104
         --                               1            2               3             4              5            6            7          8           9             10       11         12         13          14        15         16         17           18            19        20       21         22          23                 24
         Insert Into ven0104(pedpaic, pedempc, pedcoddoc, pednro, pednumdoc, pedfech, pedfece, cotpaic, cotempc, pclicod, pclinom, psuccli, psucclin, pfpgcod, pclicup, pdircod, pdirnom, pedvencod, pedfac, pedlc, peddedt, pedfle, pedmodcod, pedordcom,
         -- 25            26          27           28         29           30            31            32          33          34
         pedotm, pedtdeom,psucclite, PDirCiud, usupaic, usuempc, venusuario, mescod, PedHora,pedbodcod)
         --              1           2                 3             4              5                              6                                              7                8            9           10          11     12       13             14      15       16            17            18      19  20 21 22    23       24
         Values(VPaisDo,Vempresa,VDocumento,VPedNro,VDocNrod,to_date(sysdate,'dd-mm-yy'),to_date(sysdate,'dd-mm-yy'),VPaisDo,Vempresa,VCliente,VTerRaz,'01',VSuctern,VForPagCod,0,VDirCliente,VDireccion,VVended,'F', 0, 0, 0,'PEDIDO', '01',
         --25 26      27            28         29           30             31            32                              33
            'N', 0, VTelClie, VCiudad, VPaisDo, Vempresa, VUsuario, VMesCod,  to_char(sysdate,'HH24:MI:SS' ),'GEN');              
         
      End If;--If VDocAut <> 'S' Then
      
      Update inv00018 set mesdocreq = VDocumento, mesnumreq = VDocNrod, mesusureq = VUsuario, mesestado='Ocupado' where mescod = VMesCod;     
   Exception 
      When No_data_found Then
      VSenten :='Select * from gen0012 where doccod='||chr(39)||VDocumento ||chr(39)||' and emppaic='||chr(39)||VPaisDo||' and empcod='||chr(39)||Vempresa||chr(39);
      RAISE_APPLICATION_ERROR(-20000, 'No existe el documento: '|| Chr(39)|| VDocumento ||chr(39) || '    ' || VSenten);
   End;--Begin -- Validacion de documento
   
   VnumDoc := VPedNro;
   Return;       
End CreaPedidoCab;