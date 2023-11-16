import React, { useEffect, useState } from "react";
import { Table, TableHeader, TableColumn, TableBody, TableRow, TableCell, getKeyValue } from "@nextui-org/react";



export default function TablaClientes() {
  const [mantenimientos, setMantenimientos] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      // Realiza la solicitud al servidor para obtener datos de la base de datos
      const response = await fetch("http://localhost:5000/mantenimientos");
      const data = await response.json();
      setMantenimientos(data.datos); // Ajusta según la estructura de tu respuesta del servidor
    };
    fetchData();
  }, []);

  const columns = [
    { key: "costo", label: "Costo" },
    { key: "descripcion", label: "Descripcion" },
    { key: "fecha", label: "Fecha"},
    { key: "placa", label: "Placa" },
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
      <TableBody items={mantenimientos}>
        {(item) => (
          <TableRow key={item.Nombre}>
            {(columnKey) => (
              <TableCell>{getKeyValue(item, columnKey)}</TableCell>
            )}
          </TableRow>
        )}
      </TableBody>
    </Table>
  );
}
