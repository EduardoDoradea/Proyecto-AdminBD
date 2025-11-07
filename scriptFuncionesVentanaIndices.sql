
/*CREACION DE FUNCIONES VENTANA E INDICES EN EL MISMO SCRIPT*/
--Activando los tiempos de ejecucion 
SET STATISTICS TIME ON 
SET STATISTICS IO ON

--REALIZADA
-- pacientes con mas servicios han solicitado
SELECT pa.nombre, pa.apellido, ci.especialidad,
COUNT(ci.idCita) citasRealizadas,
DENSE_RANK() OVER(PARTITION BY ci.especialidad ORDER BY COUNT(ci.idCita)DESC) rankingPacienteServicios
FROM Clinica.Paciente AS pa
JOIN Clinica.Cita AS ci ON pa.idPaciente = ci.idPaciente
GROUP BY pa.nombre, pa.apellido, ci.especialidad

--REALIZADA
-- medicos que mas servicios han brindado
SELECT med.nombre, 
COUNT(ci.idCita) tratamientosMedico,
DENSE_RANK() OVER(ORDER BY COUNT(ci.idCita)DESC) rankingMedicoServicios
FROM Clinica.Cita AS ci1
JOIN Clinica.Medico AS med ON ci.idMedico = med.idMedico
GROUP BY med.nombre

-- cuales son los analgesicos mas solicitados
SELECT an.tipo, 
COUNT(tr.idTratamiento) tipoAnalgesicoSolicitado,
ROW_NUMBER() OVER(ORDER BY COUNT(tr.idTratamiento)DESC) ranking
FROM Clinica.Tratamiento AS tr
JOIN Inventario.Medicamento AS medi ON tr.idMedicamento = medi.idMedicamento
JOIN Inventario.Analgesico as an ON medi.idAnalgesico = an.idAnalgesico
GROUP BY an.tipo

SELECT medi.nombre, ci.motivo, 
COUNT(tr.idTratamiento),
DENSE_RANK() OVER(PARTITION BY ci.especialidad ORDER BY COUNT(tr.idTratamiento)DESC) ranking
FROM Clinica.Tratamiento AS tr
JOIN Inventario.Medicamento AS medi ON tr.idMedicamento = medi.idMedicamento
JOIN Clinica.Cita AS ci ON tr.idCita = ci.idCita
GROUP BY medi.nombre, ci.motivo, ci.especialidad

--REALIZADA
-- cual es el metodo de pago mas usado para pagar en cada especialidad
SELECT ci.especialidad, mp.tipo, 
COUNT(fac.idFactura) AS tiposDePago,
DENSE_RANK() OVER(PARTITION BY ci.especialidad ORDER BY COUNT(fac.idFactura) DESC) AS ranking 
FROM Contabilidad.Factura AS fac
JOIN Contabilidad.MetodoPago AS mp ON fac.idMetodoPago = mp.idMetodoPago
JOIN Clinica.Cita AS ci ON fac.idCita = ci.idCita
GROUP BY ci.especialidad, mp.tipo

