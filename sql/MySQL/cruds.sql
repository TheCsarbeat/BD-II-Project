GO
--====================================================
--						Impuesto
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudImpuesto
	@idImpuesto int,
	@nombre varchar(20) ,
	@porcentaje float ,
	@idPais int ,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN

		if @nombre is not null and @porcentaje is not null  BEGIN
			IF (select count(*) from MYSQLSERVER...Impuesto where idImpuesto = @idImpuesto) = 0 BEGIN
				IF (select count(*) from pais where idPais = @idPais) = 1 BEGIN
					
						BEGIN TRY
	
								INSERT INTO MYSQLSERVER...Impuesto (nombreImpuesto,porcentajeImpuesto,idPais)
								values (@nombre,@porcentaje,@idPais);
								
	
						END TRY
						BEGIN CATCH
							set @errorInt=1
							set @errorMsg = 'Error al agregar a la base de datos'
						END CATCH									
						
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un pais v�lida'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'Ya existe un producto con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos

		if @identityValue != -1
			return @identityValue

	end
	
	if @operationFlag = 1 BEGIN
		if  @idImpuesto is not null and @nombre is not null and @porcentaje is not null and @idPais is not null BEGIN
			IF (select count(*) from MYSQLSERVER...Impuesto where idImpuesto = @idImpuesto) = 1 BEGIN
				IF (select count(*) from pais where idPais = @idPais) = 1 BEGIN
							BEGIN TRY
								BEGIN TRANSACTION
								update MYSQLSERVER...Impuesto 
								set nombreImpuesto= ISNULL(@nombre, nombreImpuesto), porcentajeImpuesto = ISNULL(@porcentaje, porcentajeImpuesto),
								idPais = ISNULL(@idPais, idPais) where idImpuesto = @idImpuesto
							COMMIT TRANSACTION
							END TRY
							BEGIN CATCH
								set @errorInt=1
								set @errorMsg = 'Error al actualizar a la base de datos'
							END CATCH
	
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un pais v�lido'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'NO existe un producto con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos
	END

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...Impuesto
		where idImpuesto= @idImpuesto and estado =1;
	end

	IF @operationFlag = 3
	BEGIN
		select * from MYSQLSERVER...Impuesto	
		where estado = 1;
	END

	IF @operationFlag = 4
	BEGIN
		update MYSQLSERVER...Impuesto  
		set estado = ISNULL(0, estado)
		where idImpuesto = @idImpuesto
	END
	IF @operationFlag = 5
	BEGIN
		update MYSQLSERVER...Impuesto	 
		set estado = ISNULL(1, estado)
		where idImpuesto= @idImpuesto
	END
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
end

GO
--====================================================
--			Categoria CategoriaXImpuesto
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudCategoriaImpuesto
	@idCategoriaXImpuesto int null, 
	@idCategoria int ,
	@idImpuesto int ,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN

	IF (select count(*) from MYSQLSERVER...CategoriaXImpuesto where idCategoriaXImpuesto = @idCategoriaXImpuesto) = 0 BEGIN
			IF (select count(*) from MYSQLSERVER...CategoriaProducto where idCategoria = @idCategoria) = 1 BEGIN
				IF (select count(*) from MYSQLSERVER...Impuesto where idImpuesto = @idImpuesto) = 1 BEGIN
					BEGIN TRY
	
					INSERT INTO MYSQLSERVER...CategoriaXImpuesto (idCategoria,idImpuesto)
					values (@idCategoria,@idImpuesto);
							
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'Error al agregar a la base de datos'
					END CATCH									
						
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un impuesto v�lido'
					END				
			end ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'Ya existe una categoria con este ID'
				END
				end

		if @identityValue != -1
			return @identityValue

	END
	
	if @operationFlag = 1 BEGIN
		if @idCategoria is not null and @idImpuesto is not null begin
					BEGIN TRY
						BEGIN TRANSACTION
						update MYSQLSERVER...CategoriaXImpuesto
						set idCategoria = ISNULL(@idCategoria, idCategoria), idImpuesto = ISNULL(@idImpuesto, idImpuesto)
						where idCategoriaXImpuesto = @idCategoriaXImpuesto;
						COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'Error al agregar a la base de datos'
					END CATCH
		END ELSE BEGIN --Final if idConductor			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos
	END

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...CategoriaXImpuesto	
		where idCategoriaXImpuesto = @idCategoriaXImpuesto;
	end

	if @operationFlag = 3
	begin
		select * from MYSQLSERVER...CategoriaXImpuesto 			
	end

	if @operationFlag = 4
	begin
		DELETE from MYSQLSERVER...CategoriaXImpuesto 	
		where idCategoriaXImpuesto = @idCategoriaXImpuesto;
	end
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
end


