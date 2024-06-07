-- Crear la base de datos si no existe
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'CURESA')
BEGIN
    CREATE DATABASE CURESA;
    PRINT 'La base de datos CURESA ha sido creada.';
END
ELSE
BEGIN
    PRINT 'La base de datos CURESA ya existe.';
END
GO