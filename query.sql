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

-- Usar la base de datos
USE CURESA
GO

-- Crear esquemas si no existen
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'func')
BEGIN
    EXEC('CREATE SCHEMA func;');
    PRINT 'El esquema func ha sido creado.';
END
ELSE
BEGIN
    PRINT 'El esquema func ya existe.';
END
GO

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



-- Crear tabla Prestador primero porque es referenciada por Cobertura
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'Prestador' AND s.name = 'pte')
BEGIN
    CREATE TABLE pte.Prestador (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(50) NOT NULL,
        PlanPrestador VARCHAR(50) NOT NULL
    );
END
ELSE
BEGIN 
    PRINT('La tabla Prestador ya existe.')
END
go

-- Crear tabla Cobertura
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'Cobertura' AND s.name = 'pte')
BEGIN
    CREATE TABLE pte.Cobertura (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        ImagenCredencial VARBINARY(MAX),
        NroSocio VARCHAR(50) NOT NULL,
        FechaRegistro DATE NOT NULL,
        IdPrestador INT NOT NULL,
        CONSTRAINT FK_Paciente_Prestador FOREIGN KEY (IdPrestador) REFERENCES pte.Prestador (ID)
    );
END
ELSE
BEGIN 
    PRINT('La tabla Cobertura ya existe.')
END
go

-- Crear tabla Domicilio
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'Domicilio' AND s.name = 'pte')
BEGIN
    CREATE TABLE pte.Domicilio (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Calle VARCHAR(100) NOT NULL,
        Numero VARCHAR(10) NOT NULL,
        Piso VARCHAR(10),
        Departamento VARCHAR(10),
        CodigoPostal VARCHAR(20) NOT NULL,
        Pais VARCHAR(50) NOT NULL,
        Provincia VARCHAR(50) NOT NULL,
        Localidad VARCHAR(50) NOT NULL
    );
END
ELSE
BEGIN 
    PRINT('La tabla Domicilio ya existe.')
END
go

-- Crear tabla Usuario
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'Usuario' AND s.name = 'pte')
BEGIN
    CREATE TABLE pte.Usuario (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Contraseña VARCHAR(50) NOT NULL,
        FechaCreacion DATE NOT NULL
    );
END
ELSE
BEGIN 
    PRINT('La tabla Usuario ya existe.')
END
go

-- Crear tabla Estudio
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'Estudio' AND s.name = 'pte')
BEGIN
    CREATE TABLE pte.Estudio (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Fecha DATE NOT NULL,
        NombreEstudio VARCHAR(100) NOT NULL,
        EstaAutorizado BIT NOT NULL,
        DocumentoResultado VARCHAR(50) NOT NULL,
        ImagenResultado VARBINARY(MAX)
    );
END
ELSE
BEGIN 
    PRINT('La tabla Estudio ya existe.')
END
go

-- Crear tabla Paciente
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'Paciente' AND s.name = 'pte')
BEGIN
    CREATE TABLE pte.Paciente (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(50) NOT NULL,
        Apellido VARCHAR(50) NOT NULL,
        ApellidoMaterno VARCHAR(50),
        FechaNacimiento DATE NOT NULL,
        TipoDoc VARCHAR(20) NOT NULL,
        NumeroDoc VARCHAR(20) NOT NULL,
        SexoBiologico VARCHAR(10) NOT NULL,
        Genero VARCHAR(20) NOT NULL,
        Nacionalidad VARCHAR(50) NOT NULL,
        FotoPerfil VARBINARY(MAX),
        Mail VARCHAR(100) NOT NULL,
        TelFijo VARCHAR(20),
        TelAlternativo VARCHAR(20),
        TelLaboral VARCHAR(20),
        FechaRegistro DATE NOT NULL,
        FechaActualizacion DATE NOT NULL,
        UsuarioActualizacion VARCHAR(50) NOT NULL,
        IdUsuario INT NOT NULL,
        IdEstudio INT,
        IdCobertura INT,
        CONSTRAINT FK_Paciente_Usuario FOREIGN KEY (IdUsuario) REFERENCES pte.Usuario(ID),
        CONSTRAINT FK_Paciente_Estudio FOREIGN KEY (IdEstudio) REFERENCES pte.Estudio(ID),
        CONSTRAINT FK_Paciente_Cobertura FOREIGN KEY (IdCobertura) REFERENCES pte.Cobertura(ID)
    );
