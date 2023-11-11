import React from "react";
import {Listbox, ListboxItem} from "@nextui-org/react";
import {ListboxWrapper} from "./ListboxWrapper";

export default function App() {
  const items = [
    {
      key: "new",
      label: "Leiner",
    },
    {
      key: "Soy un",
      label: "Jonson",
    },
    {
      key: "edit",
      label: "Edit file",
    },
    {
      key: "delete",
      label: "Delete file",
    }
  ];

  return (
    <ListboxWrapper>
      <Listbox
        items={items}
        aria-label="Dynamic Actions"
        //onAction={(key) => alert(key)}  agregar funcionalidad
      >
        {(item) => (
          <ListboxItem
            key={item.key}
            color={item.key === "delete" ? "danger" : "default"}
            className={item.key === "delete" ? "text-danger" : ""}
          >
            {item.label}
          </ListboxItem>
        )}
      </Listbox>
    </ListboxWrapper>
  );
}
