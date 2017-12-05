--Estas tablas se pueden ver en el servidor 192.168.0.95 en la base de datos USR_AWA (CONTRASEÑA   0RCAWASYT)  PUERTO 1521

Select * from seg0001                                                         --base de usuarios
Select * from seg00011 where usuid='1234567'                            	  --Relacion de empresas a la las que puede acceder el usuario
Select * from gen0006 where empcod='805.002.684-7'                            --base de empresas
Select * from inv00018                                                        --base de mesas
Select * from inv00018                                                        --base de mesas
Select * from gen0012 where docnom Like 'REQUI%'                     		  --Base de documentos
Select * from inv0014 where cateemppaic='169' and cateempcod='901.023.461-1'; --base de categorias de referecias
Select * from ven0104  														  --Cabecera de pedidos
Select * from ven0004  														  --Detalle de pedidos
Select * from ven0001 where venempc='901.023.461-1'     					  --Referencias de productos (segun harold puede categorizar el producto)
Select * from ven00012 where venempc='901.023.461-1'   						  --Lista de precios por referencia