END
ELSE
BEGIN 
    PRINT('La tabla Paciente ya existe.')
END
go

-- Crear tabla Especialidad
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'Especialidad' AND s.name = 'med')
BEGIN
    CREATE TABLE med.Especialidad (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(50) NOT NULL
    );
END
ELSE
BEGIN 
    PRINT('La tabla Especialidad ya existe.')
END
go

-- Crear tabla Medico
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'Medico' AND s.name = 'med')
BEGIN
    CREATE TABLE med.Medico (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(50) NOT NULL,
        Apellido VARCHAR(50) NOT NULL,
        NroMatricula VARCHAR(20) NOT NULL,
        IdEspecialidad INT NOT NULL,
        CONSTRAINT FK_Medico_Especialidad FOREIGN KEY (IdEspecialidad) REFERENCES med.Especialidad(ID)
    );
END
ELSE
BEGIN 
    PRINT('La tabla Medico ya existe.')
END
go

-- Crear tabla TipoTurno
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'TipoTurno' AND s.name = 'turno')
BEGIN
    CREATE TABLE turno.TipoTurno (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(50) NOT NULL
    );
END
ELSE
BEGIN 
    PRINT('La tabla TipoTurno ya existe.')
END
go

-- Crear tabla EstadoTurno
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'EstadoTurno' AND s.name = 'turno')
BEGIN
    CREATE TABLE turno.EstadoTurno (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        NombreEstado VARCHAR(50) NOT NULL
    );
END
ELSE
BEGIN 
    PRINT('La tabla EstadoTurno ya existe.')
END
go

-- Crear tabla Sede
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'Sede' AND s.name = 'sede')
BEGIN
    CREATE TABLE sede.Sede (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(50) NOT NULL,
        Direccion VARCHAR(255) NOT NULL
    );
END
ELSE
BEGIN 
    PRINT('La tabla Sede ya existe.')
END
go

-- Crear tabla DiaSede
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'DiaSede' AND s.name = 'sede')
BEGIN
    CREATE TABLE sede.DiaSede (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Dia DATE NOT NULL,
        HoraInicio TIME NOT NULL,
        IdSede INT NOT NULL,
        IdMedico INT NOT NULL,
        CONSTRAINT FK_DiaSede_Sede FOREIGN KEY (IdSede) REFERENCES sede.Sede(ID),
        CONSTRAINT FK_DiaSede_Medico FOREIGN KEY (IdMedico) REFERENCES med.Medico(ID)
    );
END
ELSE
BEGIN 
    PRINT('La tabla DiaSede ya existe.')
END
go

-- Crear tabla Reserva
IF NOT EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = 'Reserva' AND s.name = 'turno')
BEGIN
    CREATE TABLE turno.Reserva (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Fecha DATE NOT NULL,
        Hora TIME NOT NULL,
        IdMedico INT NOT NULL,
        IdEspecialidad INT NOT NULL,
        IdSede INT NOT NULL,
        IdEstadoTurno INT NOT NULL,
        IdTipoTurno INT NOT NULL,
        CONSTRAINT FK_Reserva_Medico FOREIGN KEY (IdMedico) REFERENCES med.Medico(ID),
        CONSTRAINT FK_Reserva_Especialidad FOREIGN KEY (IdEspecialidad) REFERENCES med.Especialidad(ID),
        CONSTRAINT FK_Reserva_Sede FOREIGN KEY (IdSede) REFERENCES sede.Sede(ID),
        CONSTRAINT FK_Reserva_EstadoTurno FOREIGN KEY (IdEstadoTurno) REFERENCES turno.EstadoTurno(ID),
        CONSTRAINT FK_Reserva_TipoTurno FOREIGN KEY (IdTipoTurno) REFERENCES turno.TipoTurno(ID)
    );
