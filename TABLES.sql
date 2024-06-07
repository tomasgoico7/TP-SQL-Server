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