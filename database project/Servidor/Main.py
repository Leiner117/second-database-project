from flask import Flask, request, jsonify
import pyodbc
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
# Configuración de la conexión a la base de datos SQL Server
server = 'tcp:DESKTOP-7B25NAD'
database = 'TransGaby'
username = 'sa'
password = 'a123'
conn_str = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'
conn = pyodbc.connect(conn_str)
cursor = conn.cursor()

# Configuración del cliente Astro

"""EMPLEADOS"""
# Ruta para obtener datos de la base de datos
@app.route('/empleados', methods=['GET'])
def obtener_datos_empleados():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM empleados'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'cedula': row.Cedula, 'nombre': row.Nombre,
            'apellido1': row.Apellido, 'apellido2': row.Apellido2
            ,'fechaNacimiento': row.FechaNacimiento} for row in rows]
        return jsonify({'datos': datos})

# Ruta para enviar datos a la base de datos
@app.route('/empleados', methods=['POST'])
def enviar_datos_empleados():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            # Ejemplo de inserción, ajusta según tu base de datos
            for dato in datos_nuevos:
                query = """
                    EXEC InsertarEmpleado ?, ?, ?, ?, ?, ?, ?
                """
                cursor.execute(query, (dato['cedula'], dato['nombre'], 
                                       dato['apellido1'], dato['apellido2'], 
                                       dato['fechaNacimiento'], dato['correo'], 
                                       dato['telefono']))
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
        

@app.route('/empleados', methods=['PUT'])
def modificar_datos_empleados():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{EXEC ActualizarEmpleado(? , ? , ? , ? )}", datos_nuevos[0]['cedula'], 
                        datos_nuevos[0]['nombre'], datos_nuevos[0]['apellido1'], datos_nuevos[0]['apellido2'])   #, datos_nuevos[0]['fechaNacimiento'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})

@app.route('/empleados', methods=['DELETE'])
def eliminar_datos_empleados():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL EliminarEmpleado(?)}", datos_nuevos[0]['cedula'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})


"""VEHICULOS"""

@app.route('/vehiculos', methods=['GET'])
def obtener_datos_vehiculos():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM vehiculos'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'placa': row.Placa, 
            'capacidad': row.Capacidad, 'modelo': row.Modelo
            ,'marca': row.Marca, 'annio':row.Año, 
            'cantidadViajes':row.CantidadViajes} for row in rows]

        return jsonify({'datos': datos})

# Ruta para enviar datos a la base de datos
@app.route('/vehiculos', methods=['POST'])
def enviar_datos_vehiculos():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        print(datos_nuevos)
        try:
            # Ejemplo de inserción, ajusta según tu base de datos
            for dato in datos_nuevos:
                query = """
                    EXEC InsertarVehiculo ?, ?, ?, ?, ?
                """
                cursor.execute(query, dato['placa'], dato['capacidad'], dato['modelo'], dato['marca'], dato['annio'])
            conn.commit()
            return jsonify({'mensaje': 'Datos de vehículos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})


@app.route('/vehiculos', methods=['PUT'])
def modificar_datos_vehiculos():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL ActualizarVehiculo(? , ? , ? , ? , ? )}", datos_nuevos[0]['placa'], 
                        datos_nuevos[0]['capacidad'], datos_nuevos[0]['modelo'], datos_nuevos[0]['marca'], datos_nuevos[0]['annio'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})

@app.route('/vehiculos', methods=['DELETE'])
def eliminar_datos_vehiculos():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL EliminarVehiculo(?)}", datos_nuevos[0]['placa'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})



"""VIAJES"""

@app.route('/viajes', methods=['GET'])
def obtener_datos_viajes():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM viajes'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'idViaje': row.IdViaje,'cedulaConductor': row.CedulaConductor,'placa':row.Vehiculo ,'nombreCliente': row.NombreCliente,
            'fecha': row.Fecha, 'hora': str(row.Hora)[:-8],'cantidadPasajeros':row.CantidadPasajeros
            ,'lugarSalida': row.LugarSalida,'lugarLlegada':row.LugarLlegada, 'descripcion':row.Descripcion,
            'precio':row.Precio, 'estado': "Completado" if row.Estado == 1 else "En Proceso"} for row in rows]

        return jsonify({'datos': datos})


@app.route('/viajes', methods=['POST'])
def enviar_datos_viajes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            # Ejemplo de llamada a procedimiento almacenado, ajusta según tu base de datos
            for dato in datos_nuevos:
                query = """
                    EXEC RegistrarViaje ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
                """
                cursor.execute(query, (dato['cedulaConductor'],dato['placa'], dato['nombreCliente'], dato['fecha'],
                                        dato['hora'],dato['cantidadPasajeros'], dato['lugarSalida'], dato['lugarLlegada']
                                       ,dato['descripcion'], dato['precio'], dato['estado']))
            conn.commit()
            return jsonify({'mensaje': 'Datos de viajes enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})


def modificar_datos_viajes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL ActualizarViaje(? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? )}", datos_nuevos[0]['idViaje'], 
                        datos_nuevos[0]['cedulaConductor'], datos_nuevos[0]['placa'], datos_nuevos[0]['nombreCliente'], datos_nuevos[0]['fecha'], datos_nuevos[0]['hora'], datos_nuevos[0]['cantidadPasajeros'], datos_nuevos[0]['lugarSalida'], datos_nuevos[0]['lugarLlegada'], datos_nuevos[0]['descripcion'], datos_nuevos[0]['precio'], datos_nuevos[0]['estado'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})


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


if __name__ == '__main__':
    #testing2()
    #obtener_datos()
    #testing3()
    #testing4()
    app.run(debug=True)