END
ELSE
BEGIN 
    PRINT('La tabla Reserva ya existe.')
END
go

-- Código para eliminar tablas
-- IF OBJECT_ID('pte.Cobertura', 'U') IS NOT NULL DROP TABLE pte.Cobertura;
-- IF OBJECT_ID('pte.Domicilio', 'U') IS NOT NULL DROP TABLE pte.Domicilio;
-- IF OBJECT_ID('pte.Prestador', 'U') IS NOT NULL DROP TABLE pte.Prestador;
-- IF OBJECT_ID('pte.Usuario', 'U') IS NOT NULL DROP TABLE pte.Usuario;
-- IF OBJECT_ID('pte.Estudio', 'U') IS NOT NULL DROP TABLE pte.Estudio;
-- IF OBJECT_ID('pte.Paciente', 'U') IS NOT NULL DROP TABLE pte.Paciente;
-- IF OBJECT_ID('med.Especialidad', 'U') IS NOT NULL DROP TABLE med.Especialidad;
-- IF OBJECT_ID('med.Medico', 'U') IS NOT NULL DROP TABLE med.Medico;
-- IF OBJECT_ID('turno.TipoTurno', 'U') IS NOT NULL DROP TABLE turno.TipoTurno;
-- IF OBJECT_ID('turno.EstadoTurno', 'U') IS NOT NULL DROP TABLE turno.EstadoTurno;
-- IF OBJECT_ID('turno.Reserva', 'U') IS NOT NULL DROP TABLE turno.Reserva;
-- IF OBJECT_ID('sede.Sede', 'U') IS NOT NULL DROP TABLE sede.Sede;
-- IF OBJECT_ID('sede.DiaSede', 'U') IS NOT NULL DROP TABLE sede.DiaSede;

-- Seleccionar datos de las tablas
-- Solo para verificación rápida de la estructura, puedes ejecutar estos select después de crear las tablas.
SELECT * FROM pte.Cobertura;
SELECT * FROM pte.Domicilio;
SELECT * FROM pte.Prestador;
SELECT * FROM pte.Usuario;
SELECT * FROM pte.Estudio;
SELECT * FROM pte.Paciente;
SELECT * FROM med.Especialidad;
SELECT * FROM med.Medico;
SELECT * FROM turno.TipoTurno;
SELECT * FROM turno.EstadoTurno;
SELECT * FROM sede.Sede;
SELECT * FROM sede.DiaSede;
SELECT * FROM turno.Reserva;

-- Procedimientos Almacenados para la tabla pte.Cobertura

CREATE OR ALTER PROCEDURE pte.InsertCobertura
    @ImagenCredencial VARBINARY(MAX),
    @NroSocio VARCHAR(50),
    @FechaRegistro DATE,
    @IdPrestador INT
AS
BEGIN
    INSERT INTO pte.Cobertura (ImagenCredencial, NroSocio, FechaRegistro, IdPrestador)
    VALUES (@ImagenCredencial, @NroSocio, @FechaRegistro, @IdPrestador);
END
GO


CREATE OR ALTER PROCEDURE pte.UpdateCobertura
    @ID INT,
    @ImagenCredencial VARBINARY(MAX),
    @NroSocio VARCHAR(50),
    @FechaRegistro DATE,
    @IdPrestador INT
AS
BEGIN
    UPDATE pte.Cobertura
    SET ImagenCredencial = @ImagenCredencial,
        NroSocio = @NroSocio,
        FechaRegistro = @FechaRegistro,
        IdPrestador = @IdPrestador
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE pte.DeleteCobertura
    @ID INT
AS
BEGIN
    DELETE FROM pte.Cobertura
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla pte.Prestador


CREATE OR ALTER PROCEDURE pte.InsertPrestador
    @Nombre VARCHAR(50),
    @PlanPrestador VARCHAR(50)
AS
BEGIN
    INSERT INTO pte.Prestador (Nombre, PlanPrestador)
    VALUES (@Nombre, @PlanPrestador);
END
GO


CREATE OR ALTER PROCEDURE pte.UpdatePrestador
    @ID INT,
    @Nombre VARCHAR(50),
    @PlanPrestador VARCHAR(50)
