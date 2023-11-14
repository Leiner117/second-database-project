import React, {useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";




export default function App() {

  const {isOpen, onOpen, onOpenChange} = useDisclosure();
  const [placa, setPlaca] = React.useState("");
  const [cedulaConductor, setCedulaConductor] = React.useState("");
  const [capacidad, setCapacidad] = React.useState("");
  const [modelo, setModelo] = React.useState("");
  const [marca, setMarca] = React.useState("");
  const [annio, setAnnio] = React.useState("");
  const [value, setValue] = React.useState("");



  const handleSelectionChange = (e) => {
    setValue(e.target.value);
    setPlaca(e.target.value);
    setCedulaConductor(e.target.cedulaConductor);

    console.log(vehiculos);

    for (let i = 0; i < vehiculos.length; i++) {
      if (vehiculos[i].placa == e.target.value) {
        console.log("Se encontro");
        setCedulaConductor(vehiculos[i].cedulaConductor);
        setCapacidad(vehiculos[i].capacidad);
        setModelo(vehiculos[i].modelo);
        setMarca(vehiculos[i].marca);
        setAnnio(vehiculos[i].annio);
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


  const eliminarVehiculo = async() => {
    try {
      const response = await fetch('http://localhost:5000/vehiculos', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
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
  }


  return (
    <>
      <Button onPress={onOpen} color="danger">Eliminar Vehiculo</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Eliminar Vehiculo</ModalHeader>
              <ModalBody>

              <div className="flex w-full max-w-xs flex-col gap-2">
              <Select
                label="Vehiculo a Eliminar"
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
                  placeholder="Seleccione un vehiculo"
                  variant="bordered"
                  value={placa}
                  onValueChange={setPlaca}
                  readOnly
                />
                <Input
                  label="Cedula del conductor"
                  placeholder="Seleccione un vehiculo"
                  variant="bordered"
                  value={cedulaConductor}
                  onValueChange={setCedulaConductor}
                  readOnly
                />
                <Input
                  label="Capacidad"
                  placeholder="Seleccione un vehiculo"
                  variant="bordered"
                  value={capacidad}
                  onValueChange={setCapacidad}
                  readOnly
                />
                <Input
                  label="Modelo"
                  placeholder="Seleccione un vehiculo"
                  variant="bordered"
                  value={modelo}
                  onValueChange={setModelo}
                  readOnly
                />
                <Input
                  label="Marca"
                  placeholder="Seleccione un vehiculo"
                  variant="bordered"
                  value={marca}
                  onValueChange={setMarca}
                  readOnly
                />
                <Input
                  label="Año"
                  placeholder="Seleccione un vehiculo"
                  variant="bordered"
                  value={annio}
                  onValueChange={setAnnio}
                  readOnly
                />
                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="danger" onPressStart={eliminarVehiculo} onPressEnd={onClose}>
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
