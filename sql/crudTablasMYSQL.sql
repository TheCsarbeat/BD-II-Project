GO
--====================================================
--						Categoria Producto
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudCategoriaProducto
	@idCategoriaProducto int null, 
	@nombre varchar(20) ,
	@descripcion varchar(100) ,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN

		if @nombre is not null and @descripcion is not null begin			
			BEGIN TRY
														
					INSERT INTO MYSQLSERVER...CategoriaProducto (nombreCategoria,descripcionCategoria)
                    values (@nombre,@descripcion);
				
		
			END TRY
			BEGIN CATCH
				set @errorInt=1
				set @errorMsg = 'Error al agregar a la base de datos'
			END CATCH

		END ELSE BEGIN --Final if idConductor			
			set @errorInt=1
			set @errorMsg = 'Hay algún valor nulo'
			END  ---Final if validaci�n nulos

		if @identityValue != -1
			return @identityValue
	END
	
	if @operationFlag = 1 BEGIN
		if @nombre is not null and @descripcion is not null  and @idCategoriaProducto is not null begin		
					BEGIN TRY
						BEGIN TRANSACTION
						update MYSQLSERVER...CategoriaProducto 
						set nombreCategoria = ISNULL(@nombre, nombreCategoria), descripcionCategoria = ISNULL(@descripcion, descripcionCategoria)
						where idCategoria = @idCategoriaProducto;
						COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'Error al agregar a la base de datos'
					END CATCH
		END ELSE BEGIN --Final if idConductor			
			set @errorInt=1
			set @errorMsg = 'Hay algún valor nulo'
			END  ---Final if validaci�n nulos
	END

	if @operationFlag = 2	begin
		select * from MYSQLSERVER...CategoriaProducto 	
		where idCategoria = @idCategoriaProducto;
	end

	if @operationFlag = 3	begin
		select * from MYSQLSERVER...CategoriaProducto 			
	end

	if @operationFlag = 4
	begin
		DELETE from MYSQLSERVER...CategoriaProducto 	
		where idCategoria = @idCategoriaProducto;
	end
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
end


GO
--====================================================
--						Producto
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudProducto
	@idProducto int,
	@nombreProducto varchar(30) ,
	@descripcionProducto varchar(40) ,
	@idCategoria int ,
	@nombreImg varchar(250),
	@imgPath varchar(2000),
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN

		if @nombreProducto is not null and @descripcionProducto is not null and @descripcionProducto is not null and @idCategoria is not null
		and @nombreImg is not null and @imgPath is not null BEGIN
			IF (select count(*) from MYSQLSERVER...Producto where idProducto = @idProducto) = 0 BEGIN
				IF (select count(*) from MYSQLSERVER...CategoriaProducto where idCategoria = @idCategoria) = 1 BEGIN
					
						BEGIN TRY
	
								INSERT INTO MYSQLSERVER...Producto (nombreProducto,descripcionProducto,idCategoria,nombreImg ,imgPath)
								values (@nombreProducto,@descripcionProducto,@idCategoria,@nombreImg, @imgPath);
								
								set @errorMsg = 'Se ha insertado correctamente'
	
						END TRY
						BEGIN CATCH
							set @errorInt=1
							set @errorMsg = 'Error al agregar a la base de datos'
						END CATCH									
						
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe una categoria válida'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'Ya existe un producto con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay algún valor nulo'
			END  ---Final if validaci�n nulos

		if @identityValue != -1
			return @identityValue

	END
	
	if @operationFlag = 1 BEGIN
		if  @idProducto is not null and @nombreProducto is not null and @descripcionProducto is not null and @descripcionProducto is not null and @idCategoria is not null
		and @nombreImg is not null and @imgPath is not null BEGIN
			IF (select count(*) from MYSQLSERVER...Producto where idProducto = @idProducto) = 1 BEGIN
				IF (select count(*) from MYSQLSERVER...CategoriaProducto where idCategoria = @idCategoria) = 1 BEGIN
							BEGIN TRY
								update MYSQLSERVER...Producto 
								set nombreProducto = ISNULL(@nombreProducto, nombreProducto), descripcionProducto = ISNULL(@descripcionProducto, descripcionProducto),
								idCategoria = ISNULL(@idCategoria, idCategoria), nombreImg = ISNULL(@nombreImg, nombreImg), imgPath = ISNULL(@imgPath, imgPath)
								where idProducto = @idProducto
							END TRY
							BEGIN CATCH
								set @errorInt=1
								set @errorMsg = 'Error al actualizar a la base de datos'
							END CATCH
	
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe una categoria válido'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'NO existe un producto con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay algún valor nulo'
			END  ---Final if validaci�n nulos
	END

	if @operationFlag = 2	begin
		select * from MYSQLSERVER...Producto 
		where idProducto = @idProducto and estado =1;
		set @errorInt =-1;
	end

	IF @operationFlag = 3	BEGIN
		select * from MYSQLSERVER...Producto 	
		where estado = 1;
		set @errorInt =-1;
	END

	IF @operationFlag = 4	BEGIN
		update MYSQLSERVER...Producto  
		set estado = ISNULL(0, estado)
		where idProducto = @idProducto
	END
	IF @operationFlag = 5	BEGIN
		update MYSQLSERVER...Producto 	 
		set estado = ISNULL(1, estado)
		where idProducto = @idProducto
	END
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	IF @errorInt = 0
		select 0 as Result, @errorMsg as msg
