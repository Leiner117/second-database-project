import React, {useEffect,useState} from "react";
import {Modal, ModalContent, ModalHeader, ModalBody, ModalFooter, Button, useDisclosure, Checkbox, Input, Link} from "@nextui-org/react";

import { Select, SelectItem } from "@nextui-org/react";




export default function App() {

  const {isOpen, onOpen, onOpenChange} = useDisclosure();

  const [idTransaccion, setIdTransaccion] = React.useState("");
  const [fecha, setFecha] = React.useState("");
  const [monto, setMonto] = React.useState("");
  const [detalle, setDetalle] = React.useState("");
  const [value, setValue] = React.useState("");



  const handleSelectionChange = (e) => {
    setValue(e.target.value);
    setIdTransaccion(e.target.value);
  
    for (let i = 0; i < transacciones.length; i++) {
      if (transacciones[i].idTransaccion == e.target.value) {
        setFecha(transacciones[i].fecha);
        setMonto(transacciones[i].monto);
        setDetalle(transacciones[i].detalle);
      }
    }
  };

  const [transacciones, setTransacciones] = useState([]);

  useEffect(() => {
    // Realiza la solicitud al servidor para obtener datos de la base de datos
    fetch("http://localhost:5000/transacciones")
      .then((response) => response.json())
      .then((data) => setTransacciones(data.datos)); // Ajusta según la estructura de tu respuesta del servidor
  }, []);


  const eliminarTransacciones = async() => {
    try {
      const response = await fetch('http://localhost:5000/transacciones', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          datos: [
            {
                idTransaccion,
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
      <Button onPress={onOpen} color="danger">Eliminar Transacciones</Button>
      <Modal 
        isOpen={isOpen} 
        onOpenChange={onOpenChange}
        placement="top-center"
        backdrop="blur"
      >
        <ModalContent>
          {(onClose) => (
            <>
              <ModalHeader className="flex flex-col gap-1">Eliminar Transaccion</ModalHeader>
              <ModalBody>

              <div className="flex w-full max-w-xs flex-col gap-2">
              <Select
                label="Transaccion a modificar"
                variant="bordered"
                selectedKeys={[value]}
                className="max-w-xs"
                onChange={handleSelectionChange}
              >
                {transacciones.map((transaccion) => (
                  <SelectItem key={transaccion.idTransaccion} value={transaccion}>
                    {transaccion.idTransaccion}
                  </SelectItem>
                ))}
              </Select>
              </div>

              <Input
                  label="Id Transaccion"
                  placeholder="NO SE PUEDE MODIFICAR LA ID"
                  variant="bordered"
                  value={idTransaccion}
                  onValueChange={setIdTransaccion}
                  isDisabled
                />
                <Input
                  label="Fecha"
                  placeholder="Ej: 2021-06-01"
                  variant="bordered"
                  value={fecha}
                  onValueChange={setFecha}
                  readOnly
                />
                <Input
                  label="Monto"
                  placeholder="Ej: 150"
                  variant="bordered"
                  value={monto}
                  onValueChange={setMonto}
                  readOnly
                />
                <Input
                  label="Detalle"
                  placeholder="Ej: Pago de servicios"
                  variant="bordered"
                  value={detalle}
                  onValueChange={setDetalle}
                  readOnly
                />
               

                <div className="flex py-2 px-1 justify-between">
                </div>
              </ModalBody>
              <ModalFooter>
                <Button color="danger" variant="flat" onPress={onClose}>
                  Cerrar
                </Button>
                <Button color="danger" onPressStart={eliminarTransacciones} onPressEnd={onClose}>
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