AS
BEGIN
    UPDATE pte.Prestador
    SET Nombre = @Nombre,
        PlanPrestador = @PlanPrestador
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE pte.DeletePrestador
    @ID INT
AS
BEGIN
    DELETE FROM pte.Prestador
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla pte.Domicilio


CREATE OR ALTER PROCEDURE pte.InsertDomicilio
    @Calle VARCHAR(100),
    @Numero VARCHAR(10),
    @Piso VARCHAR(10),
    @Departamento VARCHAR(10),
    @CodigoPostal VARCHAR(20),
    @Pais VARCHAR(50),
    @Provincia VARCHAR(50),
    @Localidad VARCHAR(50)
AS
BEGIN
    INSERT INTO pte.Domicilio (Calle, Numero, Piso, Departamento, CodigoPostal, Pais, Provincia, Localidad)
    VALUES (@Calle, @Numero, @Piso, @Departamento, @CodigoPostal, @Pais, @Provincia, @Localidad);
END
GO


CREATE OR ALTER PROCEDURE pte.UpdateDomicilio
    @ID INT,
    @Calle VARCHAR(100),
    @Numero VARCHAR(10),
    @Piso VARCHAR(10),
    @Departamento VARCHAR(10),
    @CodigoPostal VARCHAR(20),
    @Pais VARCHAR(50),
    @Provincia VARCHAR(50),
    @Localidad VARCHAR(50)
AS
BEGIN
    UPDATE pte.Domicilio
    SET Calle = @Calle,
        Numero = @Numero,
        Piso = @Piso,
        Departamento = @Departamento,
        CodigoPostal = @CodigoPostal,
        Pais = @Pais,
        Provincia = @Provincia,
        Localidad = @Localidad
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE pte.DeleteDomicilio
    @ID INT
AS
BEGIN
    DELETE FROM pte.Domicilio
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla pte.Usuario


CREATE OR ALTER PROCEDURE pte.InsertUsuario
    @Contraseña VARCHAR(50),
    @FechaCreacion DATE
AS
BEGIN
    INSERT INTO pte.Usuario (Contraseña, FechaCreacion)
    VALUES (@Contraseña, @FechaCreacion);
END
GO


CREATE OR ALTER PROCEDURE pte.UpdateUsuario
    @ID INT,
    @Contraseña VARCHAR(50),
    @FechaCreacion DATE
AS
BEGIN
    UPDATE pte.Usuario
    SET Contraseña = @Contraseña,
        FechaCreacion = @FechaCreacion
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE pte.DeleteUsuario
    @ID INT
AS
BEGIN
    DELETE FROM pte.Usuario
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla pte.Estudio

CREATE OR ALTER PROCEDURE pte.InsertEstudio
    @Fecha DATE,
    @NombreEstudio VARCHAR(100),
    @EstaAutorizado BIT,
    @DocumentoResultado VARCHAR(50),
    @ImagenResultado VARBINARY(MAX)
AS
BEGIN
    INSERT INTO pte.Estudio (Fecha, NombreEstudio, EstaAutorizado, DocumentoResultado, ImagenResultado)
    VALUES (@Fecha, @NombreEstudio, @EstaAutorizado, @DocumentoResultado, @ImagenResultado);
END
GO


CREATE OR ALTER PROCEDURE pte.UpdateEstudio
    @ID INT,
    @Fecha DATE,
    @NombreEstudio VARCHAR(100),
    @EstaAutorizado BIT,
    @DocumentoResultado VARCHAR(50),
    @ImagenResultado VARBINARY(MAX)
AS
BEGIN
    UPDATE pte.Estudio
    SET Fecha = @Fecha,
        NombreEstudio = @NombreEstudio,
        EstaAutorizado = @EstaAutorizado,
        DocumentoResultado = @DocumentoResultado,
        ImagenResultado = @ImagenResultado
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE pte.DeleteEstudio
    @ID INT
AS
BEGIN
    DELETE FROM pte.Estudio
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla pte.Paciente


