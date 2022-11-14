CREATE or ALTER PROCEDURE dbo.spSelectSucursalesToView
    
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

    select Sucursal.idSucursal, Sucursal.nombreSucursal as Nombre, Lugar.nombreLugar as Lugar, Sucursal.idMonedaXPais as Moneda from Sucursal as Sucursal    
    INNER JOIN Lugar as Lugar ON  Lugar.idLugar = Sucursal.idLugar

    where Sucursal.estado = 1;
end

exec spSelectSucursalesToView

