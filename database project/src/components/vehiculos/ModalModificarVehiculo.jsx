import React, {useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";




export default function App() {

  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [placa, setPlaca] = React.useState("");
  const [capacidad, setCapacidad] = React.useState("");
  const [modelo, setModelo] = React.useState("");
  const [marca, setMarca] = React.useState("");
  const [annio, setAnnio] = React.useState("");
  const [cantidadViajes, setCantidadViajes] = React.useState("");
  const [value, setValue] = React.useState("");



  const handleSelectionChange = (e) => {
    setValue(e.target.value);
    setPlaca(e.target.value);

    console.log(vehiculos);

    for (let i = 0; i < vehiculos.length; i++) {
      if (vehiculos[i].placa == e.target.value) {
        console.log("Se encontro");
        setCapacidad(vehiculos[i].capacidad);
        setModelo(vehiculos[i].modelo);
        setMarca(vehiculos[i].marca);
        setAnnio(vehiculos[i].annio);
        setCantidadViajes(vehiculos[i].cantidadViajes);
      }
    }
  };

  const [vehiculos, setVehiculos] = useState([]);

  useEffect(() => {
    // Realiza la solicitud al servidor para obtener datos de la base de datos
    fetch("http://localhost:5000/vehiculos")
      .then((response) => response.json())
      .then((data) => setVehiculos(data.datos)); // Ajusta según la estructura de tu respuesta del servidor
  }, []);


  const modificarVehiculo = async() => {
    try {
      const response = await fetch('http://localhost:5000/vehiculos', {
        method: 'PUT',
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
      <Button onPress={onOpen} color="warning">Modificar Vehiculo</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Modificar Vehiculo</ModalHeader>
              <ModalBody>

              <div className="flex w-full max-w-xs flex-col gap-2">
              <Select
                label="Vehiculo a modificar"
                variant="bordered"
                selectedKeys={[value]}
                className="max-w-xs"
                onChange={handleSelectionChange}
              >
                {vehiculos.map((vehiculo) => (
                  <SelectItem key={vehiculo.placa} value={vehiculo}>
                    {vehiculo.placa}
                  </SelectItem>
                ))}
              </Select>
              </div>

              <Input
                  label="Placa"
                  placeholder="NO SE PUEDE MODIFICAR LA PLACA"
                  variant="bordered"
                  value={placa}
                  onValueChange={setPlaca}
                  isDisabled
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
                <Input
                  label="Cantidad de viajes"
                  placeholder="NO SE PUEDE MODIFICAR LA CANTIDAD DE VIAJES"
                  variant="bordered"
                  value={cantidadViajes}
                  onValueChange={setCantidadViajes}
                  OnlyRead
                  isDisabled
                />

                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="warning" onPressStart={modificarVehiculo} onPressEnd={onClose}>
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
