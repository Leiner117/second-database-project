import React from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";


export default function App() {
  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [cedulaConductor, setCedulaConductor] = React.useState("");
  const [placa, setPlaca] = React.useState("");
  const [nombreCliente, setNombreCliente] = React.useState("");
  const [fecha, setFecha] = React.useState("");
  const [hora, setHora] = React.useState("");
  const [cantidadPasajeros, setCantidadPasajeros] = React.useState("");
  const [lugarSalida, setlugarSalida] = React.useState("");
  const [lugarLlegada, setLugarLlegada] = React.useState("");
  const [descripcion, setDescripcion] = React.useState("");
  const [precio, setPrecio] = React.useState("");
  const [estado, setEstado] = React.useState("");
 

  const agregarViaje = async() => {

    console.log(cedulaConductor);
    console.log(placa);
    console.log(nombreCliente);
    console.log(fecha);
    console.log(hora);
    console.log(cantidadPasajeros);
    console.log(lugarSalida);
    console.log(lugarLlegada);
    console.log(descripcion);
    console.log(precio);
    console.log(estado);

    try {
      const response = await fetch('http://localhost:5000/viajes', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
                cedulaConductor,
                placa,
                nombreCliente,
                fecha,
                hora,
                cantidadPasajeros,
                lugarSalida,
                lugarLlegada,
                descripcion,
                precio,
                estado,
            },
          ],
        }),
      });
  
      if (!response.ok) {
        throw new Error('Error al enviar datos al servidor');
      }
  
      const data = await response.json();


      window.location.reload();
  
    } catch (error) {
      console.error('Error:', error);
      // Puedes manejar el error según tus necesidades, por ejemplo, mostrar un mensaje al usuario.
    }
  };
  return (
    <>
      <Button onPress={onOpen} color="primary">Agregar viaje</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Agregar viaje</ModalHeader>
              <ModalBody>
                <Input
                  label="Cedula del conductor"
                  placeholder="Ej: 2-0842-0162"
                  variant="bordered"
                  value={cedulaConductor}
                  onValueChange={setCedulaConductor}
                />
                <Input
                  label="Placa"
                  placeholder="Ej: AB323"
                  variant="bordered"
                  value={placa}
                  onValueChange={setPlaca}
                />
                <Input
                  label="Nombre del cliente"
                  placeholder="Ej: Wave"
                  variant="bordered"
                  value={nombreCliente}
                  onValueChange={setNombreCliente}
                />
                <Input
                  label="Fecha"
                  placeholder="Ej: 2023-06-01"
                  variant="bordered"
                  value={fecha}
                  onValueChange={setFecha}
                />
                <Input
                  label="Hora"
                  placeholder="Ej: 14:00:00"
                  variant="bordered"
                  value={hora}
                  onValueChange={setHora}
                />
                <Input
                  label="Cantidad Pasajeros"
                  placeholder="Ej: 25"
                  variant="bordered"
                  value={cantidadPasajeros}
                  onValueChange={setCantidadPasajeros}
                />
                <Input
                  label="Lugar de Salida"
                  placeholder="Ej: CQ"
                  variant="bordered"
                  value={lugarSalida}
                  onValueChange={setlugarSalida}
                />
                <Input
                  label="Lugar de Llegada"
                  placeholder="Ej: Fortuna"
                  variant="bordered"
                  value={lugarLlegada}
                  onValueChange={setLugarLlegada}
                />
                <Input
                  label="Descripcion"
                  placeholder="Ej: Viaje a Cartago"
                  variant="bordered"
                  value={descripcion}
                  onValueChange={setDescripcion}
                />
                <Input
                  label="Precio"
                  placeholder="Ej: 50000"
                  variant="bordered"
                  value={precio}
                  onValueChange={setPrecio}
                />
                <Input
                  label="Estado"
                  placeholder="Ej: 1 completado, 0 pendiente"
                  variant="bordered"
                  value={estado}
                  onValueChange={setEstado}
                />

                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="primary" onPress={agregarViaje} onPressEnd={onClose}>
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
