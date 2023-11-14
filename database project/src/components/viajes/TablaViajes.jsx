import React, { useEffect, useState } from "react";
import { Table, TableHeader, TableColumn, TableBody, TableRow, TableCell, getKeyValue } from "@nextui-org/react";



export default function TablaViajes() {
  const [viajes, setViajes] = useState([]);

  useEffect(() => {
    // Realiza la solicitud al servidor para obtener datos de la base de datos
    fetch("http://localhost:5000/viajes")
      .then((response) => response.json())
      .then((data) => setViajes(data.datos)); // Ajusta según la estructura de tu respuesta del servidor
  }, []); // El segundo argumento [] asegura que el efecto se ejecute solo una vez, equivalente a componentDidMount en clases.

  const columns = [
    { key: "cedulaConductor", label: "Cedula del conductor" },
    { key: "placa", label: "Placa" },
    { key: "nombreCliente", label: "Nombre del cliente" },
    { key: "fecha", label: "Fecha"},
    { key: "hora", label: "Hora" },
    { key: "cantidadPasajeros", label: "Cantidad de pasajeros" },
    { key: "lugarSalida", label: "Lugar de Salida" },
    { key: "lugarLlegada", label: "Lugar de Llegada" },
    { key: "descripcion", label: "Descripcion" },
    { key: "precio", label: "Precio" },
    { key: "estado", label: "Estado" },
  ];


  return (
    <Table
      aria-label="Example table with dynamic content"
      selectionMode="single"
      color={"success"}
    >
      <TableHeader columns={columns}>
        {(column) => <TableColumn key={column.key}>{column.label}</TableColumn>}
      </TableHeader>
      <TableBody items={viajes}>
        {(item) => (
          <TableRow key={item.idViaje}>
            {(columnKey) => (
              <TableCell>{getKeyValue(item, columnKey)}</TableCell>
            )}
          </TableRow>
        )}
      </TableBody>
    </Table>
  );
}
