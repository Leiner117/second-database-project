import React, {useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";

export default function App() {
  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [cedula, setCedula] = React.useState("");
  const [correo, setCorreo] = React.useState("");

  
    const [value, setValue] = React.useState("");


    const handleSelectionChange2 = (e) => {
        setValue(e.target.value);
        setCedula(e.target.value);
        console.log(e.target.value)
    };




    const [empleados, setEmpleados] = useState([]);
    const [correos, setCorreos] = useState([]);

    useEffect(() => {
        // Realiza la solicitud al servidor para obtener datos de la base de datos
        fetch("http://localhost:5000/empleados")
          .then((response) => response.json())
          .then((data) => {
            setEmpleados(data.datos); // Ajusta según la estructura de tu respuesta del servidor
          });
      },); 


  const agregarCorreoEmpleado = async() => {
    try {
      const response = await fetch('http://localhost:5000/correos_empleados', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              correo,
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
  };
  return (
    <>
      <Button onPress={onOpen} color="success"> Telefonos</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Telefonos</ModalHeader>
              <ModalBody>

                <div className="flex w-full max-w-xs flex-col gap-2">
                    <Select
                    label="Empleado"
                    variant="bordered"
                    selectedKeys={[value]}
                    className="max-w-xs"
                    onChange={handleSelectionChange2}
                    >
                    {empleados.map((empleado) => (
                        <SelectItem key={empleado.cedula} value={empleado}>
                        {empleado.cedula + " " + empleado.nombre + " " + empleado.apellido1}
                        </SelectItem>
                    ))}
                    </Select>

                    
                </div>
                

                <Input
                  label="Correo"
                  placeholder="Ej: correo@hotmail.com"
                  variant="bordered"
                  value={correo}
                  onValueChange={setCorreo}
                />
                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="success" onPress={agregarCorreoEmpleado} onPressEnd={onClose}>
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
