
-- =============================================
--             script to drop Foreign Keys
-- =============================================
USE BD_PROYECTO      ;
GO
SET NOCOUNT ON;
DECLARE @sql nvarchar(max) = N'';

SELECT @sql += N'BEGIN TRY
  ALTER TABLE ' + objectname + N'
    DROP CONSTRAINT ' + fkname + N';
END TRY
BEGIN CATCH
  SELECT N''FK ' + fkname + N' failed. Run the script again.'', 
    ERROR_MESSAGE();
END CATCH
' FROM 
(
  SELECT fkname = QUOTENAME(fk.[name]), 
    objectname = QUOTENAME(s.[name]) + N'.' + QUOTENAME(t.[name])
  FROM sys.foreign_keys AS fk
  INNER JOIN sys.objects AS t
  ON fk.parent_object_id = t.[object_id]
  INNER JOIN sys.schemas AS s
  ON t.[schema_id] = s.[schema_id]
) AS src;

SELECT @sql;
--EXEC sys.sp_executesql @sql;

-- =============================================
--             script to drop user tables
-- =============================================
USE BD_PROYECTO      ;
GO
DECLARE @sql nvarchar(max) = N'';

SELECT @sql += N'BEGIN TRY
  EXEC sys.sp_executesql N''DROP TABLE ' + objectname + N';'';
END TRY
BEGIN CATCH
  SELECT N''Table ' + objectname + N' failed - run the script again.'',
    ERROR_MESSAGE();
END CATCH
' FROM
(
  SELECT QUOTENAME(s.[name]) + N'.' + QUOTENAME(o.[name])
  FROM sys.tables AS o
  INNER JOIN sys.schemas AS s 
  ON o.[schema_id] = s.[schema_id]
  WHERE o.is_ms_shipped = 0
) AS src(objectname);

SELECT @sql;
--EXEC sys.sp_executesql @sql;


-- =============================================
--             script to drop store procedures
-- =============================================
-- script to drop procedures
USE BD_PROYECTO           ;
GO
DECLARE @sql nvarchar(max) = N'';

SELECT @sql += N'BEGIN TRY
  EXEC sys.sp_executesql N''DROP PROCEDURE ' + objectname + N';'';
END TRY
BEGIN CATCH
  SELECT N''Procedure ' + objectname + N' failed - run the script again.'',
    ERROR_MESSAGE();
END CATCH
' FROM
(
  SELECT QUOTENAME(s.[name]) + N'.' + QUOTENAME(o.[name])
  FROM sys.objects AS o
  INNER JOIN sys.schemas AS s 
  ON o.[schema_id] = s.[schema_id]
  WHERE o.[type] = 'P'
  AND o.is_ms_shipped = 0
) AS src(objectname);

SELECT @sql;
--EXEC sys.sp_executesql @sql;

-- =============================================
--             script to drop all of data
-- =============================================
/*
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL' 
GO 

EXEC sp_MSForEachTable 'DELETE FROM ?' 
GO 

-- enable referential integrity again 
EXEC sp_MSForEachTable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL' 
GO
*/


-- =============================================
--             delete primary keys
-- =============================================
DECLARE @object_id int;
DECLARE @parent_object_id int;
DECLARE @TSQL NVARCHAR(4000);
DECLARE @COLUMN_NAME SYSNAME;
DECLARE @is_descending_key bit;
DECLARE @col1 BIT;
DECLARE @action CHAR(6);
 
--SET @action = 'DROP';
SET @action = 'CREATE';
 
DECLARE PKcursor CURSOR FOR
    select kc.object_id, kc.parent_object_id
    from sys.key_constraints kc
    inner join sys.objects o
    on kc.parent_object_id = o.object_id
    where kc.type = 'PK' and o.type = 'U'
    and o.name not in ('dtproperties','sysdiagrams')  -- not true user tables
    order by QUOTENAME(OBJECT_SCHEMA_NAME(kc.parent_object_id))
            ,QUOTENAME(OBJECT_NAME(kc.parent_object_id));
 