CREATE OR ALTER PROCEDURE pte.InsertPaciente
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @ApellidoMaterno VARCHAR(50),
    @FechaNacimiento DATE,
    @TipoDoc VARCHAR(20),
    @NumeroDoc VARCHAR(20),
    @SexoBiologico VARCHAR(10),
    @Genero VARCHAR(20),
    @Nacionalidad VARCHAR(50),
    @FotoPerfil VARBINARY(MAX),
    @Mail VARCHAR(100),
    @TelFijo VARCHAR(20),
    @TelAlternativo VARCHAR(20),
    @TelLaboral VARCHAR(20),
    @FechaRegistro DATE,
    @FechaActualizacion DATE,
    @UsuarioActualizacion VARCHAR(50),
    @IdUsuario INT,
    @IdEstudio INT,
    @IdCobertura INT
AS
BEGIN
    INSERT INTO pte.Paciente (Nombre, Apellido, ApellidoMaterno, FechaNacimiento, TipoDoc, NumeroDoc, SexoBiologico, Genero, Nacionalidad, FotoPerfil, Mail, TelFijo, TelAlternativo, TelLaboral, FechaRegistro, FechaActualizacion, UsuarioActualizacion, IdUsuario, IdEstudio, IdCobertura)
    VALUES (@Nombre, @Apellido, @ApellidoMaterno, @FechaNacimiento, @TipoDoc, @NumeroDoc, @SexoBiologico, @Genero, @Nacionalidad, @FotoPerfil, @Mail, @TelFijo, @TelAlternativo, @TelLaboral, @FechaRegistro, @FechaActualizacion, @UsuarioActualizacion, @IdUsuario, @IdEstudio, @IdCobertura);
END
GO


CREATE OR ALTER PROCEDURE pte.UpdatePaciente
    @ID INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @ApellidoMaterno VARCHAR(50),
    @FechaNacimiento DATE,
    @TipoDoc VARCHAR(20),
    @NumeroDoc VARCHAR(20),
    @SexoBiologico VARCHAR(10),
    @Genero VARCHAR(20),
    @Nacionalidad VARCHAR(50),
    @FotoPerfil VARBINARY(MAX),
    @Mail VARCHAR(100),
    @TelFijo VARCHAR(20),
    @TelAlternativo VARCHAR(20),
    @TelLaboral VARCHAR(20),
    @FechaRegistro DATE,
    @FechaActualizacion DATE,
    @UsuarioActualizacion VARCHAR(50),
    @IdUsuario INT,
    @IdEstudio INT,
    @IdCobertura INT
AS
BEGIN
    UPDATE pte.Paciente
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        ApellidoMaterno = @ApellidoMaterno,
        FechaNacimiento = @FechaNacimiento,
        TipoDoc = @TipoDoc,
        NumeroDoc = @NumeroDoc,
        SexoBiologico = @SexoBiologico,
        Genero = @Genero,
        Nacionalidad = @Nacionalidad,
        FotoPerfil = @FotoPerfil,
        Mail = @Mail,
        TelFijo = @TelFijo,
        TelAlternativo = @TelAlternativo,
        TelLaboral = @TelLaboral,
        FechaRegistro = @FechaRegistro,
        FechaActualizacion = @FechaActualizacion,
        UsuarioActualizacion = @UsuarioActualizacion,
        IdUsuario = @IdUsuario,
        IdEstudio = @IdEstudio,
        IdCobertura = @IdCobertura
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE pte.DeletePaciente
    @ID INT
AS
BEGIN
    DELETE FROM pte.Paciente
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla med.Especialidad


CREATE OR ALTER PROCEDURE med.InsertEspecialidad
    @Nombre VARCHAR(50)
AS
BEGIN
    INSERT INTO med.Especialidad (Nombre)
    VALUES (@Nombre);
END
GO


CREATE OR ALTER PROCEDURE med.UpdateEspecialidad
    @ID INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    UPDATE med.Especialidad
    SET Nombre = @Nombre
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE med.DeleteEspecialidad
    @ID INT
AS
BEGIN
    DELETE FROM med.Especialidad
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla med.Medico


