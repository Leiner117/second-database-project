import React, { useEffect, useState } from "react";
import { Table, TableHeader, TableColumn, TableBody, TableRow, TableCell, getKeyValue } from "@nextui-org/react";



export default function TablaEmpleados() {
  const [empleados, setEmpleados] = useState([]);

  useEffect(() => {
    // Realiza la solicitud al servidor para obtener datos de la base de datos
    fetch("http://localhost:5000/empleados")
      .then((response) => response.json())
      .then((data) => setEmpleados(data.datos)); // Ajusta según la estructura de tu respuesta del servidor
  }, []); // El segundo argumento [] asegura que el efecto se ejecute solo una vez, equivalente a componentDidMount en clases.

  const columns = [
    { key: "cedula", label: "Cedula" },
    { key: "nombre", label: "Nombre" },
    { key: "apellido1", label: "Primer apellido" },
    { key: "apellido2", label: "Segundo apellido" },
    { key: "fechaNacimiento", label: "Fecha de nacimiento" },
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
      <TableBody items={empleados}>
        {(item) => (
          <TableRow key={item.cedula}>
            {(columnKey) => (
              <TableCell>{getKeyValue(item, columnKey)}</TableCell>
            )}
          </TableRow>
        )}
      </TableBody>
    </Table>
  );
}
