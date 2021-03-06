<?php

/* @var $this \yii\web\View */
/* @var $content string */

use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\bootstrap\Dropdown;
use yii\widgets\Breadcrumbs;
use app\assets\AppAsset;


AppAsset::register($this);
?>
	<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?= Html::csrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
	<?= Html::jsFile('@web/js/modernizr.custom.js') ?>
</head>
<body class="bg-green cd-section">
	<?php $this->beginBody() ?>
	<?php @$events = $this->params['customParam']; ?>
<header id="header" class="clearfix">
	<nav id="menu" class="navbar">
		<div class="container-fluid">
			<div class="pull-right">
				<div class="content__icon-menu__aux">
					<div class="dropdown">
						<a href="#" data-toggle="dropdown" class="dropdown-toggle btn-menu-helper">
							<i class="material-icons">&#xE8FD;</i>
						</a>
						<ul class="dropdown-menu menu-profile menu-helper">
							<li class="mrg__bottom-5">
									<p class="sub-title text-center fnt__Medium">Notificaciones</p>
							</li>
							<li class="divider"></li>
							<li>
								<p class="sub-title cat-helper fnt__Medium">Mesas</p>
							</li>
							<li class="cnt-notification-helper">
								<div class="dis-inline-block">
									<p class="lb-notification-helper">Mesa libre</p>
								</div>
								<div class="dis-inline-block pull-right">
									<div class="notification-helper null"></div>
								</div>
							</li>
							<li class="cnt-notification-helper">
								<div class="dis-inline-block">
									<p class="lb-notification-helper">Mesa ocupada</p>
								</div>
								<div class="dis-inline-block pull-right">
									<div class="notification-helper full"></div>
								</div>
							</li>
							<li class="cnt-notification-helper">
								<div class="dis-inline-block">
									<p class="lb-notification-helper">-15 minutos de retraso</p>
								</div>
								<div class="dis-inline-block pull-right">
									<div class="notification-helper warning"></div>
								</div>
							</li>
							<li class="cnt-notification-helper">
								<div class="dis-inline-block">
									<p class="lb-notification-helper">+15 minutos de retraso</p>
								</div>
								<div class="dis-inline-block pull-right">
									<div class="notification-helper danger"></div>
								</div>
							</li>
							<li class="divider cat-helper"></li>
							<li>
								<p class="sub-title cat-helper fnt__Medium">Restaurantes</p>
							</li>
							<li class="cnt-notification-helper">
								<div class="dis-inline-block">
									<p class="lb-notification-helper">Pedido listo</p>
								</div>
								<div class="dis-inline-block pull-right">
									<div class="notification-helper c-full"></div>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div class="content__icon-menu__aux">
					<div class="dropdown">
						<a href="#" data-toggle="dropdown" class="dropdown-toggle menu-trigger menu-user"><i class="btn-menu-profile glyphicon glyphicon-option-vertical icon__24"></i></a>
						<ul class="dropdown-menu menu-profile">
							<li>
								<div class="dis-inline-block">
									<p class="txt-name fnt__Medium">usuario</p>									
								</div>
								<div class="dis-inline-block pull-right">
									<div class="content-avatar__menu-profile">
										<?= Html::img('@web/img/avatar.png', ['alt' => 'avatar', 'class' => 'img-avatar img-circle']) ?>
									</div>
								</div>
							</li>
							<li class="divider"></li>							
							<li>								
								<div class="pull-right">
								<?= Html::beginForm(['/site/salida'],
								'post', 
								['class' => 'form-inline']); ?>
								<?= Html::submitButton('Salir',['class' => 'btn btn-raised btn-default btn-sm']) ?>
								<?= Html::endForm() ?>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</nav>
</header>
<section class="scroller-inner">
	<section id="content">
		<div class="fluid-container main-content">
			<?= Breadcrumbs::widget([
				'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
			]) ?>
			<?= $content ?>
		</div>
	</section>
</section>
	<?php $this->endBody() ?>
</body>
</html>
	<?php $this->endPage() ?>
<?= Html::jsFile('@web/js/main.js') ?>
<script>
	/*
	 * Detectar Navegador móvil
	 */
	if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
	   $('html').addClass('mobile');
	}
</script>
<script>
  $(function () {
    $.material.init();
	$('[data-toggle="tooltip"]').tooltip();
	$(".slide-box-back .btn-toggle").click(function(){
	  $(".container-v").toggleClass("sld-in");
	});
	$("#help").modal("show");
	$("#swipeUp").click(function(){
	  $("#modVac").addClass("open-swipeUp");
	});
	$("#swipeDown").click(function(){
	  $("#modVac").removeClass("open-swipeUp");
	});
  });
