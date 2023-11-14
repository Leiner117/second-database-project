import React, { useEffect, useState } from "react";
import { Table, TableHeader, TableColumn, TableBody, TableRow, TableCell, getKeyValue } from "@nextui-org/react";



export default function TablaVehiculos() {
  const [vehiculos, setVehiculos] = useState([]);

  useEffect(() => {
    // Realiza la solicitud al servidor para obtener datos de la base de datos
    fetch("http://localhost:5000/vehiculos")
      .then((response) => response.json())
      .then((data) => setVehiculos(data.datos)); // Ajusta según la estructura de tu respuesta del servidor
  }, []); // El segundo argumento [] asegura que el efecto se ejecute solo una vez, equivalente a componentDidMount en clases.

  const columns = [
    { key: "placa", label: "Placa" },
    { key: "capacidad", label: "Capacidad" },
    { key: "modelo", label: "Modelo" },
    { key: "marca", label: "Marca" },
    { key: "annio", label: "Año" },
    { key: "cantidadViajes", label: "Cantidad de viajes" },
  ];


  return (
    <Table
      aria-label="Example table with dynamic content"
      selectionMode="single"
      color={"secondary"}
    >
      <TableHeader columns={columns}>
        {(column) => <TableColumn key={column.key}>{column.label}</TableColumn>}
      </TableHeader>
      <TableBody items={vehiculos}>
        {(item) => (
          <TableRow key={item.placa}>
            {(columnKey) => (
              <TableCell>{getKeyValue(item, columnKey)}</TableCell>
            )}
          </TableRow>
        )}
      </TableBody>
    </Table>
  );
}
