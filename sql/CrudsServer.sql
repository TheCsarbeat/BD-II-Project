
-- Creación de cruds

-- Branch
-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar
go
create or alter procedure crudBranch @opcion int, @idBranchint =NULL, @Name varchar(20), @idPlace int, @idMonedaXCountry int
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from Branchwhere idBranch= @idBranch)=0	BEGIN
			if @Name is not null	BEGIN
				if (select count(*) from Place where idPlace = @idPlace)!=0	BEGIN
					if (select count(*) from MonedaXCountry where idMonedaXCountry = @idMonedaXCountry)!=0 BEGIN
						
						BEGIN TRY
							BEGIN transaction
								insert into Branch( NameBranch, idPlace, idMonedaXCountry) 
								values(@Name, @idPlace, @idMonedaXCountry)
					
							commit transaction
						END TRY
						BEGIN CATCH
							set @error=1
							set @errorMsg = 'Error al actualizar a la base de datos'
						END CATCH
					END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'La idMonedaXCountry no existe'
					END
				END ELSE BEGIN
					set @error = 3
					set @errorMsg = 'El idPlace no existe'
				END
			END ELSE BEGIN
				set @error = 4
				set @errorMsg = 'Name nulo'
			END
		END ELSE BEGIN
			set @error = 5
			set @errorMsg = 'idBranchya existe'
		END
	END


	if @opcion = 2
		BEGIN
		if (select count(*) from Branchwhere idBranch= @idBranch)!=0 BEGIN
			BEGIN transaction
				update Branch
				set NameBranch= ISNULL(@Name, NameBranch), idPlace = ISNULL(@idPlace, idPlace), idMonedaXCountry = ISNULL(@idMonedaXCountry, idMonedaXCountry)
				where idBranch= @idBranch			
			commit transaction 

			END ELSE BEGIN 
				set @error = 1
				set @errorMsg = 'El idBranchno existe'
			END
		
		END

	if @opcion = 3
		BEGIN
		if (select count(*) from Branchwhere idBranch= @idBranch)!=0	BEGIN
			BEGIN transaction

			select * from Branchwhere idBranch= @idBranch

			commit transaction

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idBranchno existe'
		END
		
		END

	if @opcion = 4
		BEGIN
		if (select count(*) from Branchwhere idBranch= @idBranch)!=0 BEGIN
			BEGIN transaction

			update Branch
			set state = 0 where idBranch= @idBranch

			commit transaction

			END
			else
		BEGIN
			set @error = 1
			set @errorMsg = 'El idBranchno existe'
		
		END
	END
		select @error as error, @errorMsg as mensaje
	
END

-- ****************************************************************************************************************

-- crudEmployee

go
create or alter procedure crudEmployee @opcion int,@idEmployee int, @Name varchar(20), @apellido varchar(20), @DateHiring date,
@foto varchar(100), @idOccupation int, @idBranchint
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from Employee where idEmployee = @idEmployee)= 0 BEGIN
			if @Name is not null and @apellido is not null and @DateHiring is not null and @foto is not null BEGIN
				if (select count(*) from Occupation where idOccupation = @idOccupation)!=0 BEGIN
					if (select count(*) from Branchwhere idBranch= @idBranch)!=0 BEGIN
						
						BEGIN transaction

							insert into Employee(NameEmployee,apellidoEmployee,DateHiring,fotoEmployee,idOccupation,idBranch) 
							values(@Name,@apellido,@DateHiring,@foto,@idOccupation,@idBranch)

						commit transaction

					END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'idBranchno existe'
					END
				END ELSE BEGIN 
					set @error = 2
					set @errorMsg = 'idOccupation no existe'
				END
			END ELSE BEGIN 
				set @error = 3
				set @errorMsg = 'No pueden ir valores nulos'
			END
		END ELSE BEGIN 
			set @error = 4
			set @errorMsg = 'idEmployee ya existe'
		END

	END
	

	if @opcion = 2 BEGIN
		if (select count(*) from Employee where idEmployee = @idEmployee)!=0 BEGIN
			BEGIN transaction
				update Employee
				set NameEmployee = ISNULL(@Name, NameEmployee), apellidoEmployee = ISNULL(@apellido, apellidoEmployee), 
				DateHiring = ISNULL(@DateHiring, DateHiring), fotoEmployee = ISNULL(@foto, fotoEmployee), idOccupation = ISNULL(@idOccupation, idOccupation),
				idBranch= ISNULL(@idBranch, idBranch) where idEmployee = @idEmployee
			commit transaction 

			END
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idEmployee no existe'
		END
	END

	if @opcion = 3
		BEGIN
		if (select count(*) from Employee where idEmployee = @idEmployee)!= 0 BEGIN
			BEGIN transaction

			select * from Employee where idEmployee = @idEmployee

			commit transaction

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idEmployee no existe'
		END
	END

	if @opcion = 4		BEGIN
		if (select count(*) from Employee where idEmployee = @idEmployee)!=0 BEGIN
			BEGIN transaction
				update Employee
				set state = 0 where idEmployee = @idEmployee
			commit transaction
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idEmployee no existe'
	END
	select @error as error, @errorMsg as mensaje