</script>
<script>
		$('.ag-carousel.sec').flickity({
		  // options
		  setGallerySize: false,
		  cellAlign: 'left',
		  initialIndex: 0,
		  // contain: true,
		  pageDots: false,
		  dragThreshold: 10,
		});
		$('.ag-carousel').flickity({
		  // options
		  setGallerySize: false,
		  cellAlign: 'left',
		  initialIndex: 1,
		  // contain: true,
		  pageDots: false,
		  dragThreshold: 10,
		});		
</script>
<script>
	(function(){
        $('body').on('click', '#search', function(e){
            e.preventDefault();

            $('#header').addClass('search-toggled');
            $('.top-search-content input').focus();
        });

        $('body').on('click', '#search-close', function(e){
            e.preventDefault();

            $('#header').removeClass('search-toggled');
        });
    })();
</script>
<script>
	// new mlPushMenu( document.getElementById( 'mp-menu' ), document.getElementById( 'trigger' ), {
		// type : 'cover'
	// } );
</script>
<script>
	$(function () {
  
	// /////
	// MAD-SELECT
		var madSelectHover = 0;
		$(".mad-select").each(function() {
			var $input = $(this).find("input"),
				$ul = $(this).find("> ul"),
				$ulDrop =  $ul.clone().addClass("mad-select-drop");

			$(this)
			  .append('<i class="material-icons">arrow_drop_down</i>', $ulDrop)
			  .on({
			  hover : function() { madSelectHover ^= 1; },
			  click : function() { $ulDrop.toggleClass("show");}
			});

			// PRESELECT
			$ul.add($ulDrop).find("li[data-value='"+ $input.val() +"']").addClass("selected");

			// MAKE SELECTED
			$ulDrop.on("click", "li", function(evt) {
			  evt.stopPropagation();
			  $input.val($(this).data("value")); // Update hidden input value
			  $ul.find("li").eq($(this).index()).add(this).addClass("selected")
				.siblings("li").removeClass("selected");
			});
			// UPDATE LIST SCROLL POSITION
			$ul.on("click", function() {
			  var liTop = $ulDrop.find("li.selected").position().top;
			  $ulDrop.scrollTop(liTop + $ulDrop[0].scrollTop);
			});
		});

		$(document).on("mouseup", function(){
			if(!madSelectHover) $(".mad-select-drop").removeClass("show");
		});
		  
	});
</script>
<script>
	$(document).ready(function() {
		
		$('#calendar').fullCalendar({
			header: {
				left: 'prev',
				center: 'title',
				right: 'next'
			},
			height: 'auto',
			businessHours: true,
			editable: false,
			eventLimit: true, // allow "more" link when too many events
			selectable: true,
			selectHelper: true,
			selectOverlap: false,
			select: function(start, end) {
				
				$('#ModalAdd #start').val(moment(start).format('YYYY-MM-DD HH:mm:ss'));
				$('#ModalAdd #end').val(moment(end).format('YYYY-MM-DD HH:mm:ss'));
				$('#ModalAdd').modal('show');
				
			},
			eventRender: function(event, element) {
				element.bind('dblclick', function() {
					$('#ModalEdit #id').val(event.id);
					$('#ModalEdit #title').val(event.title);
					$('#ModalEdit #color').val(event.color);
					$('#ModalEdit').modal('show');
					
				});
			},
			eventDrop: function(event, delta, revertFunc) { // si changement de position

				edit(event);

			},
			eventResize: function(event,dayDelta,minuteDelta,revertFunc) { // si changement de longueur

				edit(event);

			},
			
			<?php
				if(isset($events)){			
			?>

			events: [
			
			<?php
								
			foreach($events as $event): 
			
				$start = explode(" ", $event['START']);
				$end = explode(" ", $event['END']);
				if($start[1] == '00:00:00'){
					$start = $start[0];
				}else{
					$start = $event['START'];
				}
				if($end[1] == '00:00:00'){
					$end = $end[0];
				}else{
					$end = $event['END'];
				}
			?>
				{
					id: '<?php echo $event['ID']; ?>',
					title: '<?php echo $event['TITLE']; ?>',
					start: '<?php echo $start; ?>',
					end: '<?php echo $end; ?>',
					color: '<?php echo $event['COLOR']; ?>',
					overlap: false,
					
					
				},
						
			<?php endforeach; ?>
					
			]
			
			<?php }; ?>
		});
		
		function edit(event){
			start = event.start.format('YYYY-MM-DD HH:mm:ss');
			if(event.end){
				end = event.end.format('YYYY-MM-DD HH:mm:ss');
			}else{
				end = start;
			}
			
			id =  event.id;
			
			Event = [];
			Event[0] = id;
			Event[1] = start;
			Event[2] = end;
			
			$.ajax({
			 url: 'editEventDate.php',
			 type: "POST",
			 data: {Event:Event},
			 success: function(rep) {
					if(rep == 'OK'){
						alert('Registro actualizado');
					}else{
						alert('El registro no fue guardado, intente de nuevo.'); 
					}
				}
			});
		}
		
	});

</script>
