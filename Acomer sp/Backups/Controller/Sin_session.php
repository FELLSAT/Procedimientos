<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\filters\VerbFilter;
use app\models\IndexForm;
use app\models\AsignaForm;
use yii\widgets\ActiveForm;
use yii\web\Response;
use yii\helpers\Html;
use yii\data\Pagination;
use yii\helpers\Url;
use PDO;
use app\models\SpLoginAcomer;
use app\models\SpContratosAcomer;
use app\models\RememberForm;
use app\models\PrbUsuario;
use app\models\Ldap;
use app\models\SpMesasPlaza;
use app\models\SpMenusPlaza;
use app\models\SpMesasPedidos;
use app\models\funcionesArray;
use app\models\SpMesasFactura;
use app\models\SpCocinaPedidos;


class SiteController extends Controller
{   


    public function actionPrueba(){     
        
        
        return $this->render('prueba'); 
    }   
    
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout'],
                'rules' => [
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    public function actionIndex()
    {
        //variable para etiquetas de recordar contraseña en caso de que no se utilice directorio activo
        $recordar = null;
        
        $this->layout=false;                
        //modelo delos datos ingresados (usuario y contraseña) 
        $model = new IndexForm(); 
        //modelo de recuperar contraseña
        $model2 = new RememberForm();
        //Se declara la clase de directorio activo
        //$modeladp = new Ldap;
        ///Acciona el metodo directorioactivo retornando los datos pertienen al directorio activo en caso de ser usado
        //$ladpcon = $modeladp->directorioactivo();
        $ladpcon = array("","","false");
        
        //si no posee directorio activo permite la recuperacion de la contraseña
        if($ladpcon[2]=="false"){
            //etiquetas para recuperar contraseña en vista 
            $recordar = "<a class='color-white' href='' data-toggle='modal' data-target='#recordarpass'>Olvidaste tu contraseña?</a>";
        }

    //===================================INICIA RECORDAR CONTRASEÑA =======================================
        //la validacion del modelo (que el campo este correctamente)
        //Validación mediante ajax - si es de tipo ajax
        if($model2->load(Yii::$app->request->post()) && Yii::$app->request->isAjax){
            //respuesta en formato json
            Yii::$app->response->format = Response::FORMAT_JSON;
            //retorna el modelo como valido 
            return ActiveForm::validate($model2);           
        }
        
        if($model2->load(Yii::$app->request->post())){
            //valida que el modelo si es valdo
            if($model2->validate()){        
                //redireccionamos a la accion para el olvido de contraseña
                return $this->redirect(['site/olvidapassword','usuario'=>$model2->cedula,'operacion'=>'U']);                
            }else{                
                 return $this->goBack();                 
            }
        }       
    //===================================TERMINA RECORDAR CONTRASEÑA=======================================
        

    //===================================INICIA VALIDACION PARA USUARIO Y CONTRASEÑA=======================================        
        //la validacion del modelo (que los los campos esten correctamente)
        //Validación mediante ajax - si es de tipo ajax
        if($model->load(Yii::$app->request->post()) && Yii::$app->request->isAjax){
            // respuesta en formato json
            Yii::$app->response->format = Response::FORMAT_JSON;
            //retorna el modelo como valido
            return ActiveForm::validate($model);            
        }
        
        if($model->load(Yii::$app->request->post())){
            //Valida que el modelo si es valido
            if($model->validate()){         
                // retorna a la vista de loguep     
                return $this->redirect(['site/logueo','usuario'=>$model->usuario,'clave'=>$model->clave,'operacion'=>'L']);         
            }else{          
                return $this->goBack();          
            }       
        }
    //===================================TERMINA VALIDACION PARA USUARIO Y CONTRASEÑA=======================================


    //===================================INICIA VALIDAR QUE LA SESION SIGUE ABIERTA=======================================          
        //Valida que la variable de sesion cedula no este vacia indicando que hay una sesion abierta
        if(isset(Yii::$app->session['cedula'])){
            //redireccionamos a la pantalla principapl 
            return $this->redirect(['site/principal']);
        }else{
            //renderizamos el index
            return $this->render('index', ['model' => $model,'model2' => $model2,'recordar' => $recordar]);        
        }
    //===================================INICIA VALIDAR QUE LA SESION SIGUE ABIERTA=======================================          
    }

    public function actionLogueo()
    {   
        //Declaracion de  directorio activo
        //$modeladp = new Ldap;        
        ///Acciona el metodo directorioactivo retornando los datos pertienen al directorio activo en caso de ser usado         
        //$ladpcon = $modeladp->directorioactivo();
        $ladpcon = array("","","false");
        //si hay un usuario con el id ingresado y el directorio activo esta activo
        if(isset($ladpcon[0]) && $ladpcon[2]=='true'){
            //la variable de sesion cedula le asigno el identificador del usuario
            Yii::$app->session['cedula'] = $ladpcon[0];
            // redireccionado a la pantalla principal una vez los datos son correctos
            return $this->redirect(['site/principal']);
        //si se recibio un error y el directorio activo esta activo
        }elseif(isset($ladpcon[1]) && $ladpcon[2]=='true'){
            //redireccionamos al inicio de sesion y enviamos como parametro el error arrojado al iniciar sesion
            return $this->redirect(['site/index', "error"=>$ladpcon[1]]);
        //si el directorio activo no esta activo
        }elseif($ladpcon[2]=='false'){
            //declaramos la clase del procemiento para login acomer
            $model = new SpLoginAcomer;
            //llamamos la funcion que ejecuta el procedimeinto almacenado 
            $spLoginAcomer = $model->procedimiento();
            //si el codigo de mensaje enviado por el procedimiento es igual a 2
            if($spLoginAcomer[1]=="2"){
                //redireccinamos 
                return $this->redirect(['site/asignapassword',"error"=>$spLoginAcomer[2]]);                
            //si el codigo d mensaje enviado por el procedimiento es igual a 1
            }elseif($spLoginAcomer[1]=="1"){
                //La variable de sesion cedula es asignada con el valor de la cedula que retorna el procedimiento 
                Yii::$app->session['cedula']=$spLoginAcomer[0];
                //redirecciona a la pantalla principal una vez los datos son correctos                
                return $this->redirect(['site/principal',"message"=>$spLoginAcomer[2]]);                
            //Si el codigo de mensaje enviado por el procedimiento es igual a 0
            }elseif($spLoginAcomer[1]=="0"){
                //redireccionamos al incio de sesion con 
                return $this->redirect(['site/index',"activate"=>$spLoginAcomer[2],'usuario'=>Yii::$app->request->get('usuario'), 'clave'=>Yii::$app->request->get('clave')]);
            }else{
                //redireccinamos al index con el error 
                return $this->redirect(['site/index',"error"=>$spLoginAcomer[2]]);
            }
        }else{
            //redireccionamos al index con el error de conexion
            return $this->redirect(['site/index',"error"=>"No hay conexion, por favor contacte con el administrador"]);
        }        
    }

    public function actionOlvidapassword()
    {
        //declaramos la clase del procemiento para login acomer
        $model = new SpLoginAcomer;
        //llamamos la funcion que ejecuta el procedimeinto almacenado 
        $spLoginAcomer = $model->procedimiento();
        //Si el codigo devuelto por el procedimiento es 9
        if($spLoginAcomer[1]=="9"){
            //redirecccioinamos al index con el mensaje devuelto respectivo a lo accionado
            return $this->redirect(['site/index', "remember"=>$spLoginAcomer[2]]);
        //si el codigo devuelto por el procedimeinto es 0
        }elseif($spLoginAcomer[1]=="0"){
            //redireccionamos al index con el error respectivo al codigo 0
            return $this->redirect(['site/index', "error"=>$spLoginAcomer[2]]);
        // si el codigo devuelto no es 9 ni 0
        }else{
            //redireccionamos al index con el error arrojado
            return $this->redirect(['site/index', "error"=>$spLoginAcomer[2]]);
        }
    }

    public function actionAsignapassword(){
        $this->layout=false;
        //modelo de los datos ingresdos
        $modelform = new AsignaForm();
        //declaramos la clase del procemiento para login acomer
        $model = new SpLoginAcomer;
        //llamamos la funcion que ejecuta el procedimeinto almacenado 
        $spLoginAcomer = $model->procedimiento();      
        //la validacion del modelo (que el campo este correctamente)
        //Validación mediante ajax - si es de tipo ajax
        if($modelform->load(Yii::$app->request->post()) && Yii::$app->request->isAjax){
            //Respuesta en formato json
            Yii::$app->response->format = Response::FORMAT_JSON;
            //el modelo es retornado como valido
            return ActiveForm::validate($modelform);            
        }
        
        if($modelform->load(Yii::$app->request->post())){
            //si el modelo es valido 
            if($modelform->validate()){     
                //redireccionamos a validapassword  
                return $this->redirect(['site/validapassword','clave'=>$modelform->nuevaclave, 'tokenreset'=>Yii::$app->request->get('tokenreset') , 'usuario'=>Yii::$app->request->get('usuario'), 'operacion'=>'F']);            
            }   
        }
        
        //si el codigo devuelto por el procedimiento es 10
        if($spLoginAcomer[1]=="10"){
            //renderizamos asignapassword
            return $this->render('asignapassword',['model' => $modelform]);
        //si el codigo devuelto por el procedimiento es 11
        }elseif($SpLoginAcomer[1]=="11"){            
            return $this->redirect(['site/index', "error"=>$SpLoginAcomer[2]]);   
        //si el codigo devuelto no es ni 10 ni 11         
        }else{            
            return $this->redirect(['site/index', "error"=>$SpLoginAcomer[2]]);            
        }
    }

    public function actionValidapassword()
    {
        //declaramos la clase del procedimiento para login acomer
        $model = new SpLoginAcomer;
        //llamamos la funcion que ejecuta el procedimeinto almacenado 
        $spLoginAcomer = $model->procedimiento();
        //si el codigo devuelto por el procedimiento es 1
        if($spLoginAcomer[1]=="1"){
            //declara la variable de sesion cedula con el valor de la cedula del usuario que ingreso
            Yii::$app->session['cedula'] = $spLoginAcomer[0];
            //redireccionamos a la pantalla principal
            return $this->redirect(['site/principal', "message"=>$spLoginAcomer[2]]);
        // de lo contrario
        }else{
            //redireccionamos 
            return $this->redirect(['site/asignapassword', "error"=>$spLoginAcomer[2], 'tokenreset'=>Yii::$app->request->get('tokenreset') , 'usuario'=>Yii::$app->request->get('usuario'), 'operacion'=>'T']);
        }   
    }

    public function actionPrincipal(){
        //si hay una sesion abierta
        if (isset(Yii::$app->session['cedula'])){
            //cedula ingresada
            $cedula = $_SESSION['cedula'];

            $fn_login = new SpLoginAcomer();
            $rol = $fn_login->procedimiento2($cedula);

            if($rol === 'MESERO'){
                return $this->redirect(['site/plaza']);
            }else if($rol === 'COCINERO'){
                return $this->redirect(['site/cocina']);
            }            
        }else{                                        
            //retornamos al index
            return $this->goHome();                                        
        }
    }


    public function actionSalida()
    {
        //Elimino session de la cedula que es el parametro principal
        Yii::$app->session['cedula'];
        
        Yii::$app->session->destroy();
        
        return $this->goHome();
    }
    
    public function actionPlaza()
    {         
        if(!isset(Yii::$app->session['cedula'])){
            return $this->goHome();                                        
        }else{
            $cedula = $_SESSION['cedula'];

            $fn_login = new SpLoginAcomer();
            $rol = $fn_login->procedimiento2($cedula);

            if($rol === 'COCINERO'){
                return $this->redirect(['site/cocina']);
            }
        }

        //==========================================================
        //codigos de los container
        $fn_plaza = new SpMesasPlaza();
        $codigos = $fn_plaza->procedimiento2();   
        $container1 = $codigos[0];  
        $container2 = $codigos[1]; 
        $container3 = $codigos[2]; 
        $container4 = $codigos[3]; 
        //==========================================================


        return $this->render('plaza', ["container1"=>$container1, "container2"=>$container2, "container3"=>$container3,
                                       "container4"=>$container4, "rol"=>$rol]);      
    }

    public function actionJsonmesas(){
        $fn_mesas = new SpMesasPlaza;
        //obtiene las posiciones de las mesas 
        $datosMesas = $fn_mesas->procedimiento(); 
        //imprime los datos en tipo json         
        echo json_encode($datosMesas);
    }

    public function actionJsonpedidos(){
        $fn_pedidos = new SpMesasPedidos;
        //obtiene las posiciones de las mesas 
        $datosPedidos = $fn_pedidos->procedimiento(); 
        //imprime los datos en tipo json         
        echo json_encode($datosPedidos);
    }

    public function actionEntregarpedido(){
        $c1 = explode("*_", $_GET['puestos']);
        $c2 = explode("*_", $_GET['platos']);
        $c3 = $_GET['documento'];
        $c4 = $_GET['empresa'];

        $fn_mesas = new SpMesasPlaza();
        $fn_mesas->procedimiento3($c1,$c2,$c3,$c4);
    }

    public function actionJsonpuestosfac(){
        //parametros pasados por GET
        $c1 = $_GET['mesa'];

        $fn_fac_puestos = new SpMesasFactura;
        //obtiene las posiciones de las mesas 
        $puestos = $fn_fac_puestos->procedimiento($c1); 
        //imprime los datos en tipo json         
        echo json_encode($puestos);
    }

    public function actionJsonpuestosfacx(){
         //parametros pasados por GET
        $mesa1 = $_GET['mesa1'];
        $mesa2 = $_GET['mesa2']; 

        if($mesa2 == 'undefined'){
            session_start()   ;
            if(is_array($_SESSION['mesa1'])){
                $mesa2 = $_SESSION["mesa1"][0];
            }else{
                $mesa2 = $_SESSION["mesa1"];
            }
        }
        $fn_fac_puestos = new SpMesasFactura;
        //obtiene las posiciones de las mesas 
        $puestos1 = $fn_fac_puestos->procedimiento($mesa1); 
        $puestos2 = $fn_fac_puestos->procedimiento($mesa2); 
        //array que va a contener los dos resultados de las mesas
        $puestosTotal = array($puestos1, $puestos2);
        //imprime los datos en tipo json         
        echo json_encode($puestosTotal);
    }

    public function actionMesa()
    {   
        //=============================DATOS ENVIADOS POR GET=======================================
        //codigo de la mesa 
        if(!isset($_GET['codigoM'])){
            $this->layout=false;    
            return $this->redirect(['site/plaza']); 
        }else{
            $codigomesa = $_GET['codigoM'];  
        }
       
        //datos enviados desde la plaza
        if(!isset($_GET['estadoM'])){
            $estadomesa = 1;
        }else{
            $estadomesa = $_GET['estadoM'];
        }        

        //datos enviados desde el menu
        if(!isset($_GET['platos'], $_GET['cantidad'], $_GET['puestos'])){
            $platos = 0;
            $cantidad = 0;
            $puestos = 0;
            $arrpuestos = 0;
        }else{
            $platos = $_GET['platos'];
            $cantidad = $_GET['cantidad'];            
            $puestos = $_GET['puestos'];
            // acomodar el array de los puestos
            $funciones1 = new funcionesArray();
            $funciones2 = $funciones1->crearArray($_GET['puestos']);
            $arrpuestos = $funciones1->arrayNuevo(array_unique($funciones2));
            $arrpuestos = $funciones1->arrayToChar($arrpuestos);

            $tamano = $_GET['tamanoM']; //tamano de la mesa que se esta usando
        }

        if(!isset($_GET['tamanoM'])){            
            $tamano = 4;
        }else{
            $tamano = $_GET['tamanoM'];
        }


        $model = new SpMesasPedidos();        
        // se crea la ession correspondiente para las mesas unidas
        if($tamano >= 5 && $tamano <= 6 && $plato = 0){
            $mesasUnidas = $model->procedimiento3($codigomesa);
            $mesaSecundaria = $mesasUnidas[0]['MESCODUNI'][0];
            //inicia la session y se crea la mesa secundaria
            session_start();
            $_SESSION['mesa1'] = $mesaSecundaria ; 
        }


        // si el estado es ocupado ya hay pedido confirmado 
        // y se consulta lo que se ha pedido
        if($estadomesa === '0'){
            $confirmados = 1;
        }else{
            $confirmados = 0;
        }
        //=============================DATOS ENVIADOS POR GET=======================================
        


        
        $this->layout=false;    
        return $this->render('mesa',["estadomesa" => $estadomesa, "codigomesa" => $codigomesa,
                                     "platos" => $platos, "cantidad" => $cantidad, "puestos" => $puestos,
                                     "tamano" => $tamano, "arrpuestos" => $arrpuestos, 
                                     "confirmados" => $confirmados]);
        
    }
   

    public function actionVarsesions(){
        //cantidad de personas en la mesa
        $tamano = $_GET['tamano'];

        // dependiendo del tamano de la mesa se crear n variables de session
        if($tamano > 4 && $tamano <= 6){
            if(session_status() != 1){
                session_destroy();
            } 

            session_start(); 
            //modifica la variable con la mesa correspondiente
            if(is_array($_GET['mesa1'])){
                $_SESSION['mesa1'] = $_GET['mesa1'][0];
            }else{
                $_SESSION['mesa1'] = $_GET['mesa1'];  
            }
            
            echo $_SESSION["mesa1"];
        }
        
    }


    public function actionJsonmesasunidas(){
        $in_var = $_GET['mesaclick'];

        $clase = new SpMesasPedidos();
        $procedimiento = $clase->procedimiento3($in_var);
        $a = $procedimiento[0];
        $b = $procedimiento[1];

        $c = arraY($a,$b);
        echo json_encode($c);
    }

    public function actionRealizarpedido(){
        //c1: Variable correspondiente al arraY de los puestos  
        //c2: Variable correspondiente al arraY de los platos
        //c3: Variable correspondiente al arraY de la cantidad
        //c4: Variable correspondiente al arraY del termino
        //c5: Variable correspondiente alcodigo del mesero
        //c6: Variable correspondiente al arraY al codigo de la mesa
        
        //capturas los datos enviados por get
        $get1 = $_GET['puestos'];
        $get2 = $_GET['platos'];
        $get3 = $_GET['cantidad'];
        $get4 = $_GET['termino'];        
        $get5 = '16743485';//$_SESSION['cedula'];
        $get6 = $_GET['mesa'];
        
        $funcionArr = new funcionesArray();
        //
        $c1 = $funcionArr->crearArray($get1);
        $c1 = $funcionArr->arrayPuestos($c1);
        $c2 = $funcionArr->crearArray($get2);
        $c3 = $funcionArr->crearArray($get3);
        $c4 = $funcionArr->arrayTermino($get4);
        $c5 = $get5;//$_SESSION['cedula'];
        $c6 = $get6;


        //return $this->redirect(['site/prueba','c1'=>$c1,'c2'=>$c2,'c3'=>$c3,'c4'=>$c4,'c5'=>$c5,'c6'=>$c6]);   
        
        $pedido = new SpMesasPedidos();
        $tomarpedido = $pedido->procedimiento2($c1,$c2,$c3,$c4,$c5,$c6);

        return $this->redirect(['site/plaza']);

    }

    public function actionAdicionarpedido(){
        //c1: Variable correspondiente al arraY de los puestos  
        //c2: Variable correspondiente al arraY de los platos
        //c3: Variable correspondiente al arraY de la cantidad
        //c4: Variable correspondiente al arraY del termino
        //c5: Variable correspondiente alcodigo del mesero
        //c6: Variable correspondiente al arraY al codigo de la mesa
        
        //capturas los datos enviados por get
        $get1 = $_GET['puestos'];
        $get2 = $_GET['platos'];
        $get3 = $_GET['cantidad'];
        $get4 = $_GET['termino'];        
        $get5 = '16743485';//$_SESSION['cedula'];
        $get6 = $_GET['mesa'];
        
        $funcionArr = new funcionesArray();
        //
        $c1 = $funcionArr->crearArray($get1);
        $c1 = $funcionArr->arrayPuestos($c1);
        $c2 = $funcionArr->crearArray($get2);
        $c3 = $funcionArr->crearArray($get3);
        $c4 = $funcionArr->arrayTermino($get4);
        $c5 = $get5;//$_SESSION['cedula'];
        $c6 = $get6;

        echo "paila";

        //return $this->redirect(['site/prueba','c1'=>$c1,'c2'=>$c2,'c3'=>$c3,'c4'=>$c4,'c5'=>$c5,'c6'=>$c6]);   
        
        $pedido = new SpMesasPedidos();
        $tomarpedido = $pedido->procedimiento4($c1,$c2,$c3,$c4,$c5,$c6);

        return $this->redirect(['site/plaza']);
    }

    public function actionRealizarpedidox(){
        // Mesa 1
        //c1: Variable correspondiente al arraY de los puestos  
        //c2: Variable correspondiente al arraY de los platos
        //c3: Variable correspondiente al arraY de la cantidad
        //c4: Variable correspondiente al arraY del termino
        //c5: Variable correspondiente alcodigo del mesero
        //c6: Variable correspondiente al codigo de la mesa
        // mesa 2
        //c7: Variable correspondiente al arraY de los puestos  
        //c8: Variable correspondiente al arraY de los platos
        //c9: Variable correspondiente al arraY de la cantidad
        //c10: Variable correspondiente al arraY del termino
        //c11: Variable correspondiente alcodigo del mesero
        //c12: Variable correspondiente al arraY al codigo de la mesa
        //
        // union de las mesas
        // c13: variable correspondiente a la mesa principal
        // c14: variable correspondiente al numero de personas 
        // c15: variable correnpondiente a las mesas que se van a unir
        
        //capturas los datos enviados por get   
        //pedido para la mesa principal     
        $get1 = $_GET['puestos1'];
        $get2 = $_GET['platos1'];
        $get3 = $_GET['cantidad1'];
        $get4 = $_GET['termino1'];        
        $get5 = '16743485';//$_SESSION['cedula'];
        $get6 = $_GET['mesa1'];        
        $get7 = $_GET['mesa2'];
        
        $fn_arrays = new funcionesArray();

        //0: dos mesas unidas
        //1: tres mesas unidad
        if($_GET['tamano'] === '0'){
            $arrayMesa1 = $fn_arrays->arrayPorPuesto($get1,$get2,$get3,$get4,'1');
            $arrayMesa2 = $fn_arrays->arrayPorPuesto($get1,$get2,$get3,$get4,'2');
            
            // variables de la mesa 1
            $c1 = $arrayMesa1[0];
            $c1 = $fn_arrays->arrayPuestos($c1);
            $c2 = $arrayMesa1[1];
            $c3 = $arrayMesa1[2];
            $c4 = $arrayMesa1[3];
            $c5 = $get5;
            $c6 = $get6;

            // variables de la mesa 2
            $c7 = $arrayMesa2[0];
            $c7 = $fn_arrays->arrayPuestos($c7);
            $c8 = $arrayMesa2[1];
            $c9 = $arrayMesa2[2];
            $c10 = $arrayMesa2[3];
            $c11 = $get5;
            $c12 = $get7;

            // variables de union
            $c13 = $get6;
            $c14 = '6';
            $c15 =  array($get7);

            // se realiza el pedido
            $pedido1 = new SpMesasPedidos();
            $tomarpedido1 = $pedido1->procedimiento5($c1,$c2,$c3,$c4,$c5,$c6,$c7,$c8,$c9,$c10,$c11,$c12,$c13,$c14,$c15);

            var_dump($c7); echo '<br>';
            var_dump($c8); echo '<br>';
            var_dump($c9); echo '<br>';
            var_dump($c10); echo '<br>';
                echo($c11); echo '<br>';
                echo($c12); echo '<br>';
            
        }else if($_GET['tamano'] === '1'){
            //toma de pedido con el procedimiento para 3 mesas unidas
            echo 'a';
        }        
        
        return $this->redirect(['site/plaza']);

    }

    public function actionAdicionarpedidox(){
        // Mesa 1
        //c1: Variable correspondiente al arraY de los puestos  
        //c2: Variable correspondiente al arraY de los platos
        //c3: Variable correspondiente al arraY de la cantidad
        //c4: Variable correspondiente al arraY del termino
        //c5: Variable correspondiente alcodigo del mesero
        //c6: Variable correspondiente al codigo de la mesa
        // mesa 2
        //c7: Variable correspondiente al arraY de los puestos  
        //c8: Variable correspondiente al arraY de los platos
        //c9: Variable correspondiente al arraY de la cantidad
        //c10: Variable correspondiente al arraY del termino
        //c11: Variable correspondiente alcodigo del mesero
        //c12: Variable correspondiente al arraY al codigo de la mesa
        
        //capturas los datos enviados por get
        $get1 = $_GET['puestos1'];
        $get2 = $_GET['platos1'];
        $get3 = $_GET['cantidad1'];
        $get4 = $_GET['termino1'];        
        $get5 = '16743485';//$_SESSION['cedula'];
        $get6 = $_GET['mesa1'];        
        $get7 = $_GET['mesa2'];

        $fn_arrays = new funcionesArray();
        $fn_adicion = new SpMesasPedidos();

        if($_GET['tamano'] === '0'){
            //los arrays correspondientes a la mesa 1
            $arrayMesa1 = $fn_arrays->arrayPorPuesto($get1,$get2,$get3,$get4,'1');
            $c1 = $fn_arrays->arrayPuestos($arrayMesa1[0]);
            $c2 = $arrayMesa1[1];
            $c3 = $arrayMesa1[2];
            $c4 = $arrayMesa1[3];
            $c5 = $get5;
            $c6 = $get6;

            //los arrays correspondientes a la mesa 2
            $arrayMesa2 = $fn_arrays->arrayPorPuesto($get1,$get2,$get3,$get4,'2');
            $c7  = $fn_arrays->arrayPuestos($arrayMesa2[0]);
            $c8  = $arrayMesa2[1];
            $c9  = $arrayMesa2[2];
            $c10 = $arrayMesa2[3];
            $c11 = $get5;
            $c12 = $get7;

            // si la adicion a la mesa uno es nula no se ejecuta el procedimiento 
            if(count($arrayMesa1[0]) !== 0){
                $adicionMesa1 = $fn_adicion->procedimiento4($c1,$c2,$c3,$c4,$c5,$c6);
            }      

            // si la adicion a la mesa dos es nula no se ejecuta el procedimiento 
            if(count($arrayMesa2[0]) !== 0){
                $adicionMesa2 = $fn_adicion->procedimiento4($c7,$c8,$c9,$c10,$c11,$c12);
            }                  

        }else if($_GET['tamano'] === '1'){
            //toma de pedido con el procedimiento para 3 mesas unidas
            echo 'a';
        }  
        

        return $this->redirect(['site/plaza']);
    }

    public function actionCancelarpedido(){
        //$c1: tipo de cancelacion 0: plato 1: todo el pedido
        //$c2: codigo de la mesa donde se va hacer la cancelacion
        //$c3: codigo del plato que se va a cancelar
        //$c4: cantidad que se va a cancelar
        //$c5: puesto del plato donde se va a cancelar  
        //$c6: codigo del mensaje 0: correcto , 1: error         
        
        // codigo de la mesa que 
        $c1 = 0;
        $c2 = $_GET['mesa'];
        $c3 = array($_GET['plato']);
        $c4 = array($_GET['cantidad']);
        $c5 = array($_GET['puesto']);
        $c6 = 1;
               
        $fn_cancelar = new SpMesasPedidos();
        $c6 = $fn_cancelar->procedimiento8($c1,$c2,$c3,$c4,$c5);
        
        /*echo $c2.'<br>';
        var_dump($c3);
        var_dump($c4);
        var_dump($c5);*/

        echo $c6;        

    }

    public function actionCancelartodo(){
         //$c1: tipo de cancelacion 0: plato 1: todo el pedido
        //$c2: codigo de la mesa donde se va hacer la cancelacion
        //$c3: codigo del plato que se va a cancelar
        //$c4: cantidad que se va a cancelar
        //$c5: puesto del plato donde se va a cancelar  
        //$c6: codigo del mensaje 0: correcto , 1: error         
        
        $fn_cancelar = new SpMesasPedidos();

        // datos eviados por get
        $get1 = $_GET['tamano'];

        if($get1 <= 4){
            // captura los demas datos
            $get2 = $_GET['mesa'];
            //parametros de entrada
            $c1 = 1;
            $c2 = $get2;
            $c3 = array("");
            $c4 = array("");
            $c5 = array("");

            $c6 = $fn_cancelar->procedimiento8($c1,$c2,$c3,$c4,$c5);


        }else if($get1 >= 5 and $get1 <=6){
            //mesa principal y la mesa unida a ella
            $get2 = $_GET['mesa1'];
            $get3 = $_GET['mesa2'];

            //saber si hay pedidos entregados
            $c6 = $fn_cancelar->procedimiento11($get2);

            if($c6 === '0'){               
                //parametros de entrada mesa 1
                $c1 = 1;
                $c2 = $get2;
                $c3 = array("");
                $c4 = array("");
                $c5 = array("");

                $c6 = $fn_cancelar->procedimiento8($c1,$c2,$c3,$c4,$c5);

                //parametros de entrada mesa 1
                $c1 = 1;
                $c2 = $get3;
                $c3 = array("");
                $c4 = array("");
                $c5 = array("");

                $c6 = $fn_cancelar->procedimiento8($c1,$c2,$c3,$c4,$c5);
            }

            
        }

        echo $c6;        
    }

    public function actionCancelarresto(){
        $fn_cancelar = new SpMesasPedidos();

        // datos eviados por get
        $get1 = $_GET['tamano'];

        if($get1 <= 4){
             // captura los demas datos
            $get2 = $_GET['mesa'];
            $c1 = $get2;

            $fn_cancelar->procedimiento12($c1);
            
        }else if($get1 >= 5 and $get1 <=6){
            //mesa principal y la mesa unida a ella
            $get2 = $_GET['mesa1'];
            $get3 = $_GET['mesa2'];

            $c1 = $get2;            
            $fn_cancelar->procedimiento12($c1);

            $c1 = $get3;
            $fn_cancelar->procedimiento12($c1);
        }

        echo 1;
    }

    public function actionFacturar(){ 
        //c1: Variable correspondiente a la cedula del cliente (opcional)
        //c2: Variable correspondiente al nombre de quien queda la factura (opcional)
        //c3: Variable correspondiente al codigo de la mesa
        //c4: Variable correspondiente a la cedula del mesero
        //c5: Variable correspondiente a la forma de pago
        //c6: Variable correspondiente a los puestos que se facturan
        //caputra de datos por get
        $get1 = $_GET['puestos'];
        $get2 = $_GET['mesa'];
        $get3 = $_GET['full'];
        $get4 = $_GET['propina'];
        $get5 = $_GET['codCli'];

        //objeto para facturar
        $fn_facturar = new SpMesasFactura();

        //================================ nombre del cliente ==================
        $nombreCli = $fn_facturar->procedimiento8($get5);        
        if(strcmp('SIN_REGISTRO',$nombreCli) == 0){
            $get5 = "N/A";
            $get6 = "N/A";
        }else{
            $get6 = $nombreCli;
        }
        //================================ nombre del cliente ==================

        //////////////////////// respaldo de datos antes de facturar en caso de reversarla
        $numeroRever = $fn_facturar->procedimiento5($get2);
        //////////////////////// respaldo de datos antes de facturar en caso de reversarla

        // parametros del procedimiento
        $c1 = $get5;
        $c2 = $get6;
        $c3 = $get2;
        $c4 = '16743485';//$_SESSION['cedula'];
        $c5 = "01";
        $c6 = $get1;        
        
        // si es falso se facturan todos lo puestos
        if($get3 === "false"){     
            $c6 = array("0");
            // se genera la factura general para los restaurantes
            $facturar1 = $fn_facturar->procedimiento2($c1,$c2,$c3,$c4,$c5,$c6);
            // se toma la cabecera y los detalles de la factura generada
            $cabecera = $facturar1[0];
            $detalle = $facturar1[1];
            // se sacan los datos mas detallados de la cabecera
            $c1 = $cabecera['FECHA'][0];
            $c2 = $cabecera['HORA'][0];
            $c3 = array($cabecera['NUMERO_FAC'][0]);
            $c5 = $get4;
            // se genera la factura para el cliente
            $facturar2 = $fn_facturar->procedimiento4($c1,$c2,$c3,$c4,$c5);
            $cabeceraDetalle = array($facturar2, $detalle, $numeroRever);
            echo json_encode($cabeceraDetalle);
        // si es falso se facturan los puestos solicitados
        }else if($get3 === "true"){
            $funcionArr = new funcionesArray();                        
            $c6 = $funcionArr->arrayPuestos($c6);
            // se genera la factura general para los restaurantes
            $facturar1 = $fn_facturar->procedimiento2($c1,$c2,$c3,$c4,$c5,$c6);
            // se toma la cabecera y los detalles de la factura generada
            $cabecera = $facturar1[0];
            $detalle = $facturar1[1];
            // se sacan los datos mas detallados de la cabecera
            $c1 = $cabecera['FECHA'][0];
            $c2 = $cabecera['HORA'][0];
            $c3 = array($cabecera['NUMERO_FAC'][0]);
            $c5 = $get4;
            // se genera la factura para el cliente
            $facturar2 = $fn_facturar->procedimiento4($c1,$c2,$c3,$c4,$c5);
            $cabeceraDetalle = array($facturar2, $detalle, $numeroRever);
            echo json_encode($cabeceraDetalle);   

        }
        //echo '[{"NUMERO_FAC":["000003"],"FECHA":["17\/08\/2017"]},{"PRODES":["TORO CAESAR","ENSALDA FUSION","ENSALDA ORIENTE"],"PEDUNI":["1","1","1"],"PEDVALTUN":["24990","22015","26537"]},"73542"]';

        
        
    }

    public function actionReversarfactura(){
        //$c1: numero de rever que se le asigna al momento de facturar 
        //$c2: numero de la factura que se da al cliente y que se va a revertir
        //
        $get1 = $_GET['rever'];
        $get2 = $_GET['factura'];

        $c1 = $get2[0];
        $c2 = $get1;

        $fn_factura = new SpMesasFactura();
        $fn_factura->procedimiento6($c1,$c2);

        echo 1;
        
    }

    public function actionFacturarx(){
        //c1: Variable correspondiente a la cedula del cliente (opcional)
        //c2: Variable correspondiente al nombre de quien queda la factura (opcional)
        //c3: Variable correspondiente al codigo de la mesa
        //c4: Variable correspondiente a la cedula del mesero
        //c5: Variable correspondiente a la forma de pago
        //c6: Variable correspondiente a los puestos que se facturan
        //caputra de datos por get
        $get1 = $_GET['puestos'];
        $get2 = $_GET['mesa1'];
        $get3 = $_GET['full'];
        $get4 = $_GET['mesa2'];
        $get5 = $_GET['propina'];
        $get6 = $_GET['codCli'];
        

        $puestos1 = array();
        $puestos2 = array();

        // recorreo los puestos y los separo
        for($i = 0 ; $i < count($get1) ; $i++){
            //puests para la mesa 1
            if ($get1[$i] === '1' or $get1[$i] === '2' or $get1[$i] === '6') {
                //asigna el valor al array
                $puestos1[] = '0'.$get1[$i];
            //puests para la mesa 2
            }else if ($get1[$i] === '3' or $get1[$i] === '4' or $get1[$i] === '5') {
                //asigna el valor al array
                $puestos2[] = '0'.$get1[$i];
            }
        }


        //objeto para facturar
        $fn_facturar = new SpMesasFactura();      

        //================================ nombre del cliente ==================
        $nombreCli = $fn_facturar->procedimiento8($get6);        
        if(strcmp('SIN_REGISTRO',$nombreCli) == 0){
            $get6 = "N/A";
            $get7 = "N/A";
        }else{
            $get7 = $nombreCli;
        }
        //================================ nombre del cliente ==================  

        //////////////////////// respaldo de datos antes de facturar en caso de reversarla
        $numeroRever = $fn_facturar->procedimiento5($get2);
        //////////////////////// respaldo de datos antes de facturar en caso de reversarla

        //si los puestos de una mesa estan vacion no se factura a esa mesa
        if(count($puestos1) > 0){
            //facturacion para la mesa 1
            $c11 = $get6;
            $c21 = $get7;
            $c31 = $get2;
            $c41 = '16743485';//$_SESSION['cedula'];
            $c51 = "01";
            $c61 = $puestos1;   
            // se genera la factura general para los restaurantes
            $faturaM1 = $fn_facturar->procedimiento2($c11,$c21,$c31,$c41,$c51,$c61);
            // se toma la cabecera y los detalles de la factura generada
            $cabecera1 = $faturaM1[0];
            $detalle1 = $faturaM1[1];            
            // se sacan los datos mas detallados de la cabecera
            $c11 = $cabecera1['FECHA'][0];
            $c21 = $cabecera1['HORA'][0];
            $c31 = array($cabecera1['NUMERO_FAC'][0]);        
        }else{
            // se declaran las variables vacias        
            $c11 = ""; // fecha de la factura
            $c21 = ""; // hora de la factura
            $c31 = array(""); // codigo general de la mesa
            $detalle1 = array(
                'PRODES' => array(""),
                'PEDUNI' => array(""),
                'PEDVALTUN' => array("")            
            );   
        }


        if(count($puestos2) > 0){
            // facturacion para la mesa 2
            $c12 = $get6;
            $c22 = $get7;
            $c32 = $get4;
            $c42 = '16743485';//$_SESSION['cedula'];
            $c52 = "01";
            $c62 = $puestos2;
            // se genera la factura general para los restaurantes
            $faturaM2 = $fn_facturar->procedimiento2($c12,$c22,$c32,$c42,$c52,$c62);
             // se toma la cabecera y los detalles de la factura generada            
            $cabecera2 = $faturaM2[0];
            $detalle2 = $faturaM2[1];                     
            // se sacan los datos mas detallados de la cabecera
            $c12 = $cabecera2['FECHA'][0];
            $c22 = $cabecera2['HORA'][0];
            $c32 = array($cabecera2['NUMERO_FAC'][0]);
        }else{
            // se declaran las variables vacias        
            $c12 = ""; // fecha de la factura
            $c22 = ""; // hora de la factura
            $c32 = array(""); // codigo general de la mesa
            $detalle2 = array(
                'PRODES' => array(""),
                'PEDUNI' => array(""),
                'PEDVALTUN' => array("")            
            );     
        }
        
        // datos para la factura del cliente
        $c1 = array($c11,$c12);        
        $c1 = array_filter($c1);  // se filtran los registros que se encuentren nulos        
        if(array_key_exists(0, $c1)){
            $c1 = $c1[0];    
        }else{
            $c1 = $c1[1];
        }
        

        $c2 = array($c21,$c22);
        $c2 = array_filter($c2);  // se filtran los registros que se encuentren nulos
        if(array_key_exists(0, $c2)){
            $c2 = $c2[0];    
        }else{
            $c2 = $c2[1];
        }

        $c3;
        $c30 = array($c31,$c32);        
        foreach ($c30 as $key) {
            $c3[] = $key[0];
        }        
        $c3 = array_filter($c3);  // se filtran los registros que se encuentren nulos        

        $c4 = '16743485';//$_SESSION['cedula'];

        // detalle de la factura
        $producto = array();
        $cantidad = array();
        $valor    = array();

        //union del detalle de cada una de las mesas
        for ($i = 0 ; $i < count($detalle1['PRODES']) ; $i++) {                                  
            array_push($producto  , $detalle1['PRODES'][$i]);
            array_push($cantidad  , $detalle1['PEDUNI'][$i]);
            array_push($valor     , $detalle1['PEDVALTUN'][$i]);                  
        }

        for ($i = 0 ; $i < count($detalle2['PRODES']) ; $i++) {                                  
            array_push($producto  , $detalle2['PRODES'][$i]);
            array_push($cantidad  , $detalle2['PEDUNI'][$i]);
            array_push($valor     , $detalle2['PEDVALTUN'][$i]);                  
        }

        // elimina los valor que el array contenga vacios
        $producto = array_filter($producto);
        $cantidad = array_filter($cantidad);
        $valor    = array_filter($valor);

        // se crea el array calve valor
        $detalle[] = array(
            'PRODES' => $producto,
            'PEDUNI' => $cantidad,
            'PEDVALTUN' => $valor,            
        );    
        
        $c5 = $get5;
        // se genera la factura para el cliente
        $facturar = $fn_facturar->procedimiento4($c1,$c2,$c3,$c4,$c5);
        $cabeceraDetalle = array($facturar, $detalle, $numeroRever);
        echo json_encode($cabeceraDetalle);
    }

    public function actionVisualizarfac(){
        //$c1: codigo de la mesa
        //$c2: array con los puestos que va a visualizar
        $model1 = new funcionesArray();
        $c1 = $_GET["mesa"];
        $c2 = $model1->arrayPuestos($_GET["puestos"]);

        $model2 = new SpMesasPedidos();
        $visualiza = $model2->procedimiento9($c1,$c2);
        
        //var_dump($c2)
        echo json_encode($visualiza);
    }

    public function actionConsultacliente(){
        //c1: codigo del cliente
        //
        $c1 = $_GET['codigocliente'];

        $fn_facturacion = new SpMesasFactura();
        $nombreCliente = $fn_facturacion->procedimiento8($c1);

        echo $nombreCliente;
    }

    public function actionRegistrarcliente(){
        //$c1: codigo del cliente
        //$c2: nombre completo del clinete
        //$c3: direccion del cliente
        //$c4: correo electronico del cliente
        //$c5: telefono del cliente
        //
        $c1 = $_GET['codCli'];
        $c2 = $_GET['nomCli'];
        $c3 = $_GET['dirCli'];
        $c4 = $_GET['corCli'];
        $c5 = $_GET['telCli'];
        $c6 = $_GET['ciuCli'];

        $fn_registro = new SpMesasFactura();
        $resultado = $fn_registro->procedimiento7($c1,$c2,$c3,$c4,$c5,$c6);

        echo $resultado;
    }

    public function actionVisualizarfacx(){
        //$c1: codigo de la mesa
        //$c2: array con los puestos que va a visualizar        
        $tamano = $_GET['tamano'];
        
        if($tamano >= 5 and $tamano <= 6){
            // captura la mesa principal y la unida a ella 
            $c11 = $_GET["mesa1"];
            $c12 = $_GET["mesa2"];

            $get1 = $_GET["puestos"];

            $c21 = array();
            $c22 = array();

            // puestos de cada mesa
            for($i = 0 ; $i < count($get1) ; $i++){
                //puests para la mesa 1
                if ($get1[$i] === '1' or $get1[$i] === '2' or $get1[$i] === '6') {
                    //asigna el valor al array
                    $c21[] = '0'.$get1[$i];
                //puests para la mesa 2
                }else if ($get1[$i] === '3' or $get1[$i] === '4' or $get1[$i] === '5') {
                    //asigna el valor al array
                    $c22[] = '0'.$get1[$i];
                }
            }

            $model1 = new SpMesasPedidos();
            $producto = array();
            $unidad = array();
            $precio = array();
            $fecha = array();
            $iva = array();

            if(count($c21) != 0){
                $pedidos1 = $model1->procedimiento9($c11,$c21);
                $detalle1 = $pedidos1[0];
                $fecha1 = $pedidos1[1];

                for($i = 0 ; $i < count($detalle1['PRODUCTO']) ; $i++){
                                     
                    $producto[] = $detalle1['PRODUCTO'][$i];
                    $unidad[] = $detalle1['UNIDAD'][$i];
                    $precio[] = $detalle1['VALOR'][$i];
                    $iva[] = $detalle1['VALOR_IVA'][$i];
                }

                $fecha[] = $fecha1;

            }

            if(count($c22) != 0){
                $pedidos2 = $model1->procedimiento9($c12,$c22);
                $detalle2 = $pedidos2[0];
                $fecha2 = $pedidos2[1];

                for($i = 0 ; $i < count($detalle2['PRODUCTO']) ; $i++){
                                     
                    $producto[] = $detalle2['PRODUCTO'][$i];
                    $unidad[] = $detalle2['UNIDAD'][$i];
                    $precio[] = $detalle2['VALOR'][$i];
                    $iva[] = $detalle2['VALOR_IVA'][$i];
                }

                $fecha[] = $fecha2;
            }

            // se crea el array calve valor
            $detalle = array(
                'PRODUCTO' => $producto,
                'UNIDAD' => $unidad,
                'VALOR' => $precio, 
                'VALOR_IVA' => $iva           
            );                       

            $full = array($detalle, $fecha[0]);
           
            echo json_encode($full);
        }
        
    }

     public function actionEstadomesafac(){
        $c1 = $_GET["mesa"];

        $model = new SpMesasFactura();
        $estado = $model->procedimiento3($c1);

        echo $estado;
    }

    public function actionConsultarpedido(){
        // obtengo el codigo de la mesa 
        $c1 = $_GET['mesa'];
        //inicia el objeto
        $fn_pedidos = new SpMesasPedidos();
        //llamo el procedimiento del objeto
        $resultado = $fn_pedidos->procedimiento6($c1);
        //el array como json
        echo json_encode($resultado);
    }

    public function actionConsultarpedidox(){
        // obtengo el codigo de la mesa 
        $c1 = $_GET['mesa'];
        //inicia el objeto
        $fn_pedidos = new SpMesasPedidos();
        //llamo el procedimiento del objeto
        $mesasUnidad = $fn_pedidos->procedimiento10($c1);
        $tamano = count($mesasUnidad);
        //array que contiene todos los pedidos de la mesa
        $arrayUnido = array();
        //array para los datos que se muestran de los platos
        $platos = array();
        $cantidad = array();
        $puesto = array();
        $codigo = array();
        $imagen = array();
        $mesa = array();

        for ($i = 0 ; $i < count($mesasUnidad) ; $i++) {
            $pedidoMesa = $fn_pedidos->procedimiento6($mesasUnidad[$i]);                      

            //rellena el array con la informacion correspondiente retornada por el procedimiento
            for ($j = 0 ; $j < count($pedidoMesa['PLATO']) ; $j++) {
                array_push($platos  , $pedidoMesa['PLATO'][$j]);
                array_push($cantidad, $pedidoMesa['CANTIDAD'][$j]);
                array_push($puesto  , $pedidoMesa['PUESTO'][$j]);
                array_push($codigo  , $pedidoMesa['CODIGO'][$j]);
                array_push($imagen  , $pedidoMesa['IMAGEN'][$j]);
                array_push($mesa    , $mesasUnidad[$i]);                           
            }       

        }

        // se llena el array a retornar en json con sus respectivos datos en clave valor
        $arrayUnido[] = array(
                                'PLATO'    => $platos,
                                'CANTIDAD' => $cantidad,
                                'PUESTO'   => $puesto,
                                'CODIGO'   => $codigo,
                                'IMAGEN'   => $imagen,
                                'MESA'     => $mesa
                            );        

        echo json_encode($arrayUnido[0]) ;


        
        
    }

    public function actionConsultanomplato(){
        // obtengo el codigo de la mesa 
        $platosPlano = $_GET['plato'];
        //funciones para array
        $fn_array = new funcionesArray();
        //convierto la cadena en array
        $c1 = $fn_array->crearArray($platosPlano);
        //array con los nombres ya definidos
        $arrayNombres = array();    
        // array con las imagenes de los platos
        $arrayImg = array();
        //inicia el objeto
        $fn_pedidos = new SpMesasPedidos();

        foreach ($c1 as $keyA) {
            //llamo el procedimiento del objeto
            $resultado = $fn_pedidos->procedimiento7($keyA);
            
            array_push($arrayNombres,$resultado[0]);
            array_push($arrayImg,$resultado[1]);
        }
        

        echo json_encode(array($arrayNombres,$arrayImg));
    }

    public function actionMenu()
    {   
        //=============================CARGA DEL MENU=======================================
        // se hace el llamado de la funcion que ejecuta el procedimiento
        $fn_menus = new SpMenusPlaza;
        $datosMenus = $fn_menus->procedimiento();
        // se asignana los valores que retorna la funcion respectivamente 
        // tipos de comidas
        $categorias = $datosMenus[0];
        // los platos 
        $comidas = $datosMenus[3];
        //=============================CARGA DEL MENU=======================================
        

        //=============================LOGICA DE PEDIDO=======================================
        // si ninguna de estas vriables existe retorna a la plaza
        if(isset($_GET['puesto'], $_GET['codigoM'], $_GET['tamanoM'], $_GET['estadoM'])){
            //captura el puesto al que se le va a tomar el pedido
            $puesto = $_GET['puesto'];
            $codmesa = $_GET['codigoM'];
            $tamano = $_GET['tamanoM'];
            $estado = $_GET['estadoM'];
            // si se recibe platos, cantidad y puesto redirecciona con unos parametros 
            if(isset($_GET['platos'], $_GET['cantidad'], $_GET['puestos'])){
                // variables que se pasan como parametro
                $platos = $_GET['platos']; // los platos que se han pedido en la mesa 
                $cantidad = $_GET['cantidad']; // cantidad de platos que se han pedido  en la mesa
                $puestos = $_GET['puestos']; // numero de los puestos donde se han pedido
                // redirecciona a la vista menu con los parametros del menu y de los pedidos de la mesa ya hechos 
                $this->layout=false;    
                return $this->render('menu',["categorias" => $categorias, "comidas" => $comidas, "puesto" => $puesto,
                                             "platos" => $platos, "cantidad" => $cantidad, "puestos" => $puestos,
                                             "codmesa" => $codmesa, "tamano" => $tamano, "estado" => $estado]);
            }else{
                $platos = 0;
                $cantidad = 0;
                $puestos = 0;
                // redirecciona a la vista menu con los parametros del menu 
                $this->layout=false;    
                return $this->render('menu',["categorias" => $categorias, "comidas" => $comidas, "puesto" => $puesto,
                                             "platos" => $platos, "cantidad" => $cantidad, "puestos" => $puestos,
                                             "codmesa" => $codmesa, "tamano" => $tamano, "estado" => $estado]);
            }
        }else{
            $this->layout=false;    
            return $this->redirect(['site/plaza']); 
        }
        //=============================LOGICA DE PEDIDO=======================================        
        

        
        
    }

    /* Menu new */

    public function actionMenunew()    {
       //=============================CARGA DEL MENU=======================================
        // se hace el llamado de la funcion que ejecuta el procedimiento
        $fn_menus = new SpMenusPlaza;
        $datosMenus = $fn_menus->procedimiento();
        // se asignana los valores que retorna la funcion respectivamente 
        // tipos de comidas
        $categorias = $datosMenus[0];
        // los platos 
        $comidas = $datosMenus[3];
        //=============================CARGA DEL MENU=======================================
        
        //=============================LOGICA DE PEDIDO=======================================
        
        // si ninguna de estas vriables existe retorna a la plaza
        if(isset($_GET['puesto'], $_GET['codigoM'], $_GET['tamanoM'], $_GET['estadoM'])){
            //captura el puesto al que se le va a tomar el pedido
            $puesto = $_GET['puesto'];
            $codmesa = $_GET['codigoM'];
            $tamano = $_GET['tamanoM'];
            $estado = $_GET['estadoM'];

            // si se recibe platos, cantidad y puesto redirecciona con unos parametros 
            if(isset($_GET['platos'], $_GET['cantidad'], $_GET['puestos'])){
                // variables que se pasan como parametro
                $platos = $_GET['platos']; // los platos que se han pedido en la mesa 
                $cantidad = $_GET['cantidad']; // cantidad de platos que se han pedido  en la mesa
                $puestos = $_GET['puestos']; // numero de los puestos donde se han pedido
                // redirecciona a la vista menu con los parametros del menu y de los pedidos de la mesa ya hechos 
                $this->layout=false;    
                return $this->render('menunew',["categorias" => $categorias, "comidas" => $comidas, "puesto" => $puesto,
                                             "platos" => $platos, "cantidad" => $cantidad, "puestos" => $puestos,
                                             "codmesa" => $codmesa, "tamano" => $tamano, "estado" => $estado]);
            }else{
                $platos = 0;
                $cantidad = 0;
                $puestos = 0;
                // redirecciona a la vista menu con los parametros del menu 
                $this->layout=false;    
                return $this->render('menunew',["categorias" => $categorias, "comidas" => $comidas, "puesto" => $puesto,
                                             "platos" => $platos, "cantidad" => $cantidad, "puestos" => $puestos,
                                             "codmesa" => $codmesa, "tamano" => $tamano, "estado" => $estado]);
            }
        }else{
            $this->layout=false;    
            return $this->redirect(['site/plaza']); 
        }
        
        
        //=============================LOGICA DE PEDIDO=======================================        
    }

    public function actionContratos()
    {           
        //Declareo la clase  para el procedimeinto que trae las empresas y los contratos    
        $model = new SpContratosAcomer;
        $datosEmpCont = $model->sp_acomer_empresas_contratos();
        //Obtengo el array donde estan todas las empresas almacenadas
        $empresas = $datosEmpCont[0];
        //Obtengo el array donde estan todos los contratos almacenados
        $contratos = $datosEmpCont[1];
        //Obtengo el array donde estan todas las facturas almacenadas
        $facturas = $datosEmpCont[2];
        //Estado de la factura (pendiente o cancelada)
        $facturacancelada = '<div class="icon-est-factcan">C</div>';
        $facturapendiente = '<div class="icon-est-factura">P</div>';

        $this->layout=false; 
        return $this->render('contratos',["empresas"=>$empresas,"contratos"=>$contratos,"facturas"=>$facturas,
                                          "facturacancelada"=>$facturacancelada,"facturapendiente"=>$facturapendiente]);
    }

    public function actionCocina()
    {   
        //valida que tenga la sesion iniciada
        if(!isset(Yii::$app->session['cedula'])){
            return $this->goHome();                                        
        }else{
            //captura el id de inicio de sesion
            $cedula = Yii::$app->session['cedula'];
            // identifocar el rol de quien hiz login
            $fn_login = new SpLoginAcomer();
            $rol = $fn_login->procedimiento2($cedula);            
            // de ser mesero se redirecciona a la plaza 
            if($rol === 'MESERO'){
                return $this->redirect(['site/plaza']);
            }
        }

        //consulta el nombre de la cocina
        //        
        $c1 = $cedula;
        $c1 = trim($c1);

        $fn_cocina = new SpCocinaPedidos();
        $nomcocina = $fn_cocina->procedimiento5($c1);

        $this->layout="main_cocina";
        return $this->render('cocina',["nomcocina"=>$nomcocina,"rol"=>$rol]);      
    }

    public function actionPedidoscocina(){
        //$c1: cedula del cocinero
        //  
        $c1 = '16743485';//$_SESSION['cedula'];
        // se crea el objeto 
        $fn_cocina = new SpCocinaPedidos();
        // se ejecuta el procedimiento
        $result = $fn_cocina->procedimiento($c1);

        echo json_encode($result);
    }

    public function actionPedidolisto(){
        //$c1: codigo del restaurante al que pertenece el plato
        //$c2: codigo del pedido que tiene asignado el plato
        //$c3: nombre del plato
        //
        $get1 = $_GET['empresa'];
        $get2 = $_GET['pednro'];
        $get3 = $_GET['plato'];        

        $c1 = $get1;
        $c2 = $get2;
        $c3 = $get3;
        
        
        // se crea el objeto 
        $fn_cocina = new SpCocinaPedidos();
        // se ejecuta el procedimiento
        $result = $fn_cocina->procedimiento2($c1,$c2,$c3);


        //echo $c1; echo '<br>';
        //echo $c2; echo '<br>';
        //echo $c3; echo '<br>';        
    }

    public function actionAgregahistorial(){
        //$c1: cedula del cocinero
        //$c2: nombre del plato
        //$c3: cantidad
        //  
        $c1 = '16743485';//$_SESSION['cedula'];
        $c2 = $_GET['plato'];                
        $c3 = $_GET['cantidad'];
        
        $fn_cocina = new SpCocinaPedidos;
        $historial = $fn_cocina->procedimiento3($c1,$c2,$c3);

        echo 1;
    }

    public function actionHistorialcocina(){
        //$c1: cedula del cocinero
        //  
        $c1 = '16743485';//$_SESSION['cedula'];

        $fn_cocina = new SpCocinaPedidos;
        $historial = $fn_cocina->procedimiento4($c1);

        echo json_encode($historial);
    }


}