END

-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudBranchManager @opcion int,@idBranchManger int, @idBranchint , @idEmployee int
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from BranchManager where idBranchManager = @idBranchManger) = 0 BEGIN
			if @idBranchis not null and @idEmployee is not null BEGIN
				if (select count(*) from Employee where idEmployee = @idEmployee)!=0 BEGIN
					if (select count(*) from Branchwhere idBranch= @idBranch)!=0 BEGIN
						
						BEGIN transaction
							insert into BranchManager
							values(@idBranch,@idEmployee)
						commit transaction

					END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'idBranchno existe'
					END
				END ELSE BEGIN 
					set @error = 2
					set @errorMsg = 'idEmployee no existe'
				END
			END ELSE BEGIN 
				set @error = 3
				set @errorMsg = 'No pueden ir valores nulos'
			END
		END ELSE BEGIN 
			set @error = 4
			set @errorMsg = 'Ya existe esa relacion BranchMaganer'
		END

	END

	if @opcion = 2 BEGIN
		if (select count(*) from BranchManager where idBranchManager = @idBranchManger)!=0 BEGIN
			if (select count(*) from Employee where idEmployee = @idEmployee)!=0 BEGIN
				if (select count(*) from Branchwhere idBranch= @idBranch)!=0 BEGIN
					BEGIN transaction
						update BranchManager
						set idEmployee = ISNULL(@idEmployee, idEmployee), idBranch= ISNULL(@idBranch, idBranch)
						where idBranchManager = @idBranchManger
					commit transaction 
				END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'idBranchno existe'
					END
			END ELSE BEGIN 
				set @error = 2
				set @errorMsg = 'idEmployee no existe'
			END			
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idEmployee no existe'
		END
	END

	if @opcion = 3
		BEGIN
		if (select count(*) from BranchManager where idBranchManager = @idBranchManger)!= 0 BEGIN
			BEGIN transaction
			select * from BranchManager where idBranchManager = ISNULL(@idBranchManger,idBranchManager)
			commit transaction

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idEmployee no existe'
		END
	END

	
	select @error as error, @errorMsg as mensaje
END



		
-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudPerformance @opcion int,@idPerformance int, @calificacion int, @descripcion varchar(50), @Date date, @idEmployee int with encryption
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from Performance where idPerformance = @idPerformance)= 0 BEGIN
			if @calificacion is not null and @descripcion is not null and @Date is not null BEGIN
				if (select count(*) from Employee where idEmployee = @idEmployee)!=0 BEGIN
					BEGIN transaction
						insert into Performance(idPerformance,calificacion, descripcionPerformance, Date, idEmployee)
						values(@idPerformance,@calificacion, @descripcion, @Date,@idEmployee)
					commit transaction

				END ELSE BEGIN 
					set @error = 1
					set @errorMsg = 'idEmployee no existe'
				END
			END ELSE BEGIN 
				set @error = 2
				set @errorMsg = 'No pueden ir nulos'
			END
		END ELSE BEGIN 
			set @error = 3
			set @errorMsg = 'idPerformance ya existe'
		END
	END
	

	if @opcion = 2		BEGIN
		if (select count(*) from Performance where idPerformance = @idPerformance)!=0 			BEGIN
			BEGIN transaction
				update Performance
				set calificacion = ISNULL(@calificacion, calificacion), descripcionPerformance = ISNULL(@descripcion, descripcionPerformance), 
				Date = ISNULL(@Date, Date), idEmployee = ISNULL(@idEmployee, idEmployee) where idPerformance = @idPerformance
			commit transaction 

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idPerformance no existe'
		END
	END

	if @opcion = 3		BEGIN
		if (select count(*) from Performance where idPerformance = @idPerformance)!=0 			BEGIN
			BEGIN transaction
				select * from Performance where idPerformance = @idPerformance
			commit transaction
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idPerformance no existe'
		END
	END

	if @opcion = 4		BEGIN
		if (select count(*) from Performance where idPerformance = @idPerformance)!=0 	BEGIN
			BEGIN transaction
				update Performance
				set state = 0 where idPerformance = @idPerformance
			commit transaction
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idPerformance no existe'
		END

	END

		select @error as error, @errorMsg as mensaje
		
