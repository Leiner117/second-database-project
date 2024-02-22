import React, { useEffect, useState } from "react";
import { Table, TableHeader, TableColumn, TableBody, TableRow, TableCell, getKeyValue } from "@nextui-org/react";



export default function TablaClientes() {
  const [clientes, setClientes] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      // Realiza la solicitud al servidor para obtener datos de la base de datos
      const response = await fetch("http://localhost:5000/clientes");
      const data = await response.json();
      setClientes(data.datos); // Ajusta según la estructura de tu respuesta del servidor
    };
  
    fetchData();
  }, []);

  const columns = [
    { key: "Nombre", label: "Nombre" },
    { key: "CantidadViajes", label: "Cantidad de viajes" }
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
      <TableBody items={clientes}>
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