OPEN PKcursor;
FETCH NEXT FROM PKcursor INTO @object_id, @parent_object_id;
  
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @action = 'DROP'
        SET @TSQL = 'ALTER TABLE '
                  + QUOTENAME(OBJECT_SCHEMA_NAME(@parent_object_id))
                  + '.' + QUOTENAME(OBJECT_NAME(@parent_object_id))
                  + ' DROP CONSTRAINT ' + QUOTENAME(OBJECT_NAME(@object_id))
    ELSE
        BEGIN
        SET @TSQL = 'ALTER TABLE '
                  + QUOTENAME(OBJECT_SCHEMA_NAME(@parent_object_id))
                  + '.' + QUOTENAME(OBJECT_NAME(@parent_object_id))
                  + ' ADD CONSTRAINT ' + QUOTENAME(OBJECT_NAME(@object_id))
                  + ' PRIMARY KEY'
                  + CASE INDEXPROPERTY(@parent_object_id
                                      ,OBJECT_NAME(@object_id),'IsClustered')
                        WHEN 1 THEN ' CLUSTERED'
                        ELSE ' NONCLUSTERED'
                    END
                  + ' (';
 
        DECLARE ColumnCursor CURSOR FOR
            select COL_NAME(@parent_object_id,ic.column_id), ic.is_descending_key
            from sys.indexes i
            inner join sys.index_columns ic
            on i.object_id = ic.object_id and i.index_id = ic.index_id
            where i.object_id = @parent_object_id
            and i.name = OBJECT_NAME(@object_id)
            order by ic.key_ordinal;
 
        OPEN ColumnCursor;
 
        SET @col1 = 1;
 
        FETCH NEXT FROM ColumnCursor INTO @COLUMN_NAME, @is_descending_key;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF (@col1 = 1)
                SET @col1 = 0
            ELSE
                SET @TSQL = @TSQL + ',';
 
            SET @TSQL = @TSQL + QUOTENAME(@COLUMN_NAME)
                      + ' '
                      + CASE @is_descending_key
                            WHEN 0 THEN 'ASC'
                            ELSE 'DESC'
                        END;
 
            FETCH NEXT FROM ColumnCursor INTO @COLUMN_NAME, @is_descending_key;
        END;
 
        CLOSE ColumnCursor;
        DEALLOCATE ColumnCursor;
 
        SET @TSQL = @TSQL + ');';
 
        END;
 
    PRINT @TSQL;
 
    FETCH NEXT FROM PKcursor INTO @object_id, @parent_object_id;
END;
 
CLOSE PKcursor;
DEALLOCATE PKcursor;