END

-- ****************************************************************************************************************

go
create or alter procedure crudBonus @opcion int,@idBonus int, @Date date, @amountBonus money, @idTipoBonus int, @idEmployee int with encryption
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from Bonus where idBonus = @idBonus)= 0 BEGIN
			if @Date is not null and @amountBonus is not null BEGIN
				if (select count(*) from TipoBonus where idTipoBonus = @idTipoBonus)!=0 BEGIN
					if (select count(*) from Employee where idEmployee = @idEmployee)!=0 BEGIN
						BEGIN transaction

						insert into Bonus(idBonus,Date,amountBonus, idTipoBonus, idEmployee)
						values(@idBonus,@Date,@amountBonus, @idTipoBonus, @idEmployee)

						commit transaction
					END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'idEmployee no existe'
					END
				END ELSE BEGIN 
					set @error = 1
					set @errorMsg = 'idTipoBonus no existe'
				END
			END ELSE BEGIN 
				set @error = 2
				set @errorMsg = 'No pueden ir nulos'
			END
		END ELSE BEGIN 
			set @error = 3
			set @errorMsg = 'idBonus ya existe'
		END
	END
	

	if @opcion = 2
		BEGIN
		if (select count(*) from Bonus where idBonus = @idBonus)!=0 
			BEGIN
			BEGIN transaction
			update Bonus
				set Date = ISNULL(@Date, Date), amountBonus = ISNULL(@amountBonus, amountBonus), 
				idTipoBonus = ISNULL(@idTipoBonus, idTipoBonus), idEmployee = ISNULL(@idEmployee, idEmployee) where idBonus = @idBonus
			commit transaction 
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idBonus no existe'
		END
	END
	if @opcion = 3
		BEGIN
		if (select count(*) from Bonus where idBonus = @idBonus)!=0 
			BEGIN
			BEGIN transaction
			select * from Bonus where idBonus = @idBonus
			commit transaction

		END ELSE BEGIN 
		set @error = 1
		set @errorMsg = 'El idBonus no existe'
		END
	END

	if @opcion = 4
		BEGIN
		if (select count(*) from Bonus where idBonus = @idBonus)!=0 
			BEGIN
			BEGIN transaction
			update Bonus
			set state = 0 where  idBonus = @idBonus
			commit transaction

		END ELSE BEGIN 
		set @error = 1
		set @errorMsg = 'El idBonus no existe'
		END

	END

		select @error as error, @errorMsg as mensaje
		
END

