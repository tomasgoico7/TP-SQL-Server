-- Usar la base de datos
USE CURESA
GO

-- Crear esquemas si no existen
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'pte')
BEGIN
    EXEC('CREATE SCHEMA pte;');
    PRINT 'El esquema pte ha sido creado.';
END
ELSE
BEGIN
    PRINT 'El esquema pte ya existe.';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'med')
BEGIN
    EXEC('CREATE SCHEMA med;');
    PRINT 'El esquema med ha sido creado.';
END
ELSE
BEGIN
    PRINT 'El esquema med ya existe.';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'turno')
BEGIN
    EXEC('CREATE SCHEMA turno;');
    PRINT 'El esquema turno ha sido creado.';
END
ELSE
BEGIN
    PRINT 'El esquema turno ya existe.';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'sede')
BEGIN
    EXEC('CREATE SCHEMA sede;');
    PRINT 'El esquema sede ha sido creado.';
END
ELSE
BEGIN
    PRINT 'El esquema sede ya existe.';
END
GO