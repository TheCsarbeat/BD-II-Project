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

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...CategoriaProducto 	
		where idCategoria = @idCategoriaProducto;
	end

	if @operationFlag = 3
	begin
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
								BEGIN TRANSACTION
								update MYSQLSERVER...Producto 
								set nombreProducto = ISNULL(@nombreProducto, nombreProducto), descripcionProducto = ISNULL(@descripcionProducto, descripcionProducto),
								idCategoria = ISNULL(@idCategoria, idCategoria), nombreImg = ISNULL(@nombreImg, nombreImg), imgPath = ISNULL(@imgPath, imgPath)
								where idProducto = @idProducto
							COMMIT TRANSACTION
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

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...Producto 
		where idProducto = @idProducto and estado =1;
	end

	IF @operationFlag = 3
	BEGIN
		select * from MYSQLSERVER...Producto 	
		where estado = 1;
	END

	IF @operationFlag = 4
	BEGIN
		update MYSQLSERVER...Producto  
		set estado = ISNULL(0, estado)
		where idProducto = @idProducto
	END
	IF @operationFlag = 5
	BEGIN
		update MYSQLSERVER...Producto 	 
		set estado = ISNULL(1, estado)
		where idProducto = @idProducto
	END
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
end