-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudSchedule @opcion int,@idSchedule int, @horaInicial time, @horaFinal time, @dia varchar(15), @idBranchint
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from Schedule where idSchedule = @idSchedule)= 0 BEGIN
			if @horaInicial is not null and @horaFinal is not null and @dia is not null
				BEGIN
				if (select count(*) from Branchwhere idBranch= @idBranch)!=0 
					BEGIN
					BEGIN transaction
					insert into Schedule(idSchedule, ScheduleInicial, ScheduleFinal, dia, idBranch) 
					values(@idSchedule, @horaInicial, @horaFinal, @dia, @idBranch)
					commit transaction

				END ELSE BEGIN 
				set @error = 1
				set @errorMsg = 'idBranchno existe'
				END

			END ELSE BEGIN 
			set @error = 2
			set @errorMsg = 'No pueden ir valores nulos' 
			END

		END ELSE BEGIN 
		set @error = 3
		set @errorMsg = 'idSchedule ya existe'
		END

	END
	

	if @opcion = 2
		BEGIN
		if (select count(*) from Schedule where idSchedule = @idSchedule)!=0 			BEGIN
			BEGIN transaction
				update Schedule
				set ScheduleInicial = ISNULL(@horaInicial, ScheduleInicial),ScheduleFinal = ISNULL(@horaFinal, ScheduleFinal), dia = ISNULL(@dia, dia),
				idBranch= ISNULL(@idBranch, idBranch) where idSchedule = @idSchedule
			commit transaction 

		END ELSE BEGIN  
			set @error = 1
			set @errorMsg = 'El idSchedule no existe'
		END
	END
	if @opcion = 3		BEGIN
		if (select count(*) from Schedule where idSchedule = @idSchedule)!= 0 BEGIN
			BEGIN transaction
				select * from Schedule where idSchedule = @idSchedule
			commit transaction
		END ELSE BEGIN 
		set @error = 1
		set @errorMsg = 'El idSchedule no existe'
		END
	END

	if @opcion = 4
		BEGIN
		if (select count(*) from Schedule where idSchedule = @idSchedule)!=0 			BEGIN
			BEGIN transaction
				delete from Schedule where idSchedule = @idSchedule
			commit transaction

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idSchedule no existe'
		END
	END
		select @error as error, @errorMsg as mensaje		
	END

-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudMonedaXCountry @opcion int,@idMonedaXCountry int, @idCountry int, @cambioPorcentaje float,  @idMoneda int
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1		BEGIN
		if (select count(*) from MonedaXCountry where idMonedaXCountry = @idMonedaXCountry)= 0 BEGIN
			if (select count(*) from Country where idCountry = @idCountry)!=0 BEGIN
				if @cambioPorcentaje is not null BEGIN
					if (select count(*) from Moneda where idMoneda = @idMoneda)!=0 BEGIN
						BEGIN transaction
							insert into MonedaXCountry( idCountry,cambioPorcentaje,idMoneda) 
							values(@idCountry,@cambioPorcentaje,@idMoneda)
						commit transaction

					END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'idMoneda no existe'
					END
				END ELSE BEGIN 
					set @error = 2
					set @errorMsg = 'No pueden ir valores nulos' 
				END

			END ELSE BEGIN 
				set @error = 3
				set @errorMsg = 'idCountry no existe' 
			END
		END ELSE BEGIN 
			set @error = 4
			set @errorMsg = 'idMonedaXCountry ya existe'
		END

		END

	if @opcion = 2
		BEGIN
		if (select count(*) from MonedaXCountry where idMonedaXCountry = @idMonedaXCountry)!=0 			BEGIN
			BEGIN transaction
				update MonedaXCountry
				set idCountry = ISNULL(@idCountry, idCountry), cambioPorcentaje = ISNULL(@cambioPorcentaje, cambioPorcentaje), idMoneda = ISNULL(@idMoneda, idMoneda)
				where idMonedaXCountry = @idMonedaXCountry
			commit transaction 

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idMonedaXCountry no existe'
		END
		END

if @opcion = 3
		BEGIN
		if (select count(*) from MonedaXCountry where idMonedaXCountry = @idMonedaXCountry)!= 0 BEGIN
			BEGIN transaction
				select * from MonedaXCountry where idMonedaXCountry = @idMonedaXCountry
			commit transaction

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idMonedaXCountry no existe'
		END
		END

	if @opcion = 4
		BEGIN
		if (select count(*) from MonedaXCountry where idMonedaXCountry = @idMonedaXCountry)!=0 
			BEGIN
			BEGIN transaction
				delete from MonedaXCountry where idMonedaXCountry = @idMonedaXCountry
			commit transaction
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idMonedaXCountry no existe'
		END
	END
	select @error as error, @errorMsg as mensaje
		
END

