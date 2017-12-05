------------------------------------------------------------------------------------------------------------------------------------------------
--											INSERT DETALLE

pedpaic			VPaisDo
pedempc			Vempresa
pedcoddoc		VDocumento
pednro			VPedNro
pednumdoc		VDocNrod
pedfech			sysdate
pedfece			sysdate
cotpaic			VPaisDo
cotempc			Vempresa
pclicod			VCliente 			SP_IN
pclinom			VTerRaz 			Select  a.TerRaz Into VTerRaz from gen0011 a Where a.tercod = VCliente;
psuccli			'01'				'01'
psucclin		VSuctern 			Select  a.SucTerNom,a.CliFPC, a.suctertel,b.mponom,LiPCod Into VSuctern, VForPagCod, VTelClie, VCiudad, VLisPrec From gen0024 Left Join gen0003 b on a.CliPaiCod = b.PaiCod and a.CliDptCod = b.DptCod and a.CliMpoCod = b.MpoCod  where a.Clicod=VCliente and a.suctercod='01'
pfpgcod			VForPagCod 			Select  a.SucTerNom,a.CliFPC, a.suctertel,b.mponom,LiPCod Into VSuctern, VForPagCod, VTelClie, VCiudad, VLisPrec From gen0024 Left Join gen0003 b on a.CliPaiCod = b.PaiCod and a.CliDptCod = b.DptCod and a.CliMpoCod = b.MpoCod  where a.Clicod=VCliente and a.suctercod='01'
pclicup			0					0
pdircod			VDirCliente 		Select Dircod, dirclidir Into VDirCliente,VDireccion from  ven0003 where clicod = VCliente and suctercod='01' and rownum <= 1;
pdirnom			VDireccion 			Select Dircod, dirclidir Into VDirCliente,VDireccion from  ven0003 where clicod = VCliente and suctercod='01' and rownum <= 1;
pedvencod		VVended
pedfac			'F'
pedlc			0
peddedt			0
pedfle			0
pedmodcod		'PEDIDO'
pedordcom		'01'
pedotm			'N'
pedtdeom		0
 psucclite		VTelClie 			Select  a.SucTerNom,a.CliFPC, a.suctertel,b.mponom,LiPCod Into VSuctern, VForPagCod, VTelClie, VCiudad, VLisPrec From gen0024 Left Join gen0003 b on a.CliPaiCod = b.PaiCod and a.CliDptCod = b.DptCod and a.CliMpoCod = b.MpoCod  where a.Clicod=VCliente and a.suctercod='01'
PDirCiud		VCiudad 			Select  a.SucTerNom,a.CliFPC, a.suctertel,b.mponom,LiPCod Into VSuctern, VForPagCod, VTelClie, VCiudad, VLisPrec From gen0024 Left Join gen0003 b on a.CliPaiCod = b.PaiCod and a.CliDptCod = b.DptCod and a.CliMpoCod = b.MpoCod  where a.Clicod=VCliente and a.suctercod='01'
usupaic			VPaisDo
usuempc			Vempresa
venusuario		VUsuario
mescod			VMesCod
PedHora			sysdate
pedbodcod		'GEN'

------------------------------------------------------------------------------------------------------------------------------------------------
--											INSERT DETALLE

pedpaic			VPaisDo
pedempc			Vempresa
pedcoddoc		VDocumento
pednro			VnumDoc
pedlin			VItem
pedprocod		Vprocod
pepc			VPaisDo
pec				Vempresa
peduni			VCantd
pedval			VValor
pedvalcpi		0
pedporiva		VPorIVA
pedvaliva		VValIva
pedvaltun		VValTun
pedsucdet		'01'
pedalias		VProdAli
pedpordc		VPorDes
peddcval		VValDesc
pedsal			'N'
ccocod			VPuesto
PedFacc			VCantd
PedBodL			'GEN'
