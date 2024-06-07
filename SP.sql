-- Procedimientos Almacenados para la tabla pte.Cobertura

IF OBJECT_ID('InsertCobertura', 'P') IS NOT NULL DROP PROCEDURE InsertCobertura;
GO
CREATE PROCEDURE InsertCobertura
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

IF OBJECT_ID('UpdateCobertura', 'P') IS NOT NULL DROP PROCEDURE UpdateCobertura;
GO
CREATE PROCEDURE UpdateCobertura
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

IF OBJECT_ID('DeleteCobertura', 'P') IS NOT NULL DROP PROCEDURE DeleteCobertura;
GO
CREATE PROCEDURE DeleteCobertura
    @ID INT
AS
BEGIN
    DELETE FROM pte.Cobertura
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla pte.Prestador

IF OBJECT_ID('InsertPrestador', 'P') IS NOT NULL DROP PROCEDURE InsertPrestador;
GO
CREATE PROCEDURE InsertPrestador
    @Nombre VARCHAR(50),
    @PlanPrestador VARCHAR(50)
AS
BEGIN
    INSERT INTO pte.Prestador (Nombre, PlanPrestador)
    VALUES (@Nombre, @PlanPrestador);
END
GO

IF OBJECT_ID('UpdatePrestador', 'P') IS NOT NULL DROP PROCEDURE UpdatePrestador;
GO
CREATE PROCEDURE UpdatePrestador
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

IF OBJECT_ID('DeletePrestador', 'P') IS NOT NULL DROP PROCEDURE DeletePrestador;
GO
CREATE PROCEDURE DeletePrestador
    @ID INT
AS
BEGIN
    DELETE FROM pte.Prestador
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla pte.Domicilio

IF OBJECT_ID('InsertDomicilio', 'P') IS NOT NULL DROP PROCEDURE InsertDomicilio;
GO
CREATE PROCEDURE InsertDomicilio
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

IF OBJECT_ID('UpdateDomicilio', 'P') IS NOT NULL DROP PROCEDURE UpdateDomicilio;
GO
CREATE PROCEDURE UpdateDomicilio
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

IF OBJECT_ID('DeleteDomicilio', 'P') IS NOT NULL DROP PROCEDURE DeleteDomicilio;
GO
CREATE PROCEDURE DeleteDomicilio
    @ID INT
AS
BEGIN
    DELETE FROM pte.Domicilio
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla pte.Usuario

IF OBJECT_ID('InsertUsuario', 'P') IS NOT NULL DROP PROCEDURE InsertUsuario;
GO
CREATE PROCEDURE InsertUsuario
    @Contraseña VARCHAR(50),
    @FechaCreacion DATE
AS
BEGIN
    INSERT INTO pte.Usuario (Contraseña, FechaCreacion)
    VALUES (@Contraseña, @FechaCreacion);
END
GO

IF OBJECT_ID('UpdateUsuario', 'P') IS NOT NULL DROP PROCEDURE UpdateUsuario;
GO
CREATE PROCEDURE UpdateUsuario
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

IF OBJECT_ID('DeleteUsuario', 'P') IS NOT NULL DROP PROCEDURE DeleteUsuario;
GO
CREATE PROCEDURE DeleteUsuario
    @ID INT
AS
BEGIN
    DELETE FROM pte.Usuario
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla pte.Estudio

IF OBJECT_ID('InsertEstudio', 'P') IS NOT NULL
DROP PROCEDURE InsertEstudio;
GO
CREATE PROCEDURE InsertEstudio
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

IF OBJECT_ID('UpdateEstudio', 'P') IS NOT NULL DROP PROCEDURE UpdateEstudio;
GO
CREATE PROCEDURE UpdateEstudio
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

IF OBJECT_ID('DeleteEstudio', 'P') IS NOT NULL DROP PROCEDURE DeleteEstudio;
GO
CREATE PROCEDURE DeleteEstudio
    @ID INT
AS
BEGIN
    DELETE FROM pte.Estudio
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla pte.Paciente

IF OBJECT_ID('InsertPaciente', 'P') IS NOT NULL DROP PROCEDURE InsertPaciente;
GO
CREATE PROCEDURE InsertPaciente
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

IF OBJECT_ID('UpdatePaciente', 'P') IS NOT NULL DROP PROCEDURE UpdatePaciente;
GO
CREATE PROCEDURE UpdatePaciente
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

IF OBJECT_ID('DeletePaciente', 'P') IS NOT NULL DROP PROCEDURE DeletePaciente;
GO
CREATE PROCEDURE DeletePaciente
    @ID INT
AS
BEGIN
    DELETE FROM pte.Paciente
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla med.Especialidad

IF OBJECT_ID('InsertEspecialidad', 'P') IS NOT NULL DROP PROCEDURE InsertEspecialidad;
GO
CREATE PROCEDURE InsertEspecialidad
    @Nombre VARCHAR(50)
AS
BEGIN
    INSERT INTO med.Especialidad (Nombre)
    VALUES (@Nombre);
END
GO

IF OBJECT_ID('UpdateEspecialidad', 'P') IS NOT NULL DROP PROCEDURE UpdateEspecialidad;
GO
CREATE PROCEDURE UpdateEspecialidad
    @ID INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    UPDATE med.Especialidad
    SET Nombre = @Nombre
    WHERE ID = @ID;
END
GO

