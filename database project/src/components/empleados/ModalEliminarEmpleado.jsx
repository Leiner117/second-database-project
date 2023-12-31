import React, {useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";




export default function App() {


  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [cedula, setCedula] = React.useState("");
  const [nombre, setNombre] = React.useState("");
  const [primerApellido, setPrimerApellido] = React.useState("");
  const [segundoApellido, setSegundoApellido] = React.useState("");
  const [fechaNacimiento, setFechaNacimiento] = React.useState("");
  const [value, setValue] = React.useState("");

  const handleSelectionChange = (e) => {
    setValue(e.target.value);
    setCedula(e.target.value);
    setNombre(e.target.nombre);

    for (let i = 0; i < empleados.length; i++) {
      if (empleados[i].cedula == e.target.value) {
        setNombre(empleados[i].nombre.trim());
        setPrimerApellido(empleados[i].apellido1.trim());
        setSegundoApellido(empleados[i].apellido2.trim());
        setFechaNacimiento(empleados[i].fechaNacimiento.trim());
      }
    }
  };

  const [empleados, setEmpleados] = useState([]);

  useEffect(() => {
    // Realiza la solicitud al servidor para obtener datos de la base de datos
    fetch("http://localhost:5000/empleados")
      .then((response) => response.json())
      .then((data) => setEmpleados(data.datos)); // Ajusta según la estructura de tu respuesta del servidor
  }, []);


  const eliminarEmpleado = async() => {
    try {
      const response = await fetch('http://localhost:5000/empleados', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              cedula,
            },
          ],
        }),
      });
  
      if (!response.ok) {
        throw new Error('Error al enviar datos al servidor');
      }
  
      const data = await response.json();
      console.log(data.mensaje); // Mensaje del servidor
  
      window.location.reload();
  
    } catch (error) {
      console.error('Error:', error);
      // Puedes manejar el error según tus necesidades, por ejemplo, mostrar un mensaje al usuario.
    }
  }


  return (
    <>
      <Button onPress={onOpen} color="danger">Eliminar Empleado</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Elimiar Empleado</ModalHeader>
              <ModalBody>

              <div className="flex w-full max-w-xs flex-col gap-2">
              <Select
                label="Empleado a eliminar"
                variant="bordered"
                selectedKeys={[value]}
                className="max-w-xs"
                onChange={handleSelectionChange}
              >
                {empleados.map((empleado) => (
                  <SelectItem key={empleado.cedula} value={empleado}>
                    {empleado.cedula + " " + empleado.nombre + " " + empleado.apellido1}
                  </SelectItem>
                ))}
              </Select>
              </div>

                <Input
                  label="Cedula"
                  placeholder="Seleccione un empleado"
                  variant="bordered"
                  value={cedula}
                  onValueChange={setCedula}
                  readOnly
                />
                <Input
                  label="Nombre"
                  placeholder="Seleccione un empleado"
                  variant="bordered"
                  value={nombre}
                  onValueChange={setNombre}
                  readOnly
                />
                <Input
                  label="Primer Apellido"
                  placeholder="Seleccione un empleado"
                  variant="bordered"
                  value={primerApellido}
                  onValueChange={setPrimerApellido}
                  readOnly
                />
                <Input
                  label="Segundo Apellido"
                  placeholder="Seleccione un empleado"
                  variant="bordered"
                  value={segundoApellido}
                  onValueChange={setSegundoApellido}
                  readOnly
                />
                <Input
                  label="Fecha Nacimiento"
                  placeholder="Seleccione un empleado"
                  variant="bordered"
                  value={fechaNacimiento}
                  onValueChange={setFechaNacimiento}
                  readOnly
                />
                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="danger" onPressStart={eliminarEmpleado} onPressEnd={onClose}>
                  Eliminar
                </Button>
              </ModalFooter>
            </>
          )}
        </ModalContent>
      </Modal>
    </>
  );
}