go
CREATE OR ALTER PROCEDURE insertMoneda @Name varchar(20)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 from Moneda where NameMoneda = @Name)
    BEGIN
        Insert into Moneda(NameMoneda)
        VALUES (@Name)
    END ELSE BEGIN 
        Select 0
    END
END

GO

CREATE OR ALTER PROCEDURE insertCountry @Name varchar(20)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 from Country where NameCountry = @Name)
    BEGIN
        Insert into Country(NameCountry)
        VALUES (@Name)
    END ELSE BEGIN 
        Select 0
    END
END
GO

CREATE OR ALTER PROCEDURE insertMonedaXCountry @idP int, @idM int, @cambio FLOAT
AS
BEGIN
    IF EXISTS (SELECT 1 from Country where idCountry = @idP)
    BEGIN
        IF EXISTS (SELECT 1 from Moneda where idMoneda = @idM)
        BEGIN
            insert into MonedaXCountry(idCountry,cambioPorcentaje,idMoneda)
            Values (@idP,@cambio,@idM)  
        END ELSE BEGIN 
            Select 0
        END
    END
    ELSE
    BEGIN
        Select 0
    END
END
GO

CREATE OR ALTER PROCEDURE insertPlace @Name varchar(20), @idP int, @ubi Geometry
AS
BEGIN
    If EXISTS(Select 1 from Country where idCountry = @idP)
    BEGIN
        Insert into Place(NamePlace,idCountry,ubicacion)
        Values (@Name,@idP,@ubi)
    END ELSE BEGIN 
        Select 0
    END
END
GO

CREATE OR ALTER PROCEDURE insertOccupation @Name VARCHAR(20), @salario money
AS
BEGIN
    If NOT EXISTS(SELECT 1 from Occupation where NameOccupation = @Name)
    BEGIN
        Insert into Occupation (NameOccupation,salario)
        Values (@Name,@salario)
    END ELSE BEGIN 
        Select 0
    END
END
Go

Create OR ALTER PROCEDURE insertEmployee @Name VARCHAR(20), @apellido varchar(20), @Date date, @foto NVARCHAR(MAX), @idOccupation int
AS
BEGIN
    If EXISTS (SELECT 1 from Occupation where idOccupation = @idOccupation)
    BEGIN
        insert into Employee(NameEmployee,apellidoEmployee,DateHiring,fotoEmployee,idOccupation)
        values (@Name,@apellido,@Date,@foto,@idOccupation)
    END ELSE BEGIN 
        Select 0
    END
END

GO
CREATE OR ALTER PROCEDURE insertSchedule @inicial time,@final time,@dia date,@idSuc INT
AS
BEGIN
    If EXISTS(Select 1 from Branchwhere idBranch= @idSuc)
    BEGIN
        insert into Schedule(ScheduleInicial,ScheduleFinal,dia,idBranch)
        Values (@inicial,@final,@dia,@idSuc)
    END ELSE BEGIN 
        SELECT 0
    END
END
GO

--===========================================================
--============================CRUDS User==================
--===========================================================


GO
--====================================================
--						Tipo de SignUpCostumer
--===================================================
CREATE OR ALTER PROCEDURE dbo.spSignUpCostumer
	@nombrUser varchar(20) ,
	@contrasena varchar(20),
	@idCliente varchar(20),
	@Name varchar (15),
	@apellidos varchar (15),
	@xPosition float,
	@yPosition float
	with encryption
as
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

--INSERT OPERATION
	IF @nombrUser is not null and @contrasena is not null  and @idCliente is not null and @Name is not null and @apellidos is not null and 
	@xPosition is not null  and @yPosition is not null BEGIN
		IF (select count(*) from TUser where NameUser = @nombrUser ) = 0 BEGIN
			IF (select count(*) from Cliente where idCliente = @idCliente) = 0 BEGIN	
				BEGIN TRY
					BEGIN TRANSACTION
						INSERT INTO User
						VALUES( @nombrUser, @contrasena, 1)	

						INSERT INTO Cliente
							VALUES(@idCliente, @Name, @apellidos,geometry::Point(@xPosition, @yPosition, 0),1)

						INSERT INTO UserXCliente
						VALUES (@idCliente, @nombrUser, 1)
					COMMIT TRANSACTION
				END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'There is an error in de database'
				END CATCH
			END ELSE BEGIN --Final if idCliente			
				set @errorInt=1
				set @errorMsg = 'There already exits this Costumer'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'The already exits this username'
			END
				
	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
		END  ---Final if validacion nulos
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	else
		select 0 as correct, 'The user has sign up succesfuly' as REsult
