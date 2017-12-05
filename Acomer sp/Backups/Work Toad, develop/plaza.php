<?php
use yii\helpers\Url;
use yii\helpers\Html;
use yii\widgets\ActiveForm;
?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<div class="main">
	<img src="img/plaza.png" alt="" class="img-responsive base">
	<div class="content-mesas" id='mesasPlaza'>

	</div>
</div>
		

<script type="text/javascript">
	$(tiempoReal());

	function tiempoReal(){
		$.ajax({
			url:'<?php echo Url::toRoute(['site/jsonmesas']); ?>',
			dataType:'json',
			success: function (data) {		
				//cantidad de datos que contiene cada array del json	
				var tamano = Object.keys(data.COD_MESA).length;			
				//un arrray contiene en arrays de cada columna devuelta por el json (consulta hecha a base de datos)
				var arrayDatos = $.map(data, function(value, index) {
	    			return [value];
				});				
				//
				//console.log(arrayDatos);
				//almaceno los valores pertenecientes al codigo de las mesas
				var codigosMesas = arrayDatos[0];
				//almaceno los valores pertenecientes al estado de las mesas
				var estadosMesas = arrayDatos[1];
				//almaceno los valores pertenecientes al codigo de la empresa a la que pertenecen las mesas
				var empresaMesas = arrayDatos[2];
				//almaceno los valores pertenecientes la posicion de las mesas
				var posicionesMesas = arrayDatos[3];
				//almaceno los valores pertenecientes al codigo de las mesas
				var puestosMesas = arrayDatos[4];
				//formato para mostrar las mesas en la plaza
				var esquemaTotal;
				//complementa el esquema para mostrar las mesas
				for (var i = 0; i < tamano; i++) {
					var esquemaTemporal = '<img src="img/mesa.svg" alt="" class="mesas '+posicionesMesas[i]+'" title="'+estadosMesas[i]+'-'+codigosMesas[i]+'">';
					if(!esquemaTotal){
						esquemaTotal = esquemaTemporal;
					}else{
						esquemaTotal = esquemaTotal + esquemaTemporal;
					}
					
					
				}				

				//muestros las mesas en la plaza
				document.getElementById("mesasPlaza").innerHTML = esquemaTotal;
			}
		});
	}setInterval(tiempoReal, 1000);

</script>