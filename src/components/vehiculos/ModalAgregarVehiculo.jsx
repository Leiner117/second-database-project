import React from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";


export default function App() {
  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [placa, setPlaca] = React.useState("");
  const [capacidad, setCapacidad] = React.useState("");
  const [modelo, setModelo] = React.useState("");
  const [marca, setMarca] = React.useState("");
  const [annio, setAnnio] = React.useState("");

  const agregarVehiculo = async() => {
    try {
      const response = await fetch('http://localhost:5000/vehiculos', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              placa,
              capacidad,
              modelo,
              marca,
              annio,
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
      <Button onPress={onOpen} color="primary">Agregar Vehiculo</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Agregar Vehiculo</ModalHeader>
              <ModalBody>
                <Input
                  label="Placa"
                  placeholder="Ej: ABC-203"
                  variant="bordered"
                  value={placa}
                  onValueChange={setPlaca}
                />
                <Input
                  label="Capacidad"
                  placeholder="Ej: 15"
                  variant="bordered"
                  value={capacidad}
                  onValueChange={setCapacidad}
                />
                <Input
                  label="Modelo"
                  placeholder="Ej: Toyota"
                  variant="bordered"
                  value={modelo}
                  onValueChange={setModelo}
                />
                <Input
                  label="Marca"
                  placeholder="Ej: Coaster"
                  variant="bordered"
                  value={marca}
                  onValueChange={setMarca}
                />
                <Input
                  label="Año"
                  placeholder="Ej: 2013"
                  variant="bordered"
                  value={annio}
                  onValueChange={setAnnio}
                />
                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="primary" onPress={agregarVehiculo} onPressEnd={onClose}>
                  Agregar Vehiculo
                </Button>
              </ModalFooter>
            </>
          )}
        </ModalContent>
      </Modal>
    </>
  );
}
