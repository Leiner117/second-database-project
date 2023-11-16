import React, {useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";



export default function App() {
    const {isOpen, onOpen, onOpenChange} = useDisclosure();
    const [nombre, setNombre] = React.useState("");
    const [correoInput, setCorreoInput] = React.useState("");
    const [value, setValue] = React.useState("");

    

    const handleSelectionChange = (e) => {
        setValue(e.target.value);
        setNombre(e.target.value);
        setCorreoInput("");
    };

    const handleSelectionChange2 = (e) => {
      setValue(e.target.value);
      setCorreoInput(e.target.value);

      for (let i = 0; i < correos.length; i++) {
        if (correos[i].correo == e.target.value) {
          setNombre(correos[i].nombre);
        }
      }
    };



    const [clientes, setClientes] = useState([]);

    const [correos, setCorreos] = useState([]);

    useEffect(() => {
      const fetchData = async () => {
        // Realiza la solicitud al servidor para obtener datos de los clientes
        const responseClientes = await fetch("http://localhost:5000/clientes");
        const dataClientes = await responseClientes.json();
        setClientes(dataClientes.datos);
    
        // Realiza la solicitud al servidor para obtener datos de los correos de los clientes
        const responseCorreos = await fetch("http://localhost:5000/correos_clientes");
        const dataCorreos = await responseCorreos.json();
        setCorreos(dataCorreos.datos);
      };
    
      fetchData();
    }, []);


  const agregarCorreoCliente = async() => {
    try {
      const response = await fetch("http://localhost:5000/correos_clientes", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              correoInput,
              nombre,
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


  const eliminarCorreoCliente = async() => {
    try {
      const response = await fetch("http://localhost:5000/correos_clientes", {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              correoInput,
              nombre,
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
                    label="Cliente"
                    variant="bordered"
                    selectedKeys={[value]}
                    className="max-w-xs"
                    onChange={handleSelectionChange}
                    >
                    {clientes.map((cliente) => (
                        <SelectItem key={cliente.Nombre} value={cliente}>
                        {cliente.Nombre + " "}
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
                <Button color="success" onPress={agregarCorreoCliente} onPressEnd={onClose}>
                  Agregar
                </Button>
                <Button color="danger" onPress={eliminarCorreoCliente} onPressEnd={onClose}>
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