CREATE OR ALTER PROCEDURE med.InsertMedico
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @NroMatricula VARCHAR(20),
    @IdEspecialidad INT
AS
BEGIN
    INSERT INTO med.Medico (Nombre, Apellido, NroMatricula, IdEspecialidad)
    VALUES (@Nombre, @Apellido, @NroMatricula, @IdEspecialidad);
END
GO


CREATE OR ALTER PROCEDURE med.UpdateMedico
    @ID INT,
    @Nombre VARCHAR
(50),
    @Apellido VARCHAR(50),
    @NroMatricula VARCHAR(20),
    @IdEspecialidad INT
AS
BEGIN
    UPDATE med.Medico
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        NroMatricula = @NroMatricula,
        IdEspecialidad = @IdEspecialidad
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE med.DeleteMedico
    @ID INT
AS
BEGIN
    DELETE FROM med.Medico
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla turno.TipoTurno


CREATE OR ALTER PROCEDURE turno.InsertTipoTurno
    @Nombre VARCHAR(50)
AS
BEGIN
    INSERT INTO turno.TipoTurno (Nombre)
    VALUES (@Nombre);
END
GO

CREATE OR ALTER PROCEDURE turno.UpdateTipoTurno
    @ID INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    UPDATE turno.TipoTurno
    SET Nombre = @Nombre
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE turno.DeleteTipoTurno
    @ID INT
AS
BEGIN
    DELETE FROM turno.TipoTurno
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla turno.estadoTurno


CREATE OR ALTER PROCEDURE turno.InsertEstadoTurno
    @nombreEstado VARCHAR(50)
AS
BEGIN
    INSERT INTO turno.estadoTurno (nombreEstado)
    VALUES (@nombreEstado);
END
GO


CREATE OR ALTER PROCEDURE turno.UpdateEstadoTurno
    @ID INT,
    @nombreEstado VARCHAR(50)
AS
BEGIN
    UPDATE turno.estadoTurno
    SET nombreEstado = @nombreEstado
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE turno.DeleteEstadoTurno
    @ID INT
AS
BEGIN
    DELETE FROM turno.estadoTurno
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla sede.sede


CREATE OR ALTER PROCEDURE sede.InsertSede
    @nombre VARCHAR(50),
    @direccion VARCHAR(255)
AS
BEGIN
    INSERT INTO sede.sede (nombre, direccion)
    VALUES (@nombre, @direccion);
END
GO


CREATE OR ALTER PROCEDURE sede.UpdateSede
    @ID INT,
    @nombre VARCHAR(50),
    @direccion VARCHAR(255)
AS
BEGIN
    UPDATE sede.sede
    SET nombre = @nombre,
        direccion = @direccion
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE sede.DeleteSede
    @ID INT
AS
BEGIN
    DELETE FROM sede.sede
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla sede.diaSede


CREATE OR ALTER PROCEDURE sede.InsertDiaSede
    @dia DATE,
    @horaInicio TIME,
    @IdSede INT,
    @IdMedico INT
AS
BEGIN
    INSERT INTO sede.diaSede (dia, horaInicio, IdSede, IdMedico)
    VALUES (@dia, @horaInicio, @IdSede, @IdMedico);
END
GO


CREATE OR ALTER PROCEDURE sede.UpdateDiaSede
    @ID INT,
    @dia DATE,
    @horaInicio TIME,
    @IdSede INT,
    @IdMedico INT
AS
BEGIN
    UPDATE sede.diaSede
    SET dia = @dia,
        horaInicio = @horaInicio,
        IdSede = @IdSede,
        IdMedico = @IdMedico
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE sede.DeleteDiaSede
    @ID INT
AS
BEGIN
    DELETE FROM sede.diaSede
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla turno.Reserva


CREATE OR ALTER PROCEDURE turno.InsertReserva
    @fecha DATE,
    @hora TIME,
    @IdMedico INT,
    @IdEspecialidad INT,
    @IdSede INT,
    @IdEstadoTurno INT,
    @IdTipoTurno INT
