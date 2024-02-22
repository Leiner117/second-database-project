import React, { useEffect, useState } from "react";
import { Table, TableHeader, TableColumn, TableBody, TableRow, TableCell, getKeyValue } from "@nextui-org/react";



export default function TablaTransacciones() {
  const [transacciones, setTransacciones] = useState([]);

  useEffect(() => {
    // Realiza la solicitud al servidor para obtener datos de la base de datos
    fetch("http://localhost:5000/transacciones")
      .then((response) => response.json())
      .then((data) => setTransacciones(data.datos)); // Ajusta según la estructura de tu respuesta del servidor
  }, []); // El segundo argumento [] asegura que el efecto se ejecute solo una vez, equivalente a componentDidMount en clases.

  const columns = [
    { key: "idTransaccion", label: "IdTransacciones" },
    { key: "fecha", label: "Fecha" },
    { key: "monto", label: "Monto" },
    { key: "detalle", label: "Detalle" }
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
      <TableBody items={transacciones}>
        {(item) => (
          <TableRow key={item.idTransaccion}>
            {(columnKey) => (
              <TableCell>{getKeyValue(item, columnKey)}</TableCell>
            )}
          </TableRow>
        )}
      </TableBody>
    </Table>
  );
}