GO
--====================================================
--					Proveedor
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudProveedor
	@idProveedor int,
	@nombreProveedor varchar(20) ,
	@contacto varchar(20) ,
	@idPais int ,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN

		if @nombreProveedor is not null and @contacto is not null  BEGIN
			IF (select count(*) from MYSQLSERVER...Proveedor where idProveedor = @idProveedor) = 0 BEGIN
				IF (select count(*) from pais where idPais = @idPais) = 1 BEGIN
					BEGIN TRY
					INSERT INTO MYSQLSERVER...Proveedor (nombreProveedor,contacto,idPais)
					values (@nombreProveedor,@contacto,@idPais);
								
	
						END TRY
						BEGIN CATCH
							set @errorInt=1
							set @errorMsg = 'Error al agregar a la base de datos'
						END CATCH									
						
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un pais v�lido'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'Ya existe un proveedor con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos

		if @identityValue != -1
			return @identityValue

	END
	
	if @operationFlag = 1 BEGIN
		if  @idProveedor is not null and @nombreProveedor is not null and @contacto is not null and @idPais is not null BEGIN
			IF (select count(*) from MYSQLSERVER...Proveedor where idProveedor = @idProveedor) = 1 BEGIN
				IF (select count(*) from pais where idPais = @idPais) = 1 BEGIN
					BEGIN TRY
						BEGIN TRANSACTION
						update MYSQLSERVER...Proveedor
						set nombreProveedor = ISNULL(@nombreProveedor, nombreProveedor), contacto = ISNULL(@contacto, contacto),
						idPais = ISNULL(@idPais, idPais) where idProveedor = @idProveedor
						COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'Error al actualizar a la base de datos'
					END CATCH
	
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe una pais v�lido'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'NO existe un proveedor con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos
	END

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...Proveedor 
		where idProveedor = @idProveedor and estado =1;
	end

	IF @operationFlag = 3
	BEGIN
		select * from MYSQLSERVER...Proveedor 	
		where estado = 1;
	END

	IF @operationFlag = 4
	BEGIN
		update MYSQLSERVER...Proveedor  
		set estado = ISNULL(0, estado)
		where idProveedor = @idProveedor
	END
	IF @operationFlag = 5
	BEGIN
		update MYSQLSERVER...Proveedor 	 
		set estado = ISNULL(1, estado)
		where idProveedor = @idProveedor
	END
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
end

GO
--====================================================
--					  Lote
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudLote
	@idLote int,
	@fechaProduccion date,
	@fechaExpiracion date,
	@idProducto int,
	@idProveedor int,
	@cantidadExistencias int ,
	@costoUnidad float,
	@porcentajeVenta float,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN

		if @fechaProduccion is not null and @fechaExpiracion is not null and @cantidadExistencias is not null and
		@costoUnidad is not null and @porcentajeVenta is not null BEGIN
			IF (select count(*) from MYSQLSERVER...Lote where idLote = @idLote) = 0 BEGIN
				IF (select count(*) from MYSQLSERVER...Producto where idProducto = @idProducto) = 1 BEGIN
					IF (select count(*) from MYSQLSERVER...Proveedor where idProveedor= @idProveedor) = 1 BEGIN
						BEGIN TRY

						INSERT INTO MYSQLSERVER...Lote (fechaProduccion, fechaExpiracion, idProducto, idProveedor, cantidadExistencias, costoUnidad, porcentajeVenta)
						values (@fechaProduccion, @fechaExpiracion, @idProducto, @idProveedor, @cantidadExistencias, @costoUnidad, @porcentajeVenta);
								
						END TRY
						BEGIN CATCH
							set @errorInt=1
							set @errorMsg = 'Error al agregar a la base de datos'
						END CATCH	

					END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un proveedor v�lido'
					END	
						
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un producto v�lido'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'Ya existe un lote con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos

		if @identityValue != -1
			return @identityValue

	END
	
	if @operationFlag = 1 BEGIN
		IF (select count(*) from MYSQLSERVER...Lote where idLote = @idLote) = 1 BEGIN
			IF (select count(*) from MYSQLSERVER...Producto where idproducto = @idproducto) = 1 BEGIN
				IF (select count(*) from MYSQLSERVER...Proveedor where idproveedor = @idproveedor) = 1 BEGIN
					BEGIN TRY
						BEGIN TRANSACTION
						update MYSQLSERVER...Lote
						set fechaProduccion = ISNULL(@fechaProduccion, fechaProduccion), fechaExpiracion = ISNULL(@fechaExpiracion, fechaExpiracion),
						idProducto = ISNULL(@idProducto, idProducto), idProveedor = ISNULL(@idProveedor, idProveedor),  cantidadExistencias = ISNULL(@cantidadExistencias, cantidadExistencias),
						costoUnidad = ISNULL(@costoUnidad, costoUnidad), porcentajeVenta = ISNULL(@porcentajeVenta, porcentajeVenta) where idLote = @idLote
						COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'Error al actualizar a la base de datos'
					END CATCH
	
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un proveedor v�lido'
					END
			END ELSE BEGIN 				
				set @errorInt =1
				set @errorMsg = 'No existe un producto v�lido'
				END	
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'NO existe un lote con este ID'
				END
	END

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...Lote 
		where idLote = @idLote and estado =1;
	end

	IF @operationFlag = 3
	BEGIN
		select * from MYSQLSERVER...Lote 	
		where estado = 1;
	END

	IF @operationFlag = 4
	BEGIN
		update MYSQLSERVER...Lote  
		set estado = ISNULL(0, estado)
		where idLote = @idLote
	END
	IF @operationFlag = 5
	BEGIN
		update MYSQLSERVER...Lote 	 
		set estado = ISNULL(1, estado)
		where idLote = @idLote
	END
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
end


