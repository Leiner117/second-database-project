import React from "react";
import {Table,Pagination, TableHeader, TableColumn, TableBody, TableRow, TableCell, getKeyValue} from "@nextui-org/react";

const rows = [
  {
    key: "1",
    cedula: "208420162",
    nombre: "Anthony",
    apellido1: "Jimenez",
    apellido2: "Zamora",
    fechaNacimiento: "01/06/2003",
  },
];

const columns = [
  {
    key: "cedula",
    label: "CEDULA",
  },
  {
    key: "nombre",
    label: "NOMBRE",
  },
  {
    key: "apellido1",
    label: "APELLIDO1",
  },
  {
    key: "apellido2",
    label: "APELLIDO2",
  },
  {
    key: "fechaNacimiento",
    label: "FECHA NACIMIENTO",
  },
];

export default function TablaEmpleados() {
  return (
    <Table 
    aria-label="Example table with dynamic content"
    selectionMode="single"
    color= {"primary"}
    >
      <TableHeader columns={columns}>
        {(column) => <TableColumn key={column.key}>{column.label}</TableColumn>}
      </TableHeader>
      <TableBody items={rows}>
        {(item) => (
          <TableRow key={item.key}>
            {(columnKey) => <TableCell>{getKeyValue(item, columnKey)}</TableCell>}
          </TableRow>
        )}
      </TableBody>
    </Table>
  );
}
