SELECT * FROM INV0013 -- CATEGORIAS DE COMIDAS ()

SELECT * FROM INV0014 -- SUB CATEGORIAS (ASADOS, VERDURAS, MAR, PASTA...)

SELECT * FROM INV0015 -- TERMINOS 

SELECT * FROM DETMESA -- DETALLE DE LAS MESAS

SELECT * FROM INV00018 -- CABECERA  DE LAS MESAS

SELECT * FROM VEN0104 -- CABECERA DE PEDIDOS 

SELECT * FROM VEN0004 -- DETALLE DE LOS PEDIDOS

select * from gen0006 -- LISTA DE EMPRESAS  

select * from ven00012 order by lipcod, venempc-- lista de precios

SELECT * FROM VEN0001 WHERE VENEMPC = '901.023.461-1' OR VENEMPC = '901.023.461-2' ORDER BY VENEMPC-- PRODUCTOS

SELECT * FROM gen0009 -- PUESTOS DE LAS MESAS

SELECT * FROM gen0009 -- PUESTOS DE LAS MESAS

SELECT * FROM INV0013 -- CATEGORIAS DE COMIDAS (ORIENTAL, ITALIANO...)

SELECT * FROM INV0014 -- SUB CATEGORIAS (ASADOS, VERDURAS, MAR, PASTA...)

SELECT * FROM INV0015 -- ITEMS DE CADA SUB CATEGORIA

SELECT * FROM GEN0016 -- FORMAS DE PAGO


select table_name 
from all_tab_columns 
where column_name='RFPORDTO'

  VUSUARIO := '123467';
  VDOCUMENTO := 'PD';
  VEMPRESA := '901.023.461-1';
  VCLIENTE := '15373820';
  VNUMDOC := NULL;
  VITEM := 1;
  VPROCOD:='ESPECIAL-LACUBANA';
  VLisPreDesc:='Nada';
  VCantd:=1;
  VMesCod:=1;
  VPuesto:= '01';
 

 
 Select a.Docnumaut, docnro --Cast( + 1 as Numeric) 
 --Into VDocAut, VDocNrod 
 from gen0012 a 
 Where a.doccod='PD' 
    and a.emppaic='169' 
    and a.empcod = '901.023.461-1';
    
    
SELECT * FROM VEN0104 -- CABECERA DE PEDIDOS 

SELECT * FROM VEN0004 -- DETALLE DE LOS PEDIDOS
    
Select  a.SucTerNom,a.CliFPC, 
    a.suctertel,b.mponom,LiPCod 
--Into VSuctern, VForPagCod, VTelClie, VCiudad, VLisPrec 
From gen0024 a
Left Join gen0003 b 
    on a.CliPaiCod = b.PaiCod 
    and a.CliDptCod = b.DptCod 
    and a.CliMpoCod = b.MpoCod
where a.Clicod='15373820' and a.suctercod='01';


Select Dircod, dirclidir 
--Into VDirCliente,VDireccion 
from  ven0003 
where clicod = '15373820' 
    and suctercod='01' 
    and rownum <= 1;
    
Select a.emppaic, a.UsuCed 
--Into  VPaisDo, VVended 
from seg0001 a  
Left Join seg00011 b 
    on a.usuid=b.usuid 
Where a.usuid='1234567' 
    and b.usuempc='901.023.461-1';
    
Select  a.SucTerNom,a.CliFPC, a.suctertel,b.mponom,LiPCod 
--Into VSuctern, VForPagCod, VTelClie, VCiudad, VLisPrec 
From gen0024 a
Left Join gen0003 b 
    on a.CliPaiCod = b.PaiCod 
    and a.CliDptCod = b.DptCod 
    and a.CliMpoCod = b.MpoCod
where a.Clicod='15373820' and a.suctercod='01'

                                       --TOROCAESA
Select b.dedpor, proabr, rfpordto --16 , CURRASCO,3  
--Into VPorIVA, VProdAli, VPorDes
from ven0001 a
Left Join cnt0014 b 
    on a.FDedCod = b. dedcod -- IVA 
    and a.FDedSC =b.dedsubcod -- 01
    and a.FDedAno=b.dedano -- 2017
