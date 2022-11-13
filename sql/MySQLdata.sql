-- EXECUTE IN SERVER
EXEC spCrudImpuesto null, 'IVA', 0.13, 1,0
EXEC spCrudImpuesto null, 'ImpuestoPanama',0.1,2,0
EXEC spCrudImpuesto null, 'ImpuestoNicaragua',0.18,3,0

EXEC spCrudCategoriaProducto null,'AlimentosFrescos','Alimentos bien preservados para consumo',0
EXEC spCrudCategoriaProducto null,'AlimentosCongelados','Alimentos preservados congelados',0
EXEC spCrudCategoriaProducto null,'Refrescos','Bebidas para consumo',0
EXEC spCrudCategoriaProducto null, 'Frutas Verduras', 'Productos del campo',0
EXEC spCrudCategoriaProducto null,'Aseo','Productos de limpieza',0

EXEC spCrudCategoriaImpuesto null,1, 1,0
EXEC spCrudCategoriaImpuesto null,2, 1,0
EXEC spCrudCategoriaImpuesto null,3, 1,0
EXEC spCrudCategoriaImpuesto null,4, 1,0


EXEC spCrudProducto null, 'Yuca', 'yuca sembrada en tierras aledanas', 4, 'yuca.jpg','/productImgs/yuca.jpg',0
EXEC spCrudProducto null, 'Lechuga', 'Vegetal Lechuga de la zona de los Santo', 4, 'yuca.jpg','/productImgs/yuca.jpg',0
EXEC spCrudProducto null,'PechugaDePollo','Fresca Pechuga 200g', 2,'pechuga.jpg', 'xxxxx', 0
EXEC spCrudProducto null,'Arizona','Bebida en lata 600ml', 3,'xxxxx', 'xxxxx', 0
EXEC spCrudProducto null,'Jabon','Jabon para manos', 4,'xxxxx', 'xxxxx', 0

INSERT into MYSQLSERVER...Proveedor (nombreProveedor, contacto, idPais)
VALUES ('Coopeagri','ventas@coopeagri.com', 1),('Tres Jotas','ventas@TresJotas.com', 1)

INSERT into MYSQLSERVER...Lote (fechaProduccion, fechaExpiracion, idProducto, idProveedor, cantidadExistencias,costoUnidad,porcentajeVenta)
VALUES ('2022-08-31','2022-12-31', 1,1, 30, 500,0.2)



call crudLote(1,'2022-07-04','2022-12-09',1,null);
call crudLote(1,'2022-08-04','2022-12-15',2,null);
call crudLote(1,'2022-09-04','2022-12-20',3,null);
call crudLote(1,'2022-10-04','2022-12-25',4,null);

call crudProveedor(1,'TRAA','TRAA@gmail.com',1,null);
call crudProveedor(1,'Mafisa','mafisa@gmail.com',2,null);
call crudProveedor(1,'Mayca','mayca@gmail.com',3,null);
call crudProveedor(1,'DosPinos','2arboles@gmail.com',4,null);

call crudProductoXProveedor(1,0.5,2500.0,1,1,null);
call crudProductoXProveedor(1,0.6,3500.0,2,2,null);
call crudProductoXProveedor(1,0.7,4500.0,3,3,null);
call crudProductoXProveedor(1,0.8,5500.0,4,4,null);

call crudPedido(1,3,1,CURDATE(),null);
call crudPedido(1,4,2,CURDATE(),null);
call crudPedido(1,2,3,CURDATE(),null);
call crudPedido(1,3,4,CURDATE(),null);