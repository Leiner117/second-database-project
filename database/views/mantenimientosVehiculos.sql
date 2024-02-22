-- Crear una vista para el informe de mantenimientos realizados por cada vehículo

CREATE VIEW VistaMantenimientosPorVehiculo AS
SELECT
    Placa,
    COUNT(IdMantenimiento) AS CantidadMantenimientos
FROM
    mantenimientoReparaciones
GROUP BY
    Placa;