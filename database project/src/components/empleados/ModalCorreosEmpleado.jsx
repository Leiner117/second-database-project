import React, {useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";

import axios from "axios";

export default function App() {
   const {isOpen, onOpen, onOpenChange} = useDisclosure();
   const [cedula, setCedula] = React.useState("");
   const [correoInput, setCorreoInput] = React.useState("");

    const [correo, setCorreo] = React.useState("");

  
    const [value, setValue] = React.useState("");


    const handleSelectionChange = (e) => {
        setValue(e.target.value);
        setCedula(e.target.value);
        setCorreoInput("");
    };

    const handleSelectionChange2 = (e) => {
      setValue(e.target.value);
      setCorreoInput(e.target.value);
    };



    const [empleados, setEmpleados] = useState([]);

    const [correos, setCorreos] = useState([]);

  useEffect(() => {
    // Realiza la solicitud al servidor para obtener datos de la base de datos
    axios.get("http://localhost:5000/empleados")
      .then((response) => setEmpleados(response.data));
      
    fetch("http://localhost:5000/correos_empleados")
      .then((response) => response.json())
      .then((data) => setCorreos(data.datos));
      // Ajusta según la estructura de tu respuesta del servidor
  }, []);


  const agregarCorreoEmpleado = async() => {
    try {
      const response = await fetch("http://localhost:5000/correos_empleados", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              correoInput,
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
  
      //window.location.reload();
  
    } catch (error) {
      console.error('Error:', error);
      // Puedes manejar el error según tus necesidades, por ejemplo, mostrar un mensaje al usuario.
    }
  };


  const eliminarCorreoEmpleado = async() => {
    try {
      const response = await fetch("http://localhost:5000/correos_empleados", {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              correoInput,
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
  
      //window.location.reload();
  
    } catch (error) {
      console.error('Error:', error);
      // Puedes manejar el error según tus necesidades, por ejemplo, mostrar un mensaje al usuario.
    }
  }

  return (
    <>
      <Button onPress={onOpen} color="success"> Correos</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
        size = "4xl"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Correos</ModalHeader>
              <ModalBody>

                <div className="flex w-full  flex-row gap-2">
                    <Select
                    label="Empleado"
                    variant="bordered"
                    selectedKeys={[value]}
                    className="max-w-xs"
                    onChange={handleSelectionChange}
                    >
                    {empleados.map((empleado) => (
                        <SelectItem key={empleado.cedula} value={empleado}>
                        {empleado.cedula+ " "+empleado.nombre+" "+empleado.apellido1+" "+empleado.apellido2}
                        </SelectItem>
                    ))}
                    </Select>

                    <Select
                    label="Correos"
                    variant="bordered"
                    selectedKeys={[value]}
                    size = "lg"
                    className="max-w-xs"
                    onChange={handleSelectionChange2}
                    >
                    {correos.map((correo) => (
                        <SelectItem key={correo.correo} value={correo}>
                        {correo.correo + " "}
                        </SelectItem>
                    ))}
                    </Select>
                </div>
                <Input
                  label="Correo"
                  placeholder="Ej: correo@hotmail.com"
                  variant="bordered"
                  value={correoInput}
                  onValueChange={setCorreoInput}
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
                <Button color="error" onPress={eliminarCorreoEmpleado} onPressEnd={onClose}>
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