end

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
					set @errorMsg = 'No existe un pais válida'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'Ya existe un producto con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay algún valor nulo'
			END  ---Final if validaci�n nuloss

		if @identityValue != -1
			return @identityValue

	END
	
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
					set @errorMsg = 'No existe un pais válido'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'NO existe un producto con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay algún valor nulo'
			END  ---Final if validaci�n nulos
	END

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...Impuesto
		where idImpuesto= @idImpuesto and estado =1;
	end

	IF @operationFlag = 3	BEGIN
		select * from MYSQLSERVER...Impuesto	
		where estado = 1;
	END

	IF @operationFlag = 4	BEGIN
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
						set @errorMsg = 'No existe un impuesto válido'
						END
				END ELSE BEGIN 			
					set @errorInt=1
					set @errorMsg = 'No existe una caterogia con este ID'
					END
					end
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'Ya existe una categoriaximpuesto con este ID'

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
			set @errorMsg = 'Hay algún valor nulo'
			END  ---Final if validaci�n nulos
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
END
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
	
							--INSERT INTO MYSQLSERVER...Limtie (maxCant,minCant,idProducto)
							--values (@max,@min,@idProducto);
							select 0
								
	
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
							set maxCant= ISNULL(@max, maxCant), minCant = ISNULL(@min, minCant),
							idProducto = ISNULL(@idProducto, idProducto) where idLimite = @idLimite;
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

	if @operationFlag = 2	begin
		select * from MYSQLSERVER...Limite
		where idLimite= @idLimite and estado =1;
	end

	IF @operationFlag = 3	BEGIN
		select * from MYSQLSERVER...Limite	
		where estado = 1;
	END

	IF @operationFlag = 4	BEGIN
		update MYSQLSERVER...Limite  
		set estado = ISNULL(0, estado)
		where idLimite = @idLimite
	END
	IF @operationFlag = 5	BEGIN
		update MYSQLSERVER...Limite	 
		set estado = ISNULL(1, estado)
		where idLimite= @idLimite
	END
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
end



GO
--====================================================
--						Limite
--===================================================
CREATE or ALTER PROCEDURE dbo.spSelectProductsToView
	
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
	select Producto.idProducto, nombreProducto as Nombre, Producto.descripcionProducto as Descripcion, Categoria.nombreCategoria as Categoria from MYSQLSERVER...Producto  as Producto	
	INNER JOIN MYSQLSERVER...CategoriaProducto as Categoria ON  Categoria.idCategoria = Producto.idCategoria
	where Producto.estado = 1;
end

--  EXEC spCrudCategoriaProducto null, 'Frutas Verduras', 'Productos del campo',0

-- EXEC spCrudProducto null, 'Yuca', 'yuca sembrada en tierras aledanas', 1, 'yuca.jpg','/productImgs/yuca.jpg',0

-- EXEC spCrudImpuesto null, 'IVA', 0.13, 1,0