Where a.VenEmpPai = '169' 
    and a.VenEmpC = '901.023.461-1' 
    and a.ProCod LIKE 'SALAD-%';
    
    
    SELECT CNT0014.DEDPOR
	--INTO V_VALOR_IVA
	FROM VEN0001 
	LEFT JOIN CNT0014  
	    ON VEN0001.FDEDCOD = CNT0014.DEDCOD 
	    AND VEN0001.FDEDSC = CNT0014.DEDSUBCOD
	    AND VEN0001.FDEDANO = CNT0014.DEDANO 
	WHERE VEN0001.VENEMPPAI = '169' 
	    AND VEN0001.VENEMPC = '901.023.461-1' 
	    AND VEN0001.PROCOD = 'ESPECIAL-LACUBANA';



Select a.emppaic 
--Into  VPaisDo 
from seg0001 a  
Left Join seg00011 b 
    on a.usuid=b.usuid 
Where a.usuid='1234567' 
    and b.usuempc='901.023.461-1';  
    
    
 Select a.emppaic, a.UsuCed 
 Into  VPaisDo, VVended 
 from seg0001 a  
 Left Join seg00011 b 
    on a.usuid=b.usuid 
 Where a.usuid=VUsuario 
    and b.usuempc=Vempresa;
    
Select  Max(a.propre) 
--Into VValor 
from ven00012 a
Where a.VenEmpPai = '169' 
    and a.VenEmpC = '901.023.461-1' 
    and a.ProCod = 'CHUR-0001';
    
SELECT VEN00012.PROPRE
FROM VEN00012
WHERE VENEMPC = '901.023.461-1'
    AND LIPCOD = '01'
    AND PROCOD = 'SALAD-TOROCAESAR'
    
    
Select b.dedpor, proabr, rfpordto 
Into VPorIVA, VProdAli, VPorDes
       from ven0001 a
       Left Join cnt0014 b on a.FDedCod = b. dedcod and a.FDedSC =b.dedsubcod and a.FDedAno=b.dedano
       Where a.VenEmpPai = VPaisDo and a.VenEmpC = Vempresa and a.ProCod = Vprocod;
       
       
       
       
SELECT MAX(PEDNRO) + 1
	--  INTO V_NUMERO_PEDIDO
	FROM VEN0104;


SELECT VENEMPC
FROM VEN0001
WHERE PROCOD = 'SALAD-TOROCAESAR'          



Select proabr, rfpordto --16 , CURRASCO,3  
--Into VPorIVA, VProdAli, VPorDes
from ven0001 a
Where a.VenEmpPai = '169' 
    and a.VenEmpC = '901.023.461-1' 
    and a.ProCod LIKE 'SALAD-%';
    
    
    SELECT PROABR, RFPORDTO
	--INTO V_ALIAS_ITEM
	FROM VEN0001
	WHERE VEN0001.VENEMPPAI = '169'
		AND VEN0001.VENEMPC = '901.023.461-1'
		AND VEN0001.PROCOD = 'SALAD-TOROCAESAR';
		
    SELECT PEDPAIC, PEDEMPC, PEDCODDOC,PEDNRO,
		PEDLIN, PEDPROCOD, PEPC, PEC,
		CCOCOD, PEDUNI, PEDVAL, PEDVALCPI, 
		PEDPORIVA, PEDVALIVA, PEDVALTUN, PEDSUCDET,
		PEDALIAS, PEDPORDC, PEDDCVAL, PEDSAL
	FROM VEN0004
	
	
	Select a.emppaic 
	--Into  VPaisDo 
	from seg0001 a  
	Left Join seg00011 b 
        on a.usuid=b.usuid 
	Where a.usuid = '1234567' 
        and b.usuempc='901.023.461-1';   
        
        
    Select a.lipcod, b.lipnom  
    --Into VLisPre, VLisPreDesc 
    from ven00012 a 
    left Join gen0022 b 
        on a.lipcod=b.lipcod 
    Where a.VenEmpPai = '169' 
        and a.VenEmpC = '901.023.461-1' 
        and a.ProCod = 'CHUR-0001' 
        and a.propre=45200 
        and rownum <=1;   
        
    Select  Max(a.propre) 
    --Into VValor 
    from ven00012 a
    Where a.VenEmpPai = '169' 
        and a.VenEmpC = '901.023.461-1' 
        and a.ProCod = 'CHUR-0001'; 
        
    Select a.propre 
    --Into VValor 
    from ven00012 a
    Left Join  gen0022 b 
        on a.lipcod=b.lipcod
    Where  a.VenEmpC = '901.023.461-1' 
        and a.ProCod = 'CHUR-0001' 
        and b.lipnom Like '%'||'PRECIO ESPECIAL'||'%';
        
    Select lipnom 
    --Into VLisPreDesc 
    from gen0022 
    Where lipcod = '003';
    
    select  a.SucTerNom,a.CliFPC, a.suctertel,b.mponom,LiPCod 
    --Into VSuctern, VForPagCod, VTelClie, VCiudad, VLisPrec 
    From gen0024 a
    Left Join gen0003 b 
        on a.CliPaiCod = b.PaiCod 
        and a.CliDptCod = b.DptCod 
        and a.CliMpoCod = b.MpoCod
    where a.Clicod='15373820' and a.suctercod='01';
    
    Select 'S' 
    --Into VOk 
    from gen0016 -- formas de pago
    where ForPagCod = '01';
    
