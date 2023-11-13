import React from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";


export default function App() {
  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [cedula, setCedula] = React.useState("");
  const [nombre, setNombre] = React.useState("");
  const [primerApellido, setPrimerApellido] = React.useState("");
  const [segundoApellido, setSegundoApellido] = React.useState("");
  const [fechaNacimiento, setFechaNacimiento] = React.useState("");

  const agregarEmpleado = async() => {
    try {
      const response = await fetch('http://localhost:5000/empleados', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              cedula,
              nombre,
              apellido1: primerApellido,
              apellido2: segundoApellido,
              fechaNacimiento,
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
  };
  return (
    <>
      <Button onPress={onOpen} color="primary">Agregar Empleado</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Agregar Empleado</ModalHeader>
              <ModalBody>
                <Input
                  label="Cedula"
                  placeholder="Ej: 208420162 o 2-0842-0162"
                  variant="bordered"
                  value={cedula}
                  onValueChange={setCedula}
                />
                <Input
                  label="Nombre"
                  placeholder="Ej: Anthony"
                  variant="bordered"
                  value={nombre}
                  onValueChange={setNombre}
                />
                <Input
                  label="Primer Apellido"
                  placeholder="Ej: Jimenez"
                  variant="bordered"
                  value={primerApellido}
                  onValueChange={setPrimerApellido}
                />
                <Input
                  label="Segundo Apellido"
                  placeholder="Ej: Zamora"
                  variant="bordered"
                  value={segundoApellido}
                  onValueChange={setSegundoApellido}
                />
                <Input
                  label="Fecha Nacimiento"
                  placeholder="Ej: 2003-06-01"
                  variant="bordered"
                  value={fechaNacimiento}
                  onValueChange={setFechaNacimiento}
                />
                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="primary" onPress={agregarEmpleado} onPressEnd={onClose}>
                  Agregar
                </Button>
              </ModalFooter>
            </>
          )}
        </ModalContent>
      </Modal>
    </>
  );
}
