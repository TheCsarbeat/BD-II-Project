create role db_customer
-- SE le asigna solo permiso de acceder a dos procedimientos 
grant execute 
ON object::dbo.spSignUpCostumer
to db_customer

grant execute 
ON object::dbo.spLoginCostumer
to db_customer


-- Se le asigna el permiso de ejecutar cualquier procedimiento en la base de datos, (SOLO EJECUTARLO)
create role db_management
grant execute to db_management