import React, {useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";



export default function App() {
    const {isOpen, onOpen, onOpenChange} = useDisclosure();
    const [nombre, setNombre] = React.useState("");
    const [telefonoInput, setTelefonoInput] = React.useState("");
    const [value, setValue] = React.useState("");


    const handleSelectionChange = (e) => {
        setValue(e.target.value);
        setNombre(e.target.value);
        setTelefonoInput("");
    };

    const handleSelectionChange2 = (e) => {
      setValue(e.target.value);
      setTelefonoInput(e.target.value);

      for (let i = 0; i < telefonos.length; i++) {
        if (telefonos[i].telefono == e.target.value) {
          setNombre(telefonos[i].nombre);
        }
      }
    };



    const [clientes, setClientes] = useState([]);

    const [telefonos, setTelefonos] = useState([]);

    useEffect(() => {
    const fetchData = async () => {
        // Realiza la solicitud al servidor para obtener datos de la base de datos
        const responseClientes = await fetch("http://localhost:5000/clientes");
        const dataClientes = await responseClientes.json();
        setClientes(dataClientes.datos);

        const responseTelefonos = await fetch("http://localhost:5000/telefonos_clientes");
        const dataTelefonos = await responseTelefonos.json();
        setTelefonos(dataTelefonos.datos);
    };

    fetchData();
    }, []);


  const agregarNumeroCliente = async() => {
    try {
      const response = await fetch("http://localhost:5000/telefonos_clientes", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              telefonoInput,
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


  const eliminarNumeroCliente = async() => {
    try {
      const response = await fetch("http://localhost:5000/telefonos_clientes", {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              telefonoInput,
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
      <Button onPress={onOpen} color="secondary"> Telefonos</Button>
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
              <ModalHeader className="flex flex-col gap-1">Telefonos</ModalHeader>
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
                    label="Telefonos"
                    variant="bordered"
                    selectedKeys={[value]}
                    size = "lg"
                    className="max-w-xs"
                    onChange={handleSelectionChange2}
                    >
                    {telefonos.map((telefono) => (
                        <SelectItem key={telefono.telefono} value={telefono}>
                        {telefono.telefono + " "}
                        </SelectItem>
                    ))}
                    </Select>
                </div>
                <Input
                  label="Telefono"
                  placeholder="Ej: 62163336"
                  variant="bordered"
                  value={telefonoInput}
                  onValueChange={setTelefonoInput}
                />

                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="secondary" onPress={agregarNumeroCliente} onPressEnd={onClose}>
                  Agregar
                </Button>
                <Button color="danger" onPress={eliminarNumeroCliente} onPressEnd={onClose}>
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
