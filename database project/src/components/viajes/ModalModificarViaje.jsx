import React, {useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";



export default function App() {

  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [idViaje, setIdViaje] = React.useState("");
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

  const [value, setValue] = React.useState("");



  const handleSelectionChange = (e) => {
    setValue(e.target.value);
    setCedulaConductor(e.target.value);
    console.log(viajes);
    console.log(viajes[0].estado);

    for (let i = 0; i < viajes.length; i++) {
      if (viajes[i].idViaje == e.target.value) {
        console.log("Se encontro");
        setIdViaje(viajes[i].idViaje);
        setCedulaConductor(viajes[i].cedulaConductor);
        setPlaca(viajes[i].placa);
        setNombreCliente(viajes[i].nombreCliente);
        setFecha(viajes[i].fecha);
        setHora(viajes[i].hora);
        setCantidadPasajeros(viajes[i].cantidadPasajeros);
        setlugarSalida(viajes[i].lugarSalida);
        setLugarLlegada(viajes[i].lugarLlegada);
        setDescripcion(viajes[i].descripcion);
        setPrecio(viajes[i].precio);

        if (viajes[i].estado === "Completado") {
              setEstado(true)
          } else {
              setEstado(false)
        } 
       }
    }
  };

  const [viajes, setViajes] = useState([]);

  useEffect(() => {
    // Realiza la solicitud al servidor para obtener datos de la base de datos
    fetch("http://localhost:5000/viajes")
      .then((response) => response.json())
      .then((data) => setViajes(data.datos)); // Ajusta según la estructura de tu respuesta del servidor
  }, []);


  const modificarViaje = async() => {
    try {
      const response = await fetch('http://localhost:5000/viajes', {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
                idViaje,
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
      console.log(data.mensaje); // Mensaje del servidor
  
      window.location.reload();
  
    } catch (error) {
      console.error('Error:', error);
      // Puedes manejar el error según tus necesidades, por ejemplo, mostrar un mensaje al usuario.
    }

  };


  return (
    <>
      <Button onPress={onOpen} color="warning">Modificar Viaje</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Modificar Viaje</ModalHeader>
              <ModalBody>

              <div className="flex w-full max-w-xs flex-col gap-2">
              <Select
                label="Viaje a modificar"
                variant="bordered"
                selectedKeys={[value]}
                className="max-w-xs"
                onChange={handleSelectionChange}
              >
                {viajes.map((viaje) => (
                  <SelectItem key={viaje.idViaje} value={viaje}>
                    {viaje.cedulaConductor + " " + viaje.lugarSalida + " " + viaje.lugarLlegada}
                  </SelectItem>
                ))}
              </Select>
              </div>
                    
              <Input
                  label="ID del viaje"
                  placeholder="NO SE PUEDE MODIFICAR EL ID"
                  variant="bordered"
                  value={idViaje}
                  onValueChange={setIdViaje}
                  isDisabled
                />
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
                <Checkbox isSelected={estado} onValueChange={setEstado}>
                    Completado
                </Checkbox>
                
                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="warning" onPressStart={modificarViaje} onPressEnd={onClose}>
                  Modificar
                </Button>
              </ModalFooter>
            </>
          )}
        </ModalContent>
      </Modal>
    </>
  );
}
