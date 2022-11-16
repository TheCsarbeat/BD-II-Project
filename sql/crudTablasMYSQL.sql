GO
--====================================================
--						Categoria Producto
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudCategoriaProducto
	@idCategoriaProducto int = null, 
	@nombre varchar(200) = null ,
	@descripcion varchar(100) = null,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(200)
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
						update MYSQLSERVER...CategoriaProducto 
						set nombreCategoria = ISNULL(@nombre, nombreCategoria), descripcionCategoria = ISNULL(@descripcion, descripcionCategoria)
						where idCategoria = @idCategoriaProducto;
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
GO
CREATE or ALTER PROCEDURE dbo.spCrudProducto
	@idProducto int,
	@nombreProducto varchar(200) ,
	@descripcionProducto varchar(200) ,
	@idCategoria int ,
	@nombreImg varchar(250),
	@imgPath varchar(200),
	@cantMin int, 
	@cantMax int,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(200)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN

		if @nombreProducto is not null and @descripcionProducto is not null and @descripcionProducto is not null and @idCategoria is not null
		and @nombreImg is not null and @imgPath is not null BEGIN
			IF (select count(*) from MYSQLSERVER...Producto where idProducto = @idProducto) = 0 BEGIN
				IF (select count(*) from MYSQLSERVER...CategoriaProducto where idCategoria = @idCategoria) = 1 BEGIN
					
						BEGIN TRY
								
								INSERT INTO MYSQLSERVER...Producto (nombreProducto,descripcionProducto,idCategoria,nombreImg ,imgPath)
								values (@nombreProducto,@descripcionProducto,@idCategoria,@nombreImg, @imgPath);

								
								set @idProducto = (SELECT TOP 1 idProducto FROM MYSQLSERVER...Producto ORDER BY idProducto DESC)

								set @errorMsg = 'Se ha insertado correctamente'
								EXEC spCrudLimite null, @cantMax, @cantMin, @idProducto, 0 
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
								declare @idLimite int

								set @idLimite = (select idLimite from MYSQLSERVER...Limite  where idProducto = 1)  
								EXEC spCrudLimite @idLimite, @cantMax, @cantMin, @idProducto, 1 
								set @errorMsg = 'The product has update'
								set @errorInt = 2
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
		where estado =1;
		set @errorInt =-1;
	END

	IF @operationFlag = 4	BEGIN
		IF (select count(*) from MYSQLSERVER...Producto where idProducto = @idProducto ) = 1 BEGIN
			IF (select count(*) from MYSQLSERVER...Producto where idProducto = @idProducto and estado !=0) = 1 BEGIN
				update MYSQLSERVER...Producto 	 
				set estado = ISNULL(0, estado)
				where idProducto = @idProducto
				set @errorInt=0
				set @errorMsg = 'Producto Eliminado'
			END ELSE BEGIN 			
					set @errorInt=4
					set @errorMsg = 'El producto ya se ha eliminado'
					END
		END ELSE BEGIN 			
				set @errorInt=4
				set @errorMsg = 'NO existe un producto con este ID'
				END
	END

	IF @operationFlag = 5	BEGIN
		IF (select count(*) from MYSQLSERVER...Producto where idProducto = @idProducto ) = 1 BEGIN
			IF (select count(*) from MYSQLSERVER...Producto where idProducto = @idProducto and estado !=1) = 1 BEGIN
				update MYSQLSERVER...Producto 	 
				set estado = 1
				where idProducto = @idProducto
				set @errorInt=0
				set @errorMsg = 'Se ha reactivado'
			END ELSE BEGIN 			
				set @errorInt=4
				set @errorMsg = 'El producto ya está activado'
				END
		END ELSE BEGIN 			
				set @errorInt=4
				set @errorMsg = 'NO existe un producto con este ID'
				END
	END

	IF @operationFlag = 6	BEGIN
		IF (select count(*) from MYSQLSERVER...Producto where idProducto = @idProducto ) = 1 BEGIN
			IF( SELECT COUNT(*) from MYSQLSERVER...Producto as Producto
			INNER JOIN MYSQLSERVER...Lote as Lote ON Lote.idProducto = Producto.idProducto
			where Producto.idProducto = @idProducto ) =1 BEGIN
				IF( SELECT COUNT(*) from MYSQLSERVER...Producto as Producto
				INNER JOIN DetalleFactura ON DetalleFactura.idProducto = Producto.idProducto
				where Producto.idProducto = @idProducto 	) =1 BEGIN
					delete from MYSQLSERVER...Producto 	 
					where idProducto = @idProducto
					set @errorInt=0
					set @errorMsg = 'Se ha eliminado permanentemente'
				END ELSE BEGIN 			
					set @errorInt=1
					set @errorMsg = 'THE product is related '
					END
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'THE product is related '
				END
			
		END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'NO existe un producto con este ID'
				END
	END
	IF @errorInt =1
		select @errorInt as Error, @ErrorMsg as MensajeError
	IF @errorInt =0
		select 0 as Result, @ErrorMsg as MensajeError
	IF @errorInt =2
		select 0 as Result, @ErrorMsg as MensajeError
	IF @errorInt =4
		select 5 as Result, @ErrorMsg as MensajeError