BEGIN TRY    ALTER TABLE [dbo].[MonedaXPais]      DROP CONSTRAINT [FK__MonedaXPa__idPai__1C149CA5];  END TRY  BEGIN CATCH    SELECT N'FK [FK__MonedaXPa__idPai__1C149CA5] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[MonedaXPais]      DROP CONSTRAINT [FK__MonedaXPa__idMon__1D08C0DE];  END TRY  BEGIN CATCH    SELECT N'FK [FK__MonedaXPa__idMon__1D08C0DE] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Lugar]      DROP CONSTRAINT [FK__Lugar__idPais__20D951C2];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Lugar__idPais__20D951C2] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Sucursal]      DROP CONSTRAINT [FK__Sucursal__idLuga__27864F51];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Sucursal__idLuga__27864F51] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Sucursal]      DROP CONSTRAINT [FK__Sucursal__idMone__287A738A];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Sucursal__idMone__287A738A] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Empleado]      DROP CONSTRAINT [FK__Empleado__idPues__2C4B046E];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Empleado__idPues__2C4B046E] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Empleado]      DROP CONSTRAINT [FK__Empleado__idSucu__2D3F28A7];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Empleado__idSucu__2D3F28A7] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[SucursalManager]      DROP CONSTRAINT [FK__SucursalM__idSuc__310FB98B];  END TRY  BEGIN CATCH    SELECT N'FK [FK__SucursalM__idSuc__310FB98B] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[SucursalManager]      DROP CONSTRAINT [FK__SucursalM__idEmp__3203DDC4];  END TRY  BEGIN CATCH    SELECT N'FK [FK__SucursalM__idEmp__3203DDC4] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Inventario]      DROP CONSTRAINT [FK__Inventari__idSuc__34E04A6F];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Inventari__idSuc__34E04A6F] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[UsuarioXCliente]      DROP CONSTRAINT [FK__UsuarioXC__idCli__41462154];  END TRY  BEGIN CATCH    SELECT N'FK [FK__UsuarioXC__idCli__41462154] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[UsuarioXCliente]      DROP CONSTRAINT [FK__UsuarioXC__nombr__423A458D];  END TRY  BEGIN CATCH    SELECT N'FK [FK__UsuarioXC__nombr__423A458D] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[UsuarioXEmpleado]      DROP CONSTRAINT [FK__UsuarioXE__nombr__460AD671];  END TRY  BEGIN CATCH    SELECT N'FK [FK__UsuarioXE__nombr__460AD671] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Factura]      DROP CONSTRAINT [FK__Factura__idSucur__4CB7D400];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Factura__idSucur__4CB7D400] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Factura]      DROP CONSTRAINT [FK__Factura__idClien__4DABF839];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Factura__idClien__4DABF839] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Factura]      DROP CONSTRAINT [FK__Factura__idMetod__4EA01C72];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Factura__idMetod__4EA01C72] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[FacturaxEmpleado]      DROP CONSTRAINT [FK__FacturaxE__idFac__5270AD56];  END TRY  BEGIN CATCH    SELECT N'FK [FK__FacturaxE__idFac__5270AD56] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[FacturaxEmpleado]      DROP CONSTRAINT [FK__FacturaxE__idEmp__5364D18F];  END TRY  BEGIN CATCH    SELECT N'FK [FK__FacturaxE__idEmp__5364D18F] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[DetalleFactura]      DROP CONSTRAINT [FK__DetalleFa__idFac__56413E3A];  END TRY  BEGIN CATCH    SELECT N'FK [FK__DetalleFa__idFac__56413E3A] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Pedido]      DROP CONSTRAINT [FK__Pedido__idFactur__5A11CF1E];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Pedido__idFactur__5A11CF1E] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Pedido]      DROP CONSTRAINT [FK__Pedido__idClient__5B05F357];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Pedido__idClient__5B05F357] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Performance]      DROP CONSTRAINT [FK__Performan__idEmp__5ED6843B];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Performan__idEmp__5ED6843B] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Bono]      DROP CONSTRAINT [FK__Bono__idTipoBono__658381CA];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Bono__idTipoBono__658381CA] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Bono]      DROP CONSTRAINT [FK__Bono__idEmpleado__6677A603];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Bono__idEmpleado__6677A603] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[DescuentoXInventario]      DROP CONSTRAINT [FK__Descuento__idInv__6D24A392];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Descuento__idInv__6D24A392] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[DescuentoXInventario]      DROP CONSTRAINT [FK__Descuento__idDes__6E18C7CB];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Descuento__idDes__6E18C7CB] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[ventasEmpleado]      DROP CONSTRAINT [FK__ventasEmp__idEmp__70F53476];  END TRY  BEGIN CATCH    SELECT N'FK [FK__ventasEmp__idEmp__70F53476] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  

BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Moneda];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Moneda] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Pais];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Pais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[MonedaXPais];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[MonedaXPais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Lugar];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Lugar] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Puesto];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Puesto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Sucursal];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Sucursal] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Empleado];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Empleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[SucursalManager];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[SucursalManager] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Inventario];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Inventario] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Horario];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Horario] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Usuario];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Usuario] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Cliente];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Cliente] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[UsuarioXCliente];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[UsuarioXCliente] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[UsuarioXEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[UsuarioXEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[MetodoPago];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[MetodoPago] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Factura];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Factura] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[FacturaxEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[FacturaxEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[DetalleFactura];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[DetalleFactura] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Pedido];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Pedido] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Performance];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Performance] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[TipoBono];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[TipoBono] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Bono];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Bono] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Descuento];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Descuento] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[DescuentoXInventario];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[DescuentoXInventario] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[ventasEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[ventasEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  

BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetSucursalDropList];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetSucursalDropList] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spBonoAutomaticoSucio];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spBonoAutomaticoSucio] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetPuestoDropList];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetPuestoDropList] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectExchangeToView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectExchangeToView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[getAllEmployee];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[getAllEmployee] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCrudCategoriaProducto];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCrudCategoriaProducto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCrudProducto];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCrudProducto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCrudImpuesto];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCrudImpuesto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCrudCategoriaImpuesto];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCrudCategoriaImpuesto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCrudProveedor];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCrudProveedor] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCrudLote];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCrudLote] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCrudLimite];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCrudLimite] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectProductsToView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectProductsToView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectLotetoView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectLotetoView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectInventoryView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectInventoryView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudSucursalManager];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudSucursalManager] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudPerformance];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudPerformance] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudBono];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudBono] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudHorario];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudHorario] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudMonedaXPais];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudMonedaXPais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertMoneda];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertMoneda] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertPais];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertPais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertMonedaXPais];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertMonedaXPais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertLugar];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertLugar] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertPuesto];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertPuesto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertHorario];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertHorario] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSignUpCostumer];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSignUpCostumer] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spUser];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spUser] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCliente];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCliente] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spLoginCostumer];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spLoginCostumer] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetPriceOfProduct];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetPriceOfProduct] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spInsertProductToInventory];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spInsertProductToInventory] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetCortumerIdByUserName];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetCortumerIdByUserName] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetOtherBranches];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetOtherBranches] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetIdCustomerFromUser];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetIdCustomerFromUser] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spClosestPoint];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spClosestPoint] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetProductsByBranch];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetProductsByBranch] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spValidarEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spValidarEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spActualizarEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spActualizarEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spValidPuestoSucursal];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spValidPuestoSucursal] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spInsertarEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spInsertarEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spEliminarEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spEliminarEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[verEmpleados];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[verEmpleados] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectSucursalesToView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectSucursalesToView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudSucursal];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudSucursal] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectProviderToView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectProviderToView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[verClientes];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[verClientes] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spBonoPerformance];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spBonoPerformance] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[reporteBonos];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[reporteBonos] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetCountries];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetCountries] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetImpuestoxCategory];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetImpuestoxCategory] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spProductByPucharse];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spProductByPucharse] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCostumerPurcharse];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCostumerPurcharse] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetPaymentMethod];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetPaymentMethod] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetBranchesLocation];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetBranchesLocation] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spRemoveExpiredProducts];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spRemoveExpiredProducts] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spShowExpiredProducts];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spShowExpiredProducts] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spChangeDiscount];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spChangeDiscount] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetProductsForDiscount];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetProductsForDiscount] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spApplyDiscount];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spApplyDiscount] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spShowProductsDiscount];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spShowProductsDiscount] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectTaxToView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectTaxToView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetLugares];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetLugares] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetMonedaXPais];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetMonedaXPais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudLugar];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudLugar] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectLugarToView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectLugarToView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetCoin];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetCoin] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectMetodoToView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectMetodoToView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetPaymentType];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetPaymentType] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectPuestoToView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectPuestoToView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudMetodoPago];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudMetodoPago] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudPuesto];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudPuesto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spReporteExpirados];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spReporteExpirados] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spReporteClientes];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spReporteClientes] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spReporteProductosVendidos];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spReporteProductosVendidos] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetCantNeed];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetCantNeed] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetBestProvider];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetBestProvider] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spBonoAutomatico];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spBonoAutomatico] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[viewBono];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[viewBono] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectHorarioToView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectHorarioToView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spGetSucursales];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spGetSucursales] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSelectManagerToView];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSelectManagerToView] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  

