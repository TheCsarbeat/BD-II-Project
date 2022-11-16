-- EXECUTE IN SERVER
EXEC insertPais 'Costa Rica'
EXEC insertPais'Panama'
EXEC insertPais'Nicaragua'
EXEC insertPais'Salvador'
EXEC insertPais'Honduras'

EXEC spCrudCategoriaProducto null, 'Hortaliza', 'Productos del campo',0
EXEC spCrudCategoriaProducto null, 'Frutas', 'Productos extraidos de la madre tierra',0
EXEC spCrudCategoriaProducto null, 'Limpieza', 'Productos del P&G',0
EXEC spCrudCategoriaProducto null, 'Comida', 'Productos del empacado',0
EXEC spCrudCategoriaProducto null, 'Latas', 'Productos en latados',0
EXEC spCrudCategoriaProducto null, 'Licores', 'Productos con grados de alcohol',0


EXEC spCrudProducto null, 'Yuca', 'yuca sembrada en tierras aledanas', 1, 'yuca.jpg','productImgs/yuca.jpg',15,30, 0
EXEC spCrudProducto null, 'Zanahoria', 'naranja', 1, 'carrot.jpg','productImgs/carrot.jpg', 15,30, 0
EXEC spCrudProducto null, 'Cebolla', 'una cebolla', 1, 'onion.jpg','productImgs/onion.jpg',15,30, 0
EXEC spCrudProducto null, 'Rabano', 'pequenno', 1, 'raddish.jpg','productImgs/raddish.jpg', 15,30, 0
EXEC spCrudProducto null, 'Papa', 'a potato', 1, 'potato.jpg','productImgs/potato.jpg',15,30, 0
-- EXEC spCrudProducto 15, 'FEkrs', 'a potato', 1, 'ferks.jpg','productImgs/ferks.jpg',15,30, 3


EXEC spCrudImpuesto null, 'IVA CR', 0.13, 1,0
EXEC spCrudImpuesto null, 'IVA Alcohol', 0.03, 1,0
EXEC spCrudImpuesto null, 'IVA PAN',0.1,2,0
EXEC spCrudImpuesto null, 'IVA NIC',0.18,3,0
EXEC spCrudCategoriaImpuesto null,1, 1,0
EXEC spCrudCategoriaImpuesto null,2, 1,0
EXEC spCrudCategoriaImpuesto null,3, 1,0
EXEC spCrudCategoriaImpuesto null,4, 1,0

-- idproveedor, nombre, contacto, idPais, operation
EXEC spCrudProveedor null, 'Coopeagri', 'ventas@coopeagri.com', 1,0
EXEC spCrudProveedor null, 'Tres Jotas', 'ventas@tresjotas.com', 1,0

-- EXEC spCrudLote 13, '2022-11-01','2022-11-15', 3,1, 50,634.5, 0.3,6
-- EXEC spCrudLote 4, '2022-11-01','2022-11-15', 3,1, 50,634.5, 0.3,3
--fechaProduccion, fechaExpiracion, idProducto, idProveedor, cantidadExistencias,costoUnidad,porcentajeVenta, operation
EXEC spCrudLote null, '2022-08-31','2022-12-31', 1,1, 30, 500,0.05,0
EXEC spCrudLote null, '2022-08-31','2022-12-31', 2,1, 50, 320,0.02,0
EXEC spCrudLote null, '2022-08-31','2022-12-31', 3,1, 10, 850,0.02,0
EXEC spCrudLote null, '2022-08-31','2022-12-31', 4,1, 15, 360,0.1,0


EXEC insertMoneda 'Colon'
EXEC insertMoneda 'Dolar panameno'
EXEC insertMoneda 'cordoba'

EXEC crudMonedaXPais 1,null,1,600,1 -- Elcambio de colon es 
EXEC crudMonedaXPais 1,null,1,1,1 -- Elcambio de pana es 1
EXEC crudMonedaXPais 1,null,1,30,1 -- Elcambio de cordoba es 

declare @punto geometry 
set @punto = geometry::Point(9.865843, -83.920612, 0)
EXEC insertLugar 'Cartago Puebla', 1, @punto
set @punto = geometry::Point(9.933583, -84.098887, 0)
EXEC insertLugar 'Chepe', 1, @punto
set @punto = geometry::Point(10.000409, -84.114865, 0)
EXEC insertLugar 'Heredia', 1, @punto
set @punto = geometry::Point(10.016436, -84.213052, 0)
EXEC insertLugar 'Alajuela', 1, @punto
set @punto = geometry::Point(9.372522, -83.660729, 0)
EXEC insertLugar 'General Viejo', 1, @punto
set @punto = geometry::Point(10.447159, -84.040080, 0)
EXEC insertLugar 'Sarapiqui', 1, @punto
set @punto = geometry::Point(9.346963, -83.656479, 0)
EXEC insertLugar 'La hermosa', 1, @punto



EXEC crudSucursal 1, null, 'Quiques', 1, 1
EXEC crudSucursal 1, null, 'Fermeza', 2, 1
EXEC crudSucursal 1, null, 'WAlMARt', 3, 1
EXEC crudSucursal 1, null, 'El chaparral', 4, 1
EXEC crudSucursal 1, null, 'Super General', 5, 1
EXEC crudSucursal 1, null, 'Paseo flores', 6, 1
EXEC crudSucursal 1, null, 'El Dorado', 7, 1



-- EXEC spGetCantNeed 6, 6
/*
-- idInventario, cantidad, @idSucursal, @idLote, @precioVenta, operation    el precio de venta nulo para que se autocalcule
EXEC spInsertProductToInventory null, 20, 6, 1,null, 0
EXEC spInsertProductToInventory null, 25, 6, 2,null, 0
EXEC spInsertProductToInventory null, 25, 6, 3,null, 0
EXEC spInsertProductToInventory null, 25, 6, 4,null, 0
--EXEC spInsertProductToInventory null, 16, 6, 2,null, 0


EXEC spSelectProductsToView
*/

EXEC spSignUpCostumer 'asdf','asdfasdf','2021052792', 'Maynor', 'ERKS MARTINEZ', 9.858211, -83.909768


insert into Puesto (nombrePuesto,salario) Values ('Gerente',1500000);

insert into TipoBono (nombreTipoBono,descripcionTipoBono) values ('BonoXPerformance','Dado por administrador')
insert into TipoBono (nombreTipoBono,descripcionTipoBono) values ('BonoXVenta','Semanal')

insert into MetodoPago (nombreMetodo, otrosDetalles)
VALUES('Efectivo', 'No se acepta monedas de baja denominacion')


--insert into Sucursal (nombreSucursal,idLugar,idMonedaXPais) Values ('4-2',1,1);

--insert into Empleado(nombreEmpleado,apellidoEmpleado,fechaContratacion,fotoEmpleado,idPuesto,idSucursal) Values('Sebas','Chaves','2003-07-04','Tryout.png',1,1);


/*

select * from MYSQLSERVER...Producto
select * from Inventario
select * from MetodoPago
select * from  Usuario
select * from Sucursal
select * from MYSQLSERVER...Lote
select * from Descuento
select * from DescuentoXInventario

declare @punto4 geometry
set @punto4 = geometry::Point(200, 450, 0)

--	@descuentoPorcent float
exec spChangeDiscount 0.50

exec spApplyDiscount 4

exec spGetProductsForDiscount


*/
