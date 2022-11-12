
call crudImpuesto(1,'ImpuestoCostaRica',0.13,1,null);
call crudImpuesto(1,'ImpuestoPanama',0.1,2,null);
call crudImpuesto(1,'ImpuestoNicaragua',0.18,3,null);

call crudCategoriaProducto(1,'AlimentosFrescos','Alimentos bien preservados para consumo',null);
call crudCategoriaProducto(1,'AlimentosCongelados','Alimentos preservados congelados',null);
call crudCategoriaProducto(1,'Refrescos','Bebidas para consumo',null);
call crudCategoriaProducto(1,'Aseo','Productos de limpieza',null);

call crudProducto(1,'Lechuga','Vegetal Lechuga de la zona de los Santos', 1,'xxxxx',null);
call crudProducto(1,'PechugaDePollo','Fresca Pechuga 200g', 2,'xxxxx',null);
call crudProducto(1,'Arizona','Bebida en lata 600ml', 3,'xxxxx',null);
call crudProducto(1,'Jabon','Jabon para manos', 4,'xxxxx',null);

call crudCategoriaXImpuesto(1,1,1,null);
call crudCategoriaXImpuesto(1,2,2,null);
call crudCategoriaXImpuesto(1,3,3,null);
call crudCategoriaXImpuesto(1,1,4,null);

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