AS
BEGIN
    INSERT INTO turno.Reserva (fecha, hora, IdMedico, IdEspecialidad, IdSede, IdEstadoTurno, IdTipoTurno)
    VALUES (@fecha, @hora, @IdMedico, @IdEspecialidad, @IdSede, @IdEstadoTurno, @IdTipoTurno);
END
GO


CREATE OR ALTER PROCEDURE turno.UpdateReserva
    @ID INT,
    @fecha DATE,
    @hora TIME,
    @IdMedico INT,
    @IdEspecialidad INT,
    @IdSede INT,
    @IdEstadoTurno INT,
    @IdTipoTurno INT
AS
BEGIN
    UPDATE turno.Reserva
    SET fecha = @fecha,
        hora = @hora,
        IdMedico = @IdMedico,
        IdEspecialidad = @IdEspecialidad,
        IdSede = @IdSede,
        IdEstadoTurno = @IdEstadoTurno,
        IdTipoTurno = @IdTipoTurno
    WHERE ID = @ID;
END
GO


CREATE OR ALTER PROCEDURE turno.DeleteReserva
    @ID INT
AS
BEGIN
    DELETE FROM turno.Reserva
    WHERE ID = @ID;
END
GO

--FUNCIONES
CREATE FUNCTION func.get_apellido_despues_de_punto(@str VARCHAR(255))
RETURNS VARCHAR(255) AS
BEGIN
    RETURN LTRIM(SUBSTRING(@str, CHARINDEX('.', @str) + 1, LEN(@str)))
END
GO



--CARGAR CSV DE MEDICOS
CREATE OR ALTER PROCEDURE med.ImportarMedicos 
    @PATH VARCHAR(MAX) 
AS
BEGIN
    SET NOCOUNT ON;

    -- Crear una tabla temporal para almacenar los datos del CSV
    CREATE TABLE #CSV_AUX (
        NOMBRE VARCHAR(50),
        APELLIDOS VARCHAR(50), -- Se manejan cruzadas ya que el CSV tiene las columnas invertidas
        ESPECIALIDAD VARCHAR(50),
        NRO_COLEG VARCHAR(50)
    );

    -- Definir la consulta dinámica para la importación del archivo CSV
    DECLARE @SQL VARCHAR(MAX) = 'BULK INSERT #CSV_AUX FROM ''' + @PATH + ''' WITH (FIELDTERMINATOR = '';'', ROWTERMINATOR = ''\n'', FIRSTROW = 2, CODEPAGE = ''65001'')';

    -- Ejecutar la consulta dinámica para importar los datos del archivo CSV
    BEGIN TRY
        EXEC (@SQL);
    END TRY
    BEGIN CATCH
        -- Manejar errores de importación
        PRINT 'Error: No se pudo importar el archivo CSV.';
        RETURN;
    END CATCH

    -- Insertar nuevas especialidades si no existen
    INSERT INTO med.Especialidad(NOMBRE)
    SELECT DISTINCT ESPECIALIDAD
    FROM #CSV_AUX AUX
    WHERE NOT EXISTS (SELECT 1 FROM med.Especialidad ES WHERE ES.NOMBRE = AUX.ESPECIALIDAD);

    -- Insertar médicos desde el archivo CSV
    INSERT INTO med.Medico(NOMBRE, APELLIDO, NroMatricula, IdEspecialidad)
    SELECT LTRIM(A.APELLIDOS), UPPER(LEFT(func.get_apellido_despues_de_punto(A.NOMBRE), 1)) + LOWER(SUBSTRING(func.get_apellido_despues_de_punto(A.NOMBRE), 2, LEN(func.get_apellido_despues_de_punto(A.NOMBRE)))), A.NRO_COLEG, E.ID
    FROM #CSV_AUX A 
    INNER JOIN med.Especialidad E ON A.ESPECIALIDAD = E.NOMBRE;
END
GO



exec med.ImportarMedicos 'E:\PruebaSQL\Medicos.csv' 
GO

-- Eliminar los datos de la tabla med.Medico
DELETE FROM med.Medico;

-- Eliminar los datos de la tabla med.Especialidad
DELETE FROM med.Especialidad;

select * from med.Medico ORDER BY Nombre
select * from med.Especialidad

