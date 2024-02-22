import React from "react";
import {Card, CardHeader, CardBody, Image} from "@nextui-org/react";

export default function App() {
  return (
    <div className="flex flex-row justify-center min-h-screen">
      <Card className="py-4 w-64 h-64 mr-4">
        <CardHeader className="pb-0 pt-2 px-4 flex-col items-start">
          <h4 className="font-bold text-large text-center">Anthony Jimenez Zamora</h4>
        </CardHeader>
        <CardBody className="overflow-visible py-2">
        <div className="flex justify-center">
          <a href="https://github.com/AntJimenezZ">
          <Image
            alt="Card background"
            className="object-cover rounded-xl"
            src="https://avatars.githubusercontent.com/u/102042795?v=4"
            width={180}
          />
          </a>
        </div>
        </CardBody>
      </Card>
      <Card className="py-4 w-64 h-64 mr-4">
        <CardHeader className="pb-0 pt-2 px-4 flex-col items-start">
          <h4 className="font-bold text-large text-center">Leiner Alvarado Rodriguez</h4>
        </CardHeader>
        <CardBody className="overflow-visible py-2">
        <div className="flex justify-center">
          <a href="https://github.com/Leiner117">
          <Image
            alt="Card background"
            className="object-cover rounded-xl"
            src="https://avatars.githubusercontent.com/u/101950242?v=4"
            width={180}
          />
          </a>
        </div>
        </CardBody>
      </Card>
      <Card className="py-4 w-64 h-64">
        <CardHeader className="pb-0 pt-2 px-4 flex-col items-start">
          <h4 className="font-bold text-large text-center justify-center">Jeison Blanco Rojos</h4>
        </CardHeader>
        <CardBody className="overflow-visible py-2">
        <div className="flex justify-center">
          <a href="https://github.com/jeisonbcr7">
          <Image
            alt="Card background"
            className="object-cover rounded-xl"
            src="https://www.info-computer.com/modules/dbblog/views/img/uploads/2020/10/json.jpg"
            width={180}
          />
          </a>
        </div>
        </CardBody>
      </Card>
    </div>
  );
}