IF OBJECT_ID('DeleteEspecialidad', 'P') IS NOT NULL DROP PROCEDURE DeleteEspecialidad;
GO
CREATE PROCEDURE DeleteEspecialidad
    @ID INT
AS
BEGIN
    DELETE FROM med.Especialidad
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla med.Medico

IF OBJECT_ID('InsertMedico', 'P') IS NOT NULL DROP PROCEDURE InsertMedico;
GO
CREATE PROCEDURE InsertMedico
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

IF OBJECT_ID('UpdateMedico', 'P') IS NOT NULL DROP PROCEDURE UpdateMedico;
GO
CREATE PROCEDURE UpdateMedico
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

IF OBJECT_ID('DeleteMedico', 'P') IS NOT NULL DROP PROCEDURE DeleteMedico;
GO
CREATE PROCEDURE DeleteMedico
    @ID INT
AS
BEGIN
    DELETE FROM med.Medico
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla turno.TipoTurno

IF OBJECT_ID('InsertTipoTurno', 'P') IS NOT NULL DROP PROCEDURE InsertTipoTurno;
GO
CREATE PROCEDURE InsertTipoTurno
    @Nombre VARCHAR(50)
AS
BEGIN
    INSERT INTO turno.TipoTurno (Nombre)
    VALUES (@Nombre);
END
GO

IF OBJECT_ID('UpdateTipoTurno', 'P') IS NOT NULL DROP PROCEDURE UpdateTipoTurno;
GO
CREATE PROCEDURE UpdateTipoTurno
    @ID INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    UPDATE turno.TipoTurno
    SET Nombre = @Nombre
    WHERE ID = @ID;
END
GO

IF OBJECT_ID('DeleteTipoTurno', 'P') IS NOT NULL DROP PROCEDURE DeleteTipoTurno;
GO
CREATE PROCEDURE DeleteTipoTurno
    @ID INT
AS
BEGIN
    DELETE FROM turno.TipoTurno
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla turno.estadoTurno

IF OBJECT_ID('InsertEstadoTurno', 'P') IS NOT NULL DROP PROCEDURE InsertEstadoTurno;
GO
CREATE PROCEDURE InsertEstadoTurno
    @nombreEstado VARCHAR(50)
AS
BEGIN
    INSERT INTO turno.estadoTurno (nombreEstado)
    VALUES (@nombreEstado);
END
GO

IF OBJECT_ID('UpdateEstadoTurno', 'P') IS NOT NULL DROP PROCEDURE UpdateEstadoTurno;
GO
CREATE PROCEDURE UpdateEstadoTurno
    @ID INT,
    @nombreEstado VARCHAR(50)
AS
BEGIN
    UPDATE turno.estadoTurno
    SET nombreEstado = @nombreEstado
    WHERE ID = @ID;
END
GO

IF OBJECT_ID('DeleteEstadoTurno', 'P') IS NOT NULL DROP PROCEDURE DeleteEstadoTurno;
GO
CREATE PROCEDURE DeleteEstadoTurno
    @ID INT
AS
BEGIN
    DELETE FROM turno.estadoTurno
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla sede.sede

IF OBJECT_ID('InsertSede', 'P') IS NOT NULL DROP PROCEDURE InsertSede;
GO
CREATE PROCEDURE InsertSede
    @nombre VARCHAR(50),
    @direccion VARCHAR(255)
AS
BEGIN
    INSERT INTO sede.sede (nombre, direccion)
    VALUES (@nombre, @direccion);
END
GO

IF OBJECT_ID('UpdateSede', 'P') IS NOT NULL DROP PROCEDURE UpdateSede;
GO
CREATE PROCEDURE UpdateSede
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

IF OBJECT_ID('DeleteSede', 'P') IS NOT NULL DROP PROCEDURE DeleteSede;
GO
CREATE PROCEDURE DeleteSede
    @ID INT
AS
BEGIN
    DELETE FROM sede.sede
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla sede.diaSede

IF OBJECT_ID('InsertDiaSede', 'P') IS NOT NULL DROP PROCEDURE InsertDiaSede;
GO
CREATE PROCEDURE InsertDiaSede
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

IF OBJECT_ID('UpdateDiaSede', 'P') IS NOT NULL DROP PROCEDURE UpdateDiaSede;
GO
CREATE PROCEDURE UpdateDiaSede
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

IF OBJECT_ID('DeleteDiaSede', 'P') IS NOT NULL DROP PROCEDURE DeleteDiaSede;
GO
CREATE PROCEDURE DeleteDiaSede
    @ID INT
AS
BEGIN
    DELETE FROM sede.diaSede
    WHERE ID = @ID;
END
GO

-- Procedimientos Almacenados para la tabla turno.Reserva

IF OBJECT_ID('InsertReserva', 'P') IS NOT NULL DROP PROCEDURE InsertReserva;
GO
CREATE PROCEDURE InsertReserva
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

IF OBJECT_ID('UpdateReserva', 'P') IS NOT NULL DROP PROCEDURE UpdateReserva;
GO
CREATE PROCEDURE UpdateReserva
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

IF OBJECT_ID('DeleteReserva', 'P') IS NOT NULL DROP PROCEDURE DeleteReserva;
GO
CREATE PROCEDURE DeleteReserva
    @ID INT
AS
BEGIN
    DELETE FROM turno.Reserva
    WHERE ID = @ID;
END
GO