GO
--====================================================
--					ProductoXProveedor
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudProductoXProveedor
	@idProductoXProveedor int,
	@porcentajeVenta float ,
	@costoUnidad float ,
	@idLote int ,
	@idProveedor int,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN

		if @costoUnidad is not null and @porcentajeVenta is not null  BEGIN
			IF (select count(*) from MYSQLSERVER...ProductoXProveedor where idProductoXProveedor = @idProductoXProveedor) = 0 BEGIN
				IF (select count(*) from MYSQLSERVER...Lote where idLote = @idLote) = 1 BEGIN
					IF (select count(*) from MYSQLSERVER...Proveedor where idProveedor = @idProveedor) = 1 BEGIN
						BEGIN TRY
						INSERT INTO MYSQLSERVER...ProductoXProveedor (porcentajeVenta,costoUnidad,idLote,idProveedor)
						values (@porcentajeVenta,@costoUnidad,@idLote,@idProveedor);

						END TRY
						BEGIN CATCH
							set @errorInt=1
							set @errorMsg = 'Error al agregar a la base de datos'
						END CATCH									
					END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un proveedor v�lido'
					END	
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un lote v�lido'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'Ya existe un productoXProveedor con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos

		if @identityValue != -1
			return @identityValue

	END
	
	if @operationFlag = 1 BEGIN
		if  @porcentajeVenta is not null and @costoUnidad is not null BEGIN
			IF (select count(*) from MYSQLSERVER...ProductoXProveedor where idProductoXProveedor = @idProductoXProveedor) = 1 BEGIN
				BEGIN TRY
					BEGIN TRANSACTION
					update MYSQLSERVER...Proveedor
					set porcentajeVenta = ISNULL(@porcentajeVenta, porcentajeVenta), costoUnidad = ISNULL(@costoUnidad, costoUnidad),
					idLote = ISNULL(@idLote, idLote), idProveedor = ISNULL(@idProveedor, idProveedor) where idProductoXProveedor = @idProductoXProveedor
					COMMIT TRANSACTION
				END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'Error al actualizar a la base de datos'
				END CATCH		
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'NO existe un productoXProveedor con este ID'
			END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos
	END

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...ProductoXProveedor 
		where idProductoXProveedor = @idProductoXProveedor and estado =1;
	end

	IF @operationFlag = 3
	BEGIN
		select * from MYSQLSERVER...ProductoXProveedor 	
		where estado = 1;
	END

	IF @operationFlag = 4
	BEGIN
		update MYSQLSERVER...ProductoXProveedor  
		set estado = ISNULL(0, estado)
		where ProductoXProveedor = @idProductoXProveedor
	END
	IF @operationFlag = 5
	BEGIN
		update MYSQLSERVER...ProductoXProveedor	 
		set estado = ISNULL(1, estado)
		where idProductoXProveedor = @idProductoXProveedor
	END
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
end

