-- EXECUTE IN SERVER
EXEC spCrudImpuesto null, 'IVA', 0.13, 1,0
EXEC spCrudImpuesto null, 'ImpuestoPanama',0.1,2,0
EXEC spCrudImpuesto null, 'ImpuestoNicaragua',0.18,3,0

EXEC spCrudCategoriaImpuesto null,1, 1,0
EXEC spCrudCategoriaImpuesto null,2, 1,0
EXEC spCrudCategoriaImpuesto null,3, 1,0
EXEC spCrudCategoriaImpuesto null,4, 1,0


EXEC insertPais 'Costa Rica'
EXEC insertPais'Panama'
EXEC insertPais'Nicaragua'


declare @punto geometry 
set @punto = geometry::Point(12356, 32156, 0)
EXEC insertLugar 'Cartago Puebla', 1, @punto

EXEC insertMoneda 'Colon'
EXEC insertMoneda 'Dolar panameno'
EXEC insertMoneda 'cordoba'

EXEC crudMonedaXPais 1,null,1,600,1 -- Elcambio de colon es 
EXEC crudMonedaXPais 1,null,1,1,1 -- Elcambio de pana es 1
EXEC crudMonedaXPais 1,null,1,30,1 -- Elcambio de cordoba es 

EXEC crudSucursal 1, null, 'Quiques', 1, 1
EXEC crudSucursal 1, null, 'Fermeza', 1, 1
EXEC crudSucursal 1, null, 'WAlMARt', 1, 1

select * from Sucursal


EXEC spCrudCategoriaProducto null, 'Hortaliza', 'Productos del campo',0

EXEC spCrudProducto null, 'Yuca', 'yuca sembrada en tierras aledanas', 1, 'yuca.jpg','productImgs/yuca.jpg', 0
EXEC spCrudProducto null, 'Zanahoria', 'naranja', 1, 'carrot.jpg','productImgs/carrot.jpg', 0
EXEC spCrudProducto null, 'Cebolla', 'una cebolla', 1, 'onion.jpg','productImgs/onion.jpg', 0
EXEC spCrudProducto null, 'Rabano', 'pequenno', 1, 'raddish.jpg','productImgs/raddish.jpg', 0
EXEC spCrudProducto null, 'Papa', 'a potato', 1, 'potato.jpg','productImgs/potato.jpg', 0

EXEC spCrudProducto null, 'Papa', 'a potato', 1, 'potato.jpg','productImgs/potato.jpg', 3


declare @punto2 geometry
set @punto2 = geometry::Point(10500, 899, 0)
EXEC insertLugar 'Heredia', 1, @punto2

declare @punto3 geometry
set @punto3 = geometry::Point(7000, 5899, 0)
EXEC insertLugar 'Alajuela', 1, @punto3

EXEC crudSucursal 1, null, 'Quiques', 1, 1
EXEC crudSucursal 1, null, 'Fermeza', 1, 1
EXEC crudSucursal 1, null, 'Paseo flores', 2, 1
EXEC crudSucursal 1, null, 'El Dorado', 3, 1

declare @punto4 geometry
set @punto4 = geometry::Point(200, 450, 0)
insert into Cliente (idCliente, nombreCliente, apellidoCliente, ubicacion)
values('118460455', 'Cesar', 'Jimenez', @punto4)

exec spClosestPoint '118460455'

select * from Sucursal
select * from Usuario
select * from Cliente

SELECT tn.name
FROM BDOPTIMIZACION.dbo.Customer as tn