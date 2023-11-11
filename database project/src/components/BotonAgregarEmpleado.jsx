

import React from "react";
import {Button} from "@nextui-org/react";

export default function BotonAgregarEmpleado({ agregarEmpleado }) {
  const handleClick = () => {
    const nuevoEmpleado = {
      key: "2",
      cedula: "208420162",
      nombre: "Anthony",
      apellido1: "Jimenez",
      apellido2: "Zamora",
      fechaNacimiento: "01/06/2003",
    };
    agregarEmpleado(nuevoEmpleado);
  };
  
  return (
    <Button color="primary" variant="bordered" onClick={handleClick}>
      Agregar Empleado
    </Button>
  );
}