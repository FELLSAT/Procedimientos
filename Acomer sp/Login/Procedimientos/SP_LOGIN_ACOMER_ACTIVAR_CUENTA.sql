CREATE OR REPLACE PROCEDURE SP_LOGIN_ACOMER_ACTIVAR_CUENTA 
(
    KEY_PASS IN TAB_LOGIN_ACOMER.ID_ACTIVACION%TYPE, 
    ID_LOGIN IN  GEN0011.TERCOD%TYPE, 
    OPERACION IN VARCHAR2,   
    MENSAJE OUT CLOB
)                                                                                                           
IS
    TOKEN VARCHAR2(1000);
    V_BODY VARCHAR2(700); 
BEGIN 
    -- SE DEBE CAMBIAR ACORDE EL LINK Y LA PAGINA DESTINADA PAR ESTA OPERACION
    TOKEN := 'http://localhost:8000/acomer/web/index.php?r=site%2Fasignapassword'||Chr(38)||'tokenreset='||KEY_PASS||Chr(38)||'usuario='||ID_LOGIN||Chr(38)||'operacion=T';    

    IF OPERACION ='C' THEN
        V_BODY := 'Para activar su usuario ingrese al siguiente link y cree una contrase'||CHR(38)||'#241;a:';
    END IF;

    IF OPERACION ='U' THEN
        V_BODY := 'Para cambiar su clave ingrese al siguiente link: ';
    END IF;

    MENSAJE := '
    <!doctype html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Document</title>
        <style>
            *{
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
            }
            body{
                font-family: sans-serif;
                color: #333;
            }
            body,html{
                margin: 0;
                padding: 0;
                width: 100%;
                height: 100%;
            }
            .main{
                width: 100%;
                height: 100%;
                padding: 40px 0;
            }
            .bg{
                background-image: url(http://talentsw.com/contactenos/imagenes/acomer/bg.png);
                background-size: cover;
                background-repeat: repeat;
                background-position: 0 0;
            }
            .pdg-24{
                padding: 24px;
            }
            .container{
                width: 80%;
            }
            .center{
                margin-left: auto;
                margin-right: auto;
            }
            .content-logo{
                margin-bottom: 20px;
            }
            .text-center{
                text-align: center;
            }
            .box-white{
                background-color: #ffffff;
                box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 1px 5px 0 rgba(0, 0, 0, 0.12);
            }
            .btn{
                background-color: #7cb236;
                color: rgba(255,255,255, 0.84);
                border: none;
                border-radius: 2px;
                position: relative;
                padding: 8px 30px;
                margin: 10px 1px;
                font-size: 14px;
                font-weight: 700;
                text-transform: uppercase;
                line-height: 1.42857143;
                text-align: center;
                white-space: nowrap;
                vertical-align: middle;
                letter-spacing: 0;
                -ms-touch-action: manipulation;
                touch-action: manipulation;
                will-change: box-shadow, transform;
                -webkit-transition: -webkit-box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1), background-color 0.2s cubic-bezier(0.4, 0, 0.2, 1), color 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                -o-transition: box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1), background-color 0.2s cubic-bezier(0.4, 0, 0.2, 1), color 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                transition: box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1), background-color 0.2s cubic-bezier(0.4, 0, 0.2, 1), color 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                outline: 0;
                cursor: pointer;
                text-decoration: none;
            }
            .shdw{
                box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 1px 5px 0 rgba(0, 0, 0, 0.12);
            }
            .btn:hover, .btn:focus, .btn:active{
                background-color: #87ba45;
                text-decoration: none;
                outline: 0;
            }
            .btn:focus:active:hover{
                -webkit-box-shadow: 0 0 8px rgba(0, 0, 0, 0.18), 0 8px 16px rgba(0, 0, 0, 0.36);
                box-shadow: 0 0 8px rgba(0, 0, 0, 0.18), 0 8px 16px rgba(0, 0, 0, 0.36);
            }
            .footer{
                color: #ffffff;
            }
        </style>
    </head>
    <body>
        <div class=" main bg">
            <div class="container center text-center">
                <div class="content-logo">
                    <img src="http://talentsw.com/contactenos/imagenes/acomer/logo.png" alt="Acomer" class="resposive-img">
                </div>
                <div class="box-white pdg-24">
                    <h2>Titulo</h2>
                    <p>'||V_BODY||'</p>
                    <br>
                    <a href="'||TOKEN||'" class="btn shdw">Activar cuenta</a>
                </div>
                <div class="footer pdg-24">
                    <small>Copyright '||CHR(38)||'#169; 2017 acomer, todos los derechos reservados.</small>
                </div>
            </div>
        </div>
    </body>
    </html>';

END;