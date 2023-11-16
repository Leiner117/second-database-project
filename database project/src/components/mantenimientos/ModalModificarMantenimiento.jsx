import React,{useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";

export default function App() {
    const {isOpen, onOpen, onOpenChange} = useDisclosure();
    const [fecha, setFecha] = React.useState("");
    const [descripcion, setDescripcion] = React.useState("");
    const [costo, setCosto] = React.useState("");
    const [placa, setPlaca] = React.useState("");

    const [value, setValue] = React.useState("");

    const [id, setId] = React.useState("");


    const handleSelectionChange = (e) => {
        setValue(e.target.value);

        
        for (let i = 0; i < mantenimientos.length; i++) {
          if (mantenimientos[i].id == e.target.value) {
            setId(mantenimientos[i].id);
            setFecha(mantenimientos[i].fecha);
            setDescripcion(mantenimientos[i].descripcion);
            setCosto(mantenimientos[i].costo);
            setPlaca(mantenimientos[i].placa);
          }
        }
      };

    const [mantenimientos, setMantenimientos] = useState([]);

    useEffect(() => {
        // Realiza la solicitud al servidor para obtener datos de la base de datos
        fetch("http://localhost:5000/mantenimientos")
          .then((response) => response.json())
          .then((data) => setMantenimientos(data.datos)); // Ajusta según la estructura de tu respuesta del servidor
      }, []);



    const modificarMantenimiento = async() => {
    try {
      const response = await fetch('http://localhost:5000/mantenimientos', {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
              id,
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
      <Button onPress={onOpen} color="warning">Modificar Mantenimiento</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Modificar Mantenimiento</ModalHeader>
              <ModalBody>

                <div className="flex w-full max-w-xs flex-col gap-2">
                <Select
                label="Vehiculo a modificar"
                variant="bordered"
                selectedKeys={[value]}
                className="max-w-xs"
                onChange={handleSelectionChange}
                >
                {mantenimientos.map((mantenimiento) => (
                  <SelectItem key={mantenimiento.id} value={mantenimiento}>
                    {mantenimiento.placa + " " + mantenimiento.descripcion}
                  </SelectItem>
                ))}
              </Select>

              </div>

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
                <Button color="warning" onPress={modificarMantenimiento} onPressEnd={onClose}>
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