GO
--====================================================
--				    Pedido
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudPedido
	@idPedido int null, 
	@cantidadPedido int ,
	@idProductoXProveedor int ,
	@fechaPedido date,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN

		if @cantidadPedido is not null and @fechaPedido is not null begin	
			IF (select count(*) from MYSQLSERVER...ProductoXProveedor where idProductoXProveedor = @idProductoXProveedor) = 1 BEGIN
				BEGIN TRY
				INSERT INTO MYSQLSERVER...Pedido (cantidadPedido,idProductoXProveedor,fechaPedido)
                 values (@cantidadPedido,@idProductoXProveedor,@fechaPedido);
		
				END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'Error al agregar a la base de datos'
				END CATCH
			END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'NO existe un productoXProveedor con este ID'
			END  ---Final if validaci?n nulos

		end ELSE BEGIN --Final if idConductor			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos

		if @identityValue != -1
			return @identityValue
	END
	
	if @operationFlag = 1 BEGIN
		if @cantidadPedido is not null and @idProductoXProveedor is not null  and @fechaPedido is not null begin		
				BEGIN TRY
					BEGIN TRANSACTION
					update MYSQLSERVER...CategoriaProducto 
					set cantidadPedido = ISNULL(@cantidadPedido, cantidadPedido), idProductoXProveedor = ISNULL(@idProductoXProveedor, idProductoXProveedor),
					fechaPedido = ISNULL(@fechaPedido, fechaPedido) where idPedido = @idPedido;
					COMMIT TRANSACTION
					END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'Error al agregar a la base de datos'
				END CATCH
		END ELSE BEGIN --Final if idConductor			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos
	END

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...Pedido 	
		where idPedido = @idPedido;
	end

	if @operationFlag = 3
	begin
		select * from MYSQLSERVER...Pedido			
	end

	if @operationFlag = 4
	begin
		DELETE from MYSQLSERVER...Pedido	
		where idPedido = @idPedido;
	end
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
end


GO
--====================================================
--						Limite
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudLimite
	@idLimite int,
	@max int,
	@min int ,
	@idProducto int ,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN

		if @max is not null and @min is not null  BEGIN
			IF (select count(*) from MYSQLSERVER...Limite where idLimite = @idLimite) = 0 BEGIN
				IF (select count(*) from MYSQLSERVER...Producto where idProducto = @idProducto) = 1 BEGIN
					
						BEGIN TRY
	
							INSERT INTO MYSQLSERVER...Limtie (max,min,idProducto)
							values (@max,@min,@idProducto);
								
	
						END TRY
						BEGIN CATCH
							set @errorInt=1
							set @errorMsg = 'Error al agregar a la base de datos'
						END CATCH									
						
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un producto v�lida'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'Ya existe un limite con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos

		if @identityValue != -1
			return @identityValue

	end
	
	if @operationFlag = 1 BEGIN
		if  @max is not null and @min is not null and  @idProducto is not null BEGIN
			IF (select count(*) from MYSQLSERVER...Limite where idLimite = @idLimite) = 1 BEGIN
				IF (select count(*) from Producto where idProducto = @idProducto) = 1 BEGIN
						BEGIN TRY
							BEGIN TRANSACTION
							update MYSQLSERVER...Limite 
							set max= ISNULL(@max, max), porcentajeImpuesto = ISNULL(@min, min),
							idProducto = ISNULL(@idProducto, idProducto) where idLimite = @idLimite
							COMMIT TRANSACTION
						END TRY
						BEGIN CATCH
							set @errorInt=1
							set @errorMsg = 'Error al actualizar a la base de datos'
						END CATCH
	
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un producto v�lido'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'NO existe un limite con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay alg�n valor nulo'
			END  ---Final if validaci?n nulos
	END

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...Limite
		where idLimite= @idLimite and estado =1;
	end

	IF @operationFlag = 3
	BEGIN
		select * from MYSQLSERVER...Limite	
		where estado = 1;
	END

	IF @operationFlag = 4
	BEGIN
		update MYSQLSERVER...Limite  
		set estado = ISNULL(0, estado)
		where idLimite = @idLimite
	END
	IF @operationFlag = 5
	BEGIN
		update MYSQLSERVER...Limite	 
		set estado = ISNULL(1, estado)
		where idLimite= @idLimite
	END
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
end