END

--====================================================
--						User
--===================================================

GO
CREATE OR ALTER PROCEDURE dbo.spUser
	@userName varchar(50) null, 
	@password varchar(20),
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

	if @operationFlag = 0 BEGIN
		IF @userName is not null  and @password is not null BEGIN			
			IF (select count(*) from TUser where @UserName = NameUser) = 0 BEGIN
							
				BEGIN TRY
					BEGIN TRANSACTION
						INSERT INTO User
						VALUES( @userName, @password, 1)						
					COMMIT TRANSACTION
				END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'There is an error in de database'
				END CATCH
				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'The already exits this username'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'There are a null values'
			END  ---Final if validacion nulos

	END
	
	if @operationFlag = 1 BEGIN
		IF @userName is not null and @password is not null BEGIN			
			IF (select count(*) from TUser where @UserName = NameUser) = 0BEGIN				
					BEGIN TRY
						BEGIN TRANSACTION
						update User 
						set contrasena = ISNULL(@password, contrasena)
						where NameUser = @userName
					COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'Error al actualizar a la base de datos'
					END CATCH
		
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'No exits a this username'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'There are a null values'
			END  ---Final if validacion nulos
	END

	if @operationFlag = 2 BEGIN
		select * from TUser
		where NameUser = ISNULL(@userName, NameUser) and state = 1;
	END

	IF @operationFlag = 3 BEGIN
		IF @userName is not null BEGIN
			update User 
			set state = ISNULL(0, state)
			where NameUser = @userName
		END ELSE BEGIN
			set @errorInt=1
			set @errorMsg = 'EL ID no puede ser nulo'
			END  ---Final if validacion nulos
	END
	
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	ELSE
		select 0 as valueResult , 'Funcion hecha sin problema' as Mensaje
END

--====================================================
--						CLIENTE
--===================================================
--Creacion de procedimientoCliente
GO
CREATE OR ALTER PROCEDURE spCliente
	@idCliente varchar (20),
	@Name varchar (15),
	@apellidos varchar (15),
	@xPosition float,
	@yPosition float,	
	@operationFlag int	-- Insert 0, update 1, select 2
	with encryption
as
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)

	if @operationFlag = 0 BEGIN
		if @Name is not null  and @apellidos is not null and @xPosition is not null and @yPosition is not null BEGIN
			IF (select count(*) from Cliente where idCliente = @idCliente) = 0 BEGIN
						

					BEGIN TRY
						BEGIN TRANSACTION												
							INSERT INTO Cliente
							VALUES(@idCliente, @Name, @apellidos,geometry::Point(@xPosition, @yPosition, 0),1)
						COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'There is an error in de database'
						END CATCH
								

			END ELSE BEGIN --Final if idCliente			
				set @errorInt=1
				set @errorMsg = 'There already exits this Costumer'
				END
		END ELSE BEGIN --Final if idCliente			
			set @errorInt=1
			set @errorMsg = 'There are a null values'
			END  ---Final if validacion nulos
	
	END
	
	if @operationFlag = 1 BEGIN
	if @idCliente is not null and @Name is not null  and @apellidos is not null and @xPosition is not null and @yPosition is not null BEGIN
			IF (select count(*) from Cliente where idCliente = @idCliente) = 1 BEGIN

					BEGIN TRY
						BEGIN TRANSACTION
						update Cliente 
						set   NameCliente = ISNULL(@Name, NameCliente), apellidoCliente= ISNULL(@apellidos, apellidoCliente),ubicacion = ISNULL(geometry::Point(@xPosition, @yPosition, 0), ubicacion)
						where idCliente = @idCliente;
					COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'There is an error in de database'
					END CATCH

			END ELSE BEGIN --Final if idCliente			
				set @errorInt=1
				set @errorMsg = 'NO existe un Cliente con este ID'
				END
		END ELSE BEGIN --Final if idCliente			
			set @errorInt=1
			set @errorMsg = 'Hay algun valor nulo'
			END  ---Final if validacion nulos
		
	END

	if @operationFlag = 2
	BEGIN
		select * from Cliente
		where idCliente = ISNULL(@idCliente,idCliente) and state = 1 ;
	END


	if @operationFlag = 3
	BEGIN
		IF @idCliente is not null BEGIN
			update Cliente 
			set state = ISNULL(0, state)
			where idCliente = ISNULL(@idCliente,idCliente)
		END ELSE BEGIN
			set @errorInt=1
			set @errorMsg = 'EL ID no puede ser nulo'
			END  ---Final if validacion nulos
	END

	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	ELSE IF @errorInt = 0 
		select 0 as valueResult, 'Funcion hecha sin problema' as Mensaje