end
GO 

--   EXEC spCrudProducto 13, null, null,null,null,null, 4


--====================================================
--						Impuesto
--===================================================
GO
CREATE or ALTER PROCEDURE dbo.spCrudImpuesto
	@idImpuesto int,
	@nombre varchar(200) ,
	@porcentaje float ,
	@idPais int ,
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(200)
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
								idPais = ISNULL(@idPais, idPais)
								where idImpuesto = @idImpuesto
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
		select * from MYSQLSERVER...Impuesto as Impuesto
		INNER JOIN Pais ON Pais.idPais =Impuesto.idPais
		
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
-- EXEC spCrudImpuesto null, null, null, null, 3
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
declare @errorInt int = -1, @errorMsg varchar(200)
declare @identityValue int = -1
	if @operationFlag = 0 BEGIN
	
	IF (select count(*) from MYSQLSERVER...CategoriaXImpuesto where idCategoriaXImpuesto = @idCategoriaXImpuesto) = 0 BEGIN
			IF (select count(*) from MYSQLSERVER...CategoriaProducto where idCategoria = @idCategoria) = 1 BEGIN
				IF (select count(*) from MYSQLSERVER...Impuesto where idImpuesto = @idImpuesto) = 1 BEGIN
					BEGIN TRY
	
					INSERT INTO MYSQLSERVER...CategoriaXImpuesto (idCategoria,idImpuesto)
					values (@idCategoria,@idImpuesto);
					set @errorMsg = 'The tax by category has inserted'
					set @errorInt = 0

					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'Error al agregar a la base de datos'
					END CATCH									
						
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un impuesto válido'
					END				
			end ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'Ya existe una categoria con este ID'
				END
				end

	END
	 --- EXEC spCrudCategoriaImpuesto 2, 6, 2, 1
	if @operationFlag = 1 BEGIN
	IF (select count(*) from MYSQLSERVER...CategoriaXImpuesto where idCategoriaXImpuesto = @idCategoriaXImpuesto) = 1 BEGIN
			if @idCategoria is not null and @idImpuesto is not null begin
						BEGIN TRY
							
							update MYSQLSERVER...CategoriaXImpuesto
							set idCategoria = ISNULL(6, idCategoria),
							idImpuesto = ISNULL(2, idImpuesto)
							where idCategoriaXImpuesto = 2;
							set @errorMsg = 'The tax by category has updated'
							set @errorInt= 2
						
						END TRY
						BEGIN CATCH
							set @errorInt=1
							set @errorMsg = 'Error al agregar a la base de datos'
						END CATCH
			END ELSE BEGIN --Final if idConductor			
				set @errorInt=1
				set @errorMsg = 'Hay algún valor nulo'
				END  ---Final if validaci�n nulos
		END ELSE BEGIN --Final if idConductor			
			set @errorInt=1
			set @errorMsg = 'No hay una elemento con ese ID'
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

	if @operationFlag = 4	begin
		IF (select count(*) from MYSQLSERVER...CategoriaXImpuesto where idCategoriaXImpuesto = @idCategoriaXImpuesto) = 1 BEGIN
			IF (Select count(*) from Inventario 
			INNER JOIN MYSQLSERVER...Lote as Lote ON Lote.idLote = inventario.idLote
			INNER JOIN MYSQLSERVER...Producto as Producto ON Producto.idProducto = Lote.idProducto
			INNER JOIN MYSQLSERVER...CategoriaProducto as Categoria ON Categoria.idCategoria = Producto.idCategoria
			INNER JOIN MYSQLSERVER...CategoriaXImpuesto as CategoriaXImpuesto ON CategoriaXImpuesto.idCategoria = Categoria.idCategoria
			INNER JOIN MYSQLSERVER...Impuesto as Impuesto ON Impuesto.idImpuesto = CategoriaXImpuesto.idImpuesto
			where idCategoriaXImpuesto = @idCategoriaXImpuesto) = 0 BEGIN
			
				
				DELETE from MYSQLSERVER...CategoriaXImpuesto 	
				where idCategoriaXImpuesto = @idCategoriaXImpuesto;
				select 4 as REsul, 'eliminado correctamente' as msg
			END ELSE BEGIN --Final if idConductor			
				set @errorInt=1
				set @errorMsg = 'Esta impuesto esta realacionado a una categoria que se usa'
				END  ---Final if validaci�n nulos

		END ELSE BEGIN --Final if idConductor			
			set @errorInt=1
			set @errorMsg = 'Este id no existe'
			END  ---Final if validaci�n nulos
	END
	IF @errorInt =1
		select @errorInt as Error, @ErrorMsg as MensajeError
	IF @errorInt =0
		select 0 as Result, @ErrorMsg as MensajeError
	IF @errorInt =2
		select 0 as Result, @ErrorMsg as MensajeError
