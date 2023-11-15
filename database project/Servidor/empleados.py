from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
empleados = Blueprint('empleados', __name__)
"""EMPLEADOS"""
# Ruta para obtener datos de la base de datos
@empleados.route('/empleados', methods=['GET'])
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
@empleados.route('/empleados', methods=['POST'])
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
        

@empleados.route('/empleados', methods=['PUT'])
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

@empleados.route('/empleados', methods=['DELETE'])
def eliminar_datos_empleados():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL EliminarEmpleado(?)}", datos_nuevos[0]['cedula'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
