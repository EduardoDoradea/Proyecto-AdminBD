
/*INSERCION DE DATOS A LA BASE POR MEDIO DE SQL_DATA_GENERATOR*/

--INSERCION DE DATOS DE INSTRUMENTOMEDICO 450 datos
BULK INSERT Inventario.InstrumentoMedico
FROM 'C:\bulkData\InstrumentoMedico.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Inventario.InstrumentoMedico

--INSERCION DE DATOS DE ANALGESICO 500 datos
BULK INSERT Inventario.Analgesico
FROM 'C:\bulkData\Analgesico.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Inventario.Analgesico;

--INSERCION DE DATOS DE MEDICAMENTO 500 datos
BULK INSERT Inventario.Medicamento
FROM 'C:\bulkData\Medicamento.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Inventario.Medicamento;

--INSERCION DE DATOS DE BODEGA 600 datos
BULK INSERT Inventario.Bodega
FROM 'C:\bulkData\Bodega.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Inventario.Bodega;

--INSERCION DE DATOS DE MEDICO 200 datos
BULK INSERT Clinica.Medico
FROM 'C:\bulkData\Medico.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Clinica.Medico;

-- INSERCION DE DATOS PACIENTE 850 datos
BULK INSERT Clinica.Paciente
FROM 'C:\bulkData\Paciente.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Clinica.Paciente;

--INSERCION DE DATOS DE CITA 1000 datos
BULK INSERT Clinica.Cita 
FROM 'C:\bulkData\Cita.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT COUNT(*) AS Citas FROM Clinica.Cita;

-- INSERCION DE DATOS DE TRATAMIENTO 300 datos
BULK INSERT Clinica.Tratamiento
FROM 'C:\bulkData\Tratamiento.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Clinica.Tratamiento;

-- INSERCION DE DATOS DE METODOPAGO 500 datos
BULK INSERT Contabilidad.MetodoPago
FROM 'C:\bulkData\MetodoPago.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Contabilidad.MetodoPago;

-- INSERCION DE DATOS DE FACTURA
BULK INSERT Contabilidad.Factura
FROM 'C:\bulkData\Factura.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Contabilidad.Factura;

--INSERCION DE DATOS DE DEPARTAMENTO 200 datos (INSERTE DOS VECES)
BULK INSERT Administracion.Departamento
FROM 'C:\bulkData\Departamento.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Administracion.Departamento;

-- INSERCION DE DATOS DE DEPAXMED 200 datos
BULK INSERT Clinica.DepaXMed
FROM 'C:\bulkData\DepaXMed.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	CODEPAGE = '65001'
);

SELECT * FROM Clinica.DepaXMed;