--==============================================================
-- DATOS
  VUSUARIO := '1234567';
  VDOCUMENTO := 'PD';
  VEMPRESA := '901.023.461-1';
  VCLIENTE := '15373820';
  VNUMDOC := NULL;
  VITEM := 1;
  VPROCOD:='CHUR-0001';
  VLisPreDesc:='Nada';
  VCantd:=1;
  VMesCod:=10;
  VPuesto:= '01';    
--==============================================================
-- PRECIOS SEGUM LOS CLIENTES

    Select  a.SucTerNom,a.CliFPC, a.suctertel,b.mponom,LiPCod 
    --Into VSuctern, VForPagCod, VTelClie, VCiudad, VLisPrec 
    --     PRINCIPAL, 01, 3157348576, CALI, 003
    From gen0024 a
    Left Join gen0003 b 
        on a.CliPaiCod = b.PaiCod 
        and a.CliDptCod = b.DptCod 
        and a.CliMpoCod = b.MpoCod
    where a.Clicod='15373820' and a.suctercod='01';
    
-- if vLIstPrec != null
    Select lipnom 
    --Into VLisPreDesc PRECIO ESPECIAL
    from gen0022 
    Where lipcod = 'PREC_ESP';


--si VLisPreDesc = ninguna hace: 
    Select  Max(a.propre) 
    --Into VValor  -- 45200
    from ven00012 a
    Where a.VenEmpPai = '169' 
        and a.VenEmpC = '901.023.461-1' 
        and a.ProCod = 'CHUR-0001';

    Select a.lipcod, b.lipnom  
    --Into VLisPre, VLisPreDesc  --01, venta sin descuento
    from ven00012 a 
    left Join gen0022 b 
        on a.lipcod=b.lipcod 
    Where a.VenEmpPai = '169' 
        and a.VenEmpC = '901.023.461-1' 
        and a.ProCod = 'CHUR-0001' 
        and a.propre=45200 
        and rownum <=1;    
            
-- si VlistPresDesc != ninguna
    Select a.propre 
    --Into VValor  -- null
    from ven00012 a
    Left Join  gen0022 b 
        on a.lipcod=b.lipcod
    Where  a.VenEmpC = '901.023.461-1'  
        and a.ProCod = 'CHUR-0001'   
        and b.lipnom Like '%'||'PRECIO ESPECIAL'||'%';
         
        
    Select *
    --Into VOk 
    from gen0016 
    where ForPagCod = '01';
    
    
    SELECT DISTINCT CATEDES, CATECOD 
    FROM INV0013
    
    SELECT *
    FROM GEN0006
    