END


GO
CREATE Or ALTER PROCEDURE spLoginCostumer 
@nombrUser varchar(20),
@contrasena varchar(20)
AS
BEGIN
	if @nombrUser is not null and @contrasena is not null BEGIN
		if EXISTS(Select * from TUser where NameUser = @nombrUser and contrasena = @contrasena)
		BEGIN
			Select 0 as ValueResult, 'Login Success' as MSG
		END
		ELSE
		BEGIN
			select 0 as valueResult , 'Invalid credentials' as MSG
		END
	END ELSE BEGIN
		select 0 as valueResult , 'No pueden haber campos nulos' as Mensaje
		END  ---Final if validacion nulos
END


-- ***************************************************************************************************
--							INGRESAR PRODUCTOS AL Inventory
-- ***************************************************************************************************
GO
CREATE OR ALTER PROCEDURE dbo.spGetPriceOfProduct	
	@idbatch int,	
	@idProducto int,	
	@idCountryImOccupation int
	
 	with encryption
as
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)


--INSERT OPERATION
	IF @idProducto is not null and @idbatch is not null BEGIN
		declare @unityCost money;
		declare @porcentajeVenta float;
		declare @porcentajeImOccupation float;
		declare @precioVentaTotal money;

		set @unityCost = (SELECT unityCost from MYSQLSERVER...batch where idbatch = @idbatch and idProducto = @idProducto)
		set @porcentajeVenta = (SELECT porcentajeVenta from MYSQLSERVER...batch where idbatch = @idbatch and idProducto = @idProducto)
		set @porcentajeImOccupation = (SELECT porcentajeImOccupation from MYSQLSERVER...ImOccupation as ImOccupation
									INNER JOIN MYSQLSERVER...categoryXImOccupation as categoryXImOccupation ON categoryXImOccupation.idcategoryXImOccupation = ImOccupation.idImOccupation
									INNER JOIN MYSQLSERVER...categoryProducto as category ON category.idcategory = categoryXImOccupation.idcategoryXImOccupation
									WHERE ImOccupation.idCountry = @idCountryImOccupation)
		
		set @precioVentaTotal = (@unityCost *@porcentajeVenta) + @unityCost
		set @precioVentaTotal = (@precioVentaTotal * @porcentajeImOccupation) +@precioVentaTotal
		
		
		
	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
		END  ---Final if validacion nulos
	if @errorInt !=0
		RETURN 0
	else
		RETURN @precioVentaTotal 
END


GO
CREATE OR ALTER PROCEDURE dbo.spInsertProductToInventory
	@idInventory int,
	@amount int,
	@idBranchint,
	@idbatch int,
	@precioVenta money,
	@option int				--Insertar insertarProducto nuevo 0, agregaramount Pedido
 	with encryption
as
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

