import React, {useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";




export default function App() {

  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [nombre, setNombre] = React.useState("");
  const [cantidadViajes, setCantidadViajes] = React.useState("");
  const [cantidadTransacciones, setCantidadTransacciones] = React.useState("");
  const [value, setValue] = React.useState("");




  const handleSelectionChange = (e) => {
    setValue(e.target.value);
    setNombre(e.target.value);


    for (let i = 0; i < clientes.length; i++) {
      if (clientes[i].nombre == e.target.value) {
        setNombre(clientes[i].nombre);
        setCantidadViajes(clientes[i].cantidadViajes);
        setCantidadTransacciones(clientes[i].cantidadTransacciones);
      }
    }
  };

  const [clientes, setClientes] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      // Realiza la solicitud al servidor para obtener datos de la base de datos
      const response = await fetch("http://localhost:5000/clientes");
      const data = await response.json();
      setClientes(data.datos); // Ajusta según la estructura de tu respuesta del servidor
    };
  
    fetchData();
  }, []);


  const eliminarCliente = async() => {
    try {
      const response = await fetch('http://localhost:5000/clientes', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
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
      console.log(data.datos); // Datos enviados por el servidor
      window.location.reload();
  
    } catch (error) {
      console.error('Error:', error);
      // Puedes manejar el error según tus necesidades, por ejemplo, mostrar un mensaje al usuario.
    }
  }


  return (
    <>
      <Button onPress={onOpen} color="danger">Eliminar Clientes</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Eliminar Cliente</ModalHeader>
              <ModalBody>

              <div className="flex w-full max-w-xs flex-col gap-2">
              <Select
                label="Cliente a Eliminar"
                variant="bordered"
                selectedKeys={[value]}
                className="max-w-xs"
                onChange={handleSelectionChange}
              >
                {clientes.map((cliente) => (
                  <SelectItem key={cliente.Nombre} value={cliente.Nombre}>
                    {cliente.Nombre}
                  </SelectItem>
                ))}
              </Select>
              </div>

              <Input
                  label="Nombre"
                  placeholder="Seleccione un nombre"
                  variant="bordered"
                  value={nombre}
                  onValueChange={setNombre}
                  readOnly
                />
                
                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="danger" onPressStart={eliminarCliente} onPressEnd={onClose}>
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
