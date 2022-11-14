CREATE or ALTER PROCEDURE dbo.spSelectProviderToView
    
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
    select Proveedor.idProveedor, nombreProveedor as Nombre, Proveedor.contacto as Contacto, Pais.nombrePais as Pais from MYSQLSERVER...Proveedor  as Proveedor    
    INNER JOIN Pais as Pais ON  Pais.idPais = Proveedor.idPais
    where Proveedor.estado = 1;
end

exec spSelectProviderToView