
--                    DESARROLLO DE LA BASE DE DATOS

/*
INTEGRANTES:
BIANCA NATALIA LUNA PE�ATE
DAVID ENRIQUE GALDAMEZ MENJIVAR
EDUARDO JOSE MELENDEZ DORADEA
ANA BELEN RAMIREZ FLORES
*/

--CREACION DE BASE DE DATOS
CREATE DATABASE DB_Hospital;

USE DB_Hospital;

-- CREACION DE TABLAS DE LA BASE 
CREATE TABLE InstrumentoMedico(
idInstrumento BIGINT IDENTITY PRIMARY KEY,
categoria NVARCHAR(255),
nombre NVARCHAR(255)
);

CREATE TABLE Analgesico(
idAnalgesico BIGINT IDENTITY PRIMARY KEY,
tipo NVARCHAR(255)
);

CREATE TABLE Medicamento(
idMedicamento BIGINT IDENTITY PRIMARY KEY,
nombre NVARCHAR(255),
fechaVencimiento DATE,
idAnalgesico BIGINT,
FOREIGN KEY (idAnalgesico) REFERENCES Analgesico(idAnalgesico)
);

CREATE TABLE Bodega(
idMaterial BIGINT IDENTITY PRIMARY KEY,
tipo VARCHAR(255),
ubicacion NVARCHAR(255),
idMedicamento BIGINT,
idInstrumento BIGINT,
cantidad INT,
FOREIGN KEY (idMedicamento) REFERENCES Medicamento(idMedicamento),
FOREIGN KEY (idInstrumento) REFERENCES InstrumentoMedico(idInstrumento)
);

CREATE TABLE MetodoPago(
idMetodoPago BIGINT IDENTITY PRIMARY KEY,
tipo NVARCHAR(255)
);

CREATE TABLE Medico(
idMedico BIGINT IDENTITY PRIMARY KEY,
nombre NVARCHAR(255),
apellido NVARCHAR(255)
);

CREATE TABLE Paciente(
idPaciente BIGINT IDENTITY PRIMARY KEY,
nombre NVARCHAR(255),
apellido NVARCHAR(255),
dui INT,
telefono INT
);

CREATE TABLE Cita(
idCita BIGINT IDENTITY PRIMARY KEY,
motivo NVARCHAR(MAX),
estado VARCHAR(255),
fecha DATE,
especialidad NVARCHAR(255),
duracion INT,
idMedico BIGINT,
idPaciente BIGINT,
FOREIGN KEY (idMedico) REFERENCES Medico(idMedico),
FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente)
);

CREATE TABLE Tratamiento(
idTratamiento BIGINT IDENTITY PRIMARY KEY,
dosis INT,
duracion NVARCHAR(255),
idCita BIGINT,
idMedicamento BIGINT,
FOREIGN KEY (idMedicamento) REFERENCES Medicamento(idMedicamento),
FOREIGN KEY (idCita) REFERENCES Cita(idCita)
);

CREATE TABLE Factura(
idFactura BIGINT IDENTITY PRIMARY KEY,
monto DECIMAL(8,2),
metodoPago NVARCHAR(255),
descripcion NVARCHAR(MAX),
fechaPago DATE,
estado VARCHAR(255),
idMetodoPago BIGINT,
idCita BIGINT,
FOREIGN KEY (idMetodoPago) REFERENCES MetodoPago(idMetodoPago),
FOREIGN KEY (idCita) REFERENCES Cita(idCita)
);

CREATE TABLE Departamento(
idDepartamento BIGINT IDENTITY PRIMARY KEY,
area NVARCHAR(255),
gerente NVARCHAR(255),
cantidadMedico INT
);

CREATE TABLE DepaXMed(
idDepaMed BIGINT IDENTITY PRIMARY KEY,
idMedico BIGINT,
idDepartamento BIGINT,
FOREIGN KEY (idMedico) REFERENCES Medico(idMedico),
FOREIGN KEY (idDepartamento) REFERENCES Departamento(idDepartamento)
);