END
GO
-- EXEC spCrudCategoriaImpuesto null, 4, 3, 1
-- 		EXEC spCrudCategoriaImpuesto 1, 2, 2,4


GO
--====================================================
--          Proveedor
--===================================================
CREATE or ALTER PROCEDURE dbo.spCrudProveedor
  @idProveedor int = null,
  @nombreProveedor varchar(200)=null ,
  @contacto varchar(200) = null,
  @idPais int= null ,
  @operationFlag int  -- Insert 0, update 1, select 2, select-ALL 3, delete 4
  with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(200)
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
          set @errorMsg = 'No existe un pais valido'
          END        
      END ELSE BEGIN       
        set @errorInt=1
        set @errorMsg = 'Ya existe un proveedor con este ID'
        END
    END ELSE BEGIN       
      set @errorInt=1
      set @errorMsg = 'Hay algun valor nulo'
      END  ---Final if validaci?n nulos

    if @identityValue != -1
      return @identityValue

  END
  
  if @operationFlag = 1 BEGIN
    BEGIN TRY
      
      update MYSQLSERVER...Proveedor
      set nombreProveedor = ISNULL(@nombreProveedor, nombreProveedor), contacto = ISNULL(@contacto, contacto),
      idPais = ISNULL(@idPais, idPais) where idProveedor = @idProveedor
      
    END TRY
    BEGIN CATCH
      set @errorInt=1
      set @errorMsg = 'Error al actualizar a la base de datos'
    END CATCH
        
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
  else
      select 0 as correct, 'Action completed correctly!' as Result
end
GO
GO
--====================================================
--					  Lote
--===================================================
GO 

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
declare @errorInt int = 0, @errorMsg varchar(200)
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
							set @errorInt=0
							set @errorMsg = 'The lote has inserted'
						END TRY
						BEGIN CATCH
							set @errorInt=-1
							set @errorMsg = 'Error al agregar a la base de datos'
						END CATCH	

					END ELSE BEGIN 				
					set @errorInt =-1
					set @errorMsg = 'No existe un proveedor v�lido'
					END	
						
				END ELSE BEGIN 				
					set @errorInt =-1
					set @errorMsg = 'No existe un producto v�lido'
					END				
			END ELSE BEGIN 			
				set @errorInt=-1
				set @errorMsg = 'Ya existe un lote con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=-1
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

						update MYSQLSERVER...Lote
						set fechaProduccion = ISNULL(@fechaProduccion, fechaProduccion), fechaExpiracion = ISNULL(@fechaExpiracion, fechaExpiracion),
						idProducto = ISNULL(@idProducto, idProducto), idProveedor = ISNULL(@idProveedor, idProveedor),  cantidadExistencias = ISNULL(@cantidadExistencias, cantidadExistencias),
						costoUnidad = ISNULL(@costoUnidad, costoUnidad), porcentajeVenta = ISNULL(@porcentajeVenta, porcentajeVenta) where idLote = @idLote
						
						set @errorInt=1
						set @errorMsg = 'Data update'

					END TRY
					BEGIN CATCH
						set @errorInt=-1
						set @errorMsg = 'Error al actualizar a la base de datos'
					END CATCH
	
				END ELSE BEGIN 				
					set @errorInt =-1
					set @errorMsg = 'No existe un proveedor v�lido'
					END
			END ELSE BEGIN 				
				set @errorInt =-1
				set @errorMsg = 'No existe un producto v�lido'
				END	
			END ELSE BEGIN 			
				set @errorInt=-1
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
	IF @operationFlag = 6	BEGIN
		IF (select count(*) from MYSQLSERVER...Lote as Lote where idLote = @idLote ) = 1 BEGIN
			IF( SELECT COUNT(*) from MYSQLSERVER...Lote as Lote
				INNER JOIN Inventario ON Inventario.idLote = Lote.idLote
				where Lote.idLote = @idProducto ) =1 BEGIN
					
							delete from MYSQLSERVER...Producto 	 
							where idProducto = @idProducto
							set @errorInt=6
								set @errorMsg = 'Se ha eliminado permanentemente'
					
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'The lote is related '
				END			
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'NO existe un lote con este ID'
			END
	END

	if @errorInt =-1
		select @errorInt as Error, @ErrorMsg as MensajeError
	if @errorInt =0
		select 0 as result, @ErrorMsg as result 
	if @errorInt =1
		select 0 as result, @ErrorMsg as result 
	if @errorInt =6
		select 0 as result, @ErrorMsg as result 
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
							INSERT INTO MYSQLSERVER...Limite (maxCant,minCant,idProducto)
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
							
							update MYSQLSERVER...Limite 
							set maxCant= ISNULL(@max, maxCant), minCant = ISNULL(@min, minCant),
							idProducto = ISNULL(@idProducto, idProducto) 
							where idLimite = @idLimite;
							
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
GO
CREATE or ALTER PROCEDURE dbo.spSelectProductsToView
	
as
begin
declare @errorInt int = 0, @errorMsg varchar(200)
declare @identityValue int = -1
	select Producto.idProducto, nombreProducto as Nombre, Producto.descripcionProducto as Descripcion, Categoria.nombreCategoria as Categoria, imgPath,
	Producto.estado, Limite.maxCant, Limite.minCant from MYSQLSERVER...Producto as Producto
	INNER JOIN MYSQLSERVER...CategoriaProducto as Categoria ON  Categoria.idCategoria = Producto.idCategoria
	INNER JOIN MYSQLSERVER...Limite as Limite ON Limite.idProducto = Producto.idProducto 

	select * from MYSQLSERVER...Limite
	
end
GO

CREATE or ALTER PROCEDURE dbo.spSelectLotetoView
	
as
begin
declare @errorInt int = 0, @errorMsg varchar(200)
declare @identityValue int = -1
	select idLote, CONVERT (VARCHAR(200), fechaProduccion,107) as fechaProduccion,CONVERT (VARCHAR(200), fechaExpiracion,107) as  fechaExpiracion, cantidadExistencias, costoUnidad, nombreProducto,
	nombreProveedor, CONCAT ( CONVERT(varchar(100),(porcentajeVenta*100)), ' %') as porcentajeVenta from MYSQLSERVER...Lote as Lote	
	INNER JOIN MYSQLSERVER...Producto as Producto ON  Producto.idProducto = Lote.idProducto
	INNER JOIN MYSQLSERVER...Proveedor as Proveedor ON  Proveedor.idProveedor = Lote.idProveedor
	
end

GO

CREATE or ALTER PROCEDURE dbo.spSelectInventoryView
	
as
begin
declare @errorInt int = 0, @errorMsg varchar(200)
declare @identityValue int = -1
	select nombreProducto, Sucursal.nombreSucursal, sum(cantidadInventario) as cantidadInventario,
	CONCAT ( '$ ',CONVERT(varchar(100),(precioVenta))) as precioVenta, Limite.maxCant, Limite.minCant  from Inventario
	INNER JOIN Sucursal as Sucursal ON  Sucursal.idSucursal = Inventario.idSucursal
	INNER JOIN MYSQLSERVER...Lote as Lote ON Inventario.idLote = Lote.idLote
	INNER JOIN MYSQLSERVER...Producto as Producto ON  Producto.idProducto = Lote.idProducto
	INNER JOIN MYSQLSERVER...Limite as Limite ON  Limite.idProducto = Producto.idProducto
	where Lote.estado = 1 and Producto.estado = 1	
	GROUP BY  nombreProducto,precioVenta, Limite.maxCant, Limite.minCant,Sucursal.nombreSucursal
end
GO

-- @idCategoriaXImpuesto int null, 	@idCategoria int ,	@idImpuesto int ,	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4

-- EXEC spCrudCategoriaImpuesto null, null, null, 3

-- EXEC spCrudImpuesto null, null, null, null, 3

/*
EXEC spSelectInventoryView
*/