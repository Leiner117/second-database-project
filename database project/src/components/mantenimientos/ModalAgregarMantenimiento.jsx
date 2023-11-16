import React from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";


export default function App() {
  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [fecha, setFecha] = React.useState("");
  const [descripcion, setDescripcion] = React.useState("");
  const [costo, setCosto] = React.useState("");
  const [placa, setPlaca] = React.useState("");

  const agregarMantenimiento = async() => {
    try {
      const response = await fetch('http://localhost:5000/mantenimientos', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              fecha,
              descripcion,
              costo,
              placa,
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
      <Button onPress={onOpen} color="primary">Agregar Mantenimiento</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Agregar Mantenimiento</ModalHeader>
              <ModalBody>
                <Input
                  label="Fecha"
                  placeholder="Ej: 2023-11-11"
                  variant="bordered"
                  value={fecha}
                  onValueChange={setFecha}
                />
                <Input
                  label="Descripcion"
                  placeholder="Ej: Cambio de aceite"
                  variant="bordered"
                  value={descripcion}
                  onValueChange={setDescripcion}
                />
                <Input
                  label="Costo"
                  placeholder="Ej: 250"
                  variant="bordered"
                  value={costo}
                  onValueChange={setCosto}
                />
                <Input
                  label="Placa"
                  placeholder="Ej: ABC-777"
                  variant="bordered"
                  value={placa}
                  onValueChange={setPlaca}
                />
                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="primary" onPress={agregarMantenimiento} onPressEnd={onClose}>
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