--INSERT OPERATION
	IF @amount is not null  and @idBranchis not null and @idbatch is not null BEGIN
		IF (select count(*) from Branchwhere  idBranch= @idBranch) = 1 BEGIN
			IF (select count(*) from MYSQLSERVER...batch where idbatch = @idbatch) = 1 BEGIN	
				BEGIN TRY
					
						declare @idCountry int;
						declare @idProducto int;
						
						set @idCountry = (select idCountry FROM Branch
										INNER JOIN Place ON Place.idPlace = Branch.idPlace
										where Branch.idBranch= @idBranch)
						set @idProducto = (select idProducto FROM MYSQLSERVER...batch where idbatch = @idbatch)
						
						--idbatch, idproducto, idCountry
						EXEC @precioVenta = spGetPriceOfProduct @idbatch,@idProducto,@idCountry
					
						INSERT INTO Inventory (amountInventory, idbatch, idBranch, precioVenta)
						VALUES (@amount, @idbatch,@idBranch,@precioVenta)
					
				END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'There is an error in de database'
				END CATCH
			END ELSE BEGIN --Final if idCliente			
				set @errorInt=1
				set @errorMsg = 'idbatch no existe'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'idSucarsasl no existe'
			END
				
	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
		END  ---Final if validacion nulos
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	--else
		--select 0 as correct, 'The user has sign up succesfuly' as REsult
END

-- idInventory, amount, @idBranch, @idbatch, @precioVenta
-- EXEC spInsertProductToInventory null, 30, 1, 1,null, 0

GO
CREATE OR ALTER PROCEDURE dbo.spGetCortumerIdByUserName
	@NameUser varchar(200)
with encryption
as
BEGIN
    declare @errorInt int = 0, @errorMsg varchar(60)
    BEGIN TRY
        SELECT Cliente.idCliente FROM Cliente
		INNER JOIN UserXCliente ON UserxCliente.idCliente = Cliente.idCliente
		INNER JOIN User ON User.NameUser = UserXCliente.NameUser
		WHERE  UserXCliente.NameUser = @NameUser
    END TRY
    BEGIN CATCH
        set @errorInt=1
        set @errorMsg = 'There is an error in de database'
    END CATCH
    if @errorInt !=0
        select @errorInt as Error, @ErrorMsg as MensajeError
END

GO
CREATE OR ALTER PROCEDURE dbo.spGetOtherBranches
	@idBranchint
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	BEGIN TRY
		select * from Branchwhere idBranch!= @idBranch
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END

GO
CREATE OR ALTER PROCEDURE dbo.spGetIdCustomerFromUser
	@NameUser varchar(50)
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	BEGIN TRY
		select Cliente.idCliente from Cliente inner join UserXCliente on
		UserXCliente.idCliente = Cliente.idCliente inner join User on
		UserXCliente.NameUser = User.NameUser where User.NameUser = @NameUser
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END

GO
CREATE OR ALTER PROCEDURE dbo.spClosestPoint
	@idCliente nvarchar(20)
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(20)
declare @pointCliente geometry
	
	BEGIN TRY
		set @pointCliente = (select ubicacion from Cliente where idCliente = @idCliente);

		SELECT TOP 1 Branch.idBranch, Branch.NameBranchFROM Branch
		inner join Place on Place.idPlace = Branch.idPlace
		ORDER BY @pointCliente.STDistance(Place.ubicacion) ASC;
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt != 0
		select @errorInt as error, @errorMsg as mensaje
end

GO
CREATE OR ALTER PROCEDURE dbo.spGetProductsByBranch
    @idBranchint
    with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(20)
	
	BEGIN TRY
		select Producto.nombreProducto, Producto.imgPath, Lote.idLote, Inventario.idInventario, Inventario.precioVenta from Sucursal 
		inner join Inventario on Sucursal.idSucursal = Inventario.idSucursal inner join MYSQLSERVER...Lote on
		Lote.idLote = Inventario.idLote inner join MYSQLSERVER...Producto on Producto.idProducto = Lote.idProducto
		where Sucursal.idSucursal = @idSucursal
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'Error al agregar a la base de datos'
	END CATCH

    if @errorInt != 0
        select @errorInt as error, @errorMsg as mensaje
end


-- exec spGetProductsByBranch 6


/*

SELECT Producto.idProducto, Producto.NameProducto, Producto.imgPath, batch.idbatch, Inventory.precioVenta, Branch.idBranchFROM MYSQLSERVER...Producto as Producto
INNER JOIN MYSQLSERVER...batch AS batch ON batch.idProducto = Producto.idProducto
INNER JOIN Inventory ON Inventory.idbatch = batch.idbatch
INNER JOIN BranchON Branch.idBranch= Inventory.idBranch
where Branch.idBranch= 6
*/