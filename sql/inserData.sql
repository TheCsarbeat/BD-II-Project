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

select * from Sucursal