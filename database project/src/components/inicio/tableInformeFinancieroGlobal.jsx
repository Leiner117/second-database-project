import React, { useEffect, useState } from "react";
import { Table, TableHeader, TableColumn, TableBody, TableRow, TableCell, getKeyValue } from "@nextui-org/react";



export default function TablaInforme() {
  const [informe, setInforme] = useState([]);

  useEffect(() => {
    // Realiza la solicitud al servidor para obtener datos de la base de datos
    fetch("http://localhost:5000/informeFinanciero")
      .then((response) => response.json())
      .then((data) => setInforme(data.datos)); // Ajusta según la estructura de tu respuesta del servidor
  }, []); // El segundo argumento [] asegura que el efecto se ejecute solo una vez, equivalente a componentDidMount en clases.

  const columns = [
    { key: "FechaInicio", label: "Fecha Inicio" },
    { key: "FechaFin", label: "Fecha Finalizacion" },
    { key: "ViajesTotales", label: "Viajes Totales" },
    { key: "GastosTotales", label: "Gastos Totales" },
    { key: "PagosTotales", label: "Pagos Totales" },
    { key: "GananciaTotal", label: "Ganancia Total" }
  ];


  return (
    <Table
      aria-label="Example table with dynamic content"
      selectionMode="single"
      color={"primary"}
    >
      <TableHeader columns={columns}>
        {(column) => <TableColumn key={column.key}>{column.label}</TableColumn>}
      </TableHeader>
      <TableBody items={informe}>
        {(item) => (
          <TableRow key={item.FechaInicio}>
            {(columnKey) => (
              <TableCell>{getKeyValue(item, columnKey)}</TableCell>
            )}
          </TableRow>
        )}
      </TableBody>
    </Table>
  );
}
