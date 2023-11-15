import React from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";


export default function App() {
  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [fecha, setFecha] = React.useState("");
  const [monto, setMonto] = React.useState("");
  const [detalle, setDetalle] = React.useState("");
  const agregarTransaccion = async() => {
    try {
      const response = await fetch('http://localhost:5000/transacciones', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              fecha,
              monto,
              detalle,
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
      <Button onPress={onOpen} color="primary">Agregar Transaccion</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Agregar Transaccion</ModalHeader>
              <ModalBody>
                <Input
                  label="Fecha"
                  placeholder="Ej: 2021-06-01"
                  variant="bordered"
                  value={fecha}
                  onValueChange={setFecha}
                />
                <Input
                  label="Monto"
                  placeholder="Ej: 1000"
                  variant="bordered"
                  value={monto}
                  onValueChange={setMonto}
                />
                <Input
                  label="Detalle"
                  placeholder="Ej: Pago de servicios"
                  variant="bordered"
                  value={detalle}
                  onValueChange={setDetalle}
                />
                
                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="primary" onPress={agregarTransaccion} onPressEnd={onClose}>
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
