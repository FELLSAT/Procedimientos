<?php
	use yii\helpers\Html;
	use app\assets\AppAsset;
	use yii\bootstrap\ActiveForm;
	use yii\bootstrap\Alert;
	use yii\helpers\Url;

	AppAsset::register($this);

	$this->title = 'Acomer';

	$request = Yii::$app->request;

?>

<?php 
	$this->beginPage() 
?>

<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>" class="no-js">
	<head>
	    <meta charset="<?= Yii::$app->charset ?>">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <?= Html::csrfMetaTags() ?>
	    <title><?= Html::encode($this->title) ?></title>
	    <?php $this->head() ?>
		<script src="js/modernizr-custom.js"></script>
	</head>
	<body class='bg-acomer'>
	<?php $this->beginBody() ?>
		<div class="compare-basket">
			<button class="actions action--button action--compare"><i class="fa fa-check"></i><span class="action__text">Agregar al pedido</span></button>
		</div>
		<div class="content-main">
			<div id="slideshow" class="slideshow">
			<?php $id_content_count = 0;?> <!--VARIABLE PARA ASIGNAR EL ID DEL DIV QUE CONTIENE LOS PLATOS-->
			<?php $id_quant = 1;?>	<!--VARIABLE PARA ASIGNAR EL CONSECUTIVO DEL ARRAY QUANT-->
			<?php foreach ($categorias as $ketc): ?>
				<div class="slide">
					<h2 class="slide__title slide__title--preview"><?php echo $ketc['DESCRIPCION']?></h2>
					<div class="slide__item">
						<div class="slide__inner">
							<img class="slide__img slide__img--small" src="img/categorias/parrilla.png" alt="Carnes a la Parrilla" />
							<button class="action action--open" aria-label="View details"><i class="material-icons">&#xE145;</i></button>
						</div>
					</div>
					<div class="slide__content">
						<div class="slide__content-scroller">
							<!--Inicia para agregar los tipos de comidas-->
							<div class="slide__details">
								<h2 class="slide__title slide__title--main"><?php echo $ketc['DESCRIPCION']?></h2>
								<!--SI LA CATEGORIA ES BEBIDA  LA DESCRIPCION ES DISTINTA-->
								<?php if ($ketc['DESCRIPCION']=='Bebidas'): ?>
									<p class="slide__description">Descripción de <?php echo $ketc['DESCRIPCION']?></p>
								<?php else: ?>
									<p class="slide__description">Descripción comida de <?php echo $ketc['DESCRIPCION']?></p>
								<?php endif ?>
							</div>

							<!--termina para agregar los tipos de comidas-->

							<!--inicia agregar platos a la categoria perteneciente-->							
							<div class="content">
								<div class="grid">								
								<?php foreach ($comidas as $keyco): ?>								
									<?php if ($keyco['CATEGORIA']==$ketc['COD_CATEGORIA']): ?>
										<div class="product">
											<div class="product__info">
												<img class="product__image" src="img/items/carne.png" alt="Carne" />
												<h3 class="product__title"><?=$keyco['NOMBRE']?></h3>
												<span class="product__year extra highlight">2017</span>
												<span class="product__region extra highlight">Douro</span>
												<span class="product__varietal extra highlight">Touriga Nacional</span>
												<span class="product__alcohol extra highlight">13%</span>
												<span class="product__price highlight">$<?php echo number_format($keyco['PRECIO']);?></span>
												<div class="content-count" id="<?php echo $id_content_count; ?>">
													<div class="input-group">
														<span class="input-group-btn">
															<button type="button" class="btn btn-default btn-number" disabled="disabled" data-type="minus" data-field="quant[<?php echo $id_quant; ?>]">
																<span class="glyphicon glyphicon-minus"></span>
															</button>
														</span>
														<input type="text" name="quant[<?php echo $id_quant; ?>]" class="form-control input-number" value="1" min="1" max="10">
														<span class="input-group-btn">
															<button type="button" class="btn btn-default btn-number plus" data-type="plus" data-field="quant[<?php echo $id_quant; ?>]">
																  <span class="glyphicon glyphicon-plus"></span>
															</button>
														</span>
													</div>
												</div>
												<label class="actions action--button action--compare-add" id="45"><input class="check-hidden" type="checkbox" /><i class="fa fa-plus"></i><i class="fa fa-check"></i><span class="action__text">Agregar</span></label>
											</div>
										</div>
										<?php $id_content_count += 1; ?>
										<?php $id_quant += 1; ?>
									<?php endif ?>
								<?php endforeach ?>
								</div>
							</div><!-- content -->
								

							<!--termina agregar platos a la categoria perteneciente-->
							
							<section class="compare">
								<button class="actions action--close-compare"><i class="fa fa-remove"></i><span class="action__text action__text--invisible">Close comparison overlay</span></button>
							</section>
						</div><!-- slide__content-scroller 1 -->
					</div><!-- slide__content 1 -->
				</div>
			<?php endforeach ?>
			
	<?php $this->endBody() ?>
		<script>
			(function() {
				var slideshow = new CircleSlideshow(document.getElementById('slideshow'));
			})();
		</script>
	</body>
</html>
<?php $this->endPage() ?>