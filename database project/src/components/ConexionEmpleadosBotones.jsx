
import React, { useState } from "react";
import BotonAgregarEmpleado from "./BotonAgregarEmpleado";
import TablaEmpleados from "./TablaEmpleados";

export default function ComponentePadre() {
  const [empleados, setEmpleados] = useState([]);

  const agregarEmpleado = (nuevoEmpleado) => {
    setEmpleados([...empleados, nuevoEmpleado]);
  };

  return (
    <div>
      <BotonAgregarEmpleado agregarEmpleado={agregarEmpleado} />
      <TablaEmpleados empleados={empleados} />
    </div>
  );
}