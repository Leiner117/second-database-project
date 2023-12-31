from flask import Flask, request, jsonify
import pyodbc
from flask_cors import CORS

from empleados import empleados
from viajes import viajes
from vehiculos import vehiculo
from transacciones import transacciones
from correos_empleados import correos_empleados
from clientes import clientes
from informeFinancieroGlobal import informe
from informeFinancieroCliente import informeCliente
from telefonos_empleados import telefonos_empleados
from correos_clientes import correos_clientes
from telefonos_clientes import telefonos_clientes
from mantenimientos import mantenimientos
from consultas import consultas

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "http://localhost:4321"}})
app.register_blueprint(empleados)
app.register_blueprint(viajes)
app.register_blueprint(vehiculo)
app.register_blueprint(transacciones)
app.register_blueprint(correos_empleados)
app.register_blueprint(clientes)
app.register_blueprint(informe)
app.register_blueprint(informeCliente)
app.register_blueprint(telefonos_empleados)
app.register_blueprint(correos_clientes)
app.register_blueprint(telefonos_clientes)
app.register_blueprint(mantenimientos)
app.register_blueprint(consultas)


# Configuración del cliente Astro

'''
def testing():
    print("Hola mundo")
    query = 'SELECT * FROM empleados'
    cursor.execute(query)
    rows = cursor.fetchall()
    print(rows)


def testing2():
    cedula = '2-0842-0162'
    nombre = 'LOL'
    apellido1 = 'JimenezCorregido'
    apellido2 = 'ZamoraCorregido'
    fecha_nacimiento = '1999-01-01'
    try:
        cursor.execute("{CALL ActualizarEmpleado (?, ?, ?, ?)}", cedula, nombre, apellido1, apellido2)
        conn.commit()
        print("Procedimiento almacenado ejecutado correctamente.")
    except Exception as e:
        print("Error al ejecutar el procedimiento almacenado:", e)
    finally:
        # Cerrar la conexión
        cursor.close()
        conn.close()


def testing3():
    query = 'SELECT * FROM viajes'
    cursor.execute(query)
    rows = cursor.fetchall()

    # Convertir resultados a un formato que Astro pueda entender
    datos = [{'cedulaConductor': row.CedulaConductor, 'nombreCliente': row.NombreCliente,
        'fecha': row.Fecha, 'hora': row.Hora
        ,'lugarSalida': row.LugarSalida, 'descripcion':row.Descripcion,
        'precio':row.Precio} for row in rows]
    
    print(datos)


def testing4():

    # Ejemplo de inserción, ajusta según tu base de datos
    query = """
        EXEC InsertarEmpleado ?, ?, ?, ?, ?, ?, ?
    """
    cursor.execute(query, '2-0888-0888', 'noni', 
                            'Jims', 'Zamos', 
                            '01-05-2003', 'noni5@hotmail.com', 
                            '62163336')
    conn.commit()

'''


if __name__ == '__main__':
    app.run(debug=True)