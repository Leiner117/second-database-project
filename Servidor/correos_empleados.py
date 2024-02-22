from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
correos_empleados = Blueprint('correos_empleados', __name__)


"""CORREOS EMPLEADOS"""

# Ruta para obtener datos de la base de datos

@correos_empleados.route('/correos_empleados', methods=['GET'])
def obtener_correos_empleados():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM correoElectronicosEmpleados'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'correo': row.Correo, 'cedula': row.CedulaEmpleado} for row in rows]
        return jsonify({'datos': datos})



@correos_empleados.route('/correos_empleados', methods=['POST'])
def enviar_correos_empleados():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            # Ejemplo de inserción, ajusta según tu base de datos
            for dato in datos_nuevos:
                query = """
                    EXEC InsertarCorreoElectronico ?, ?
                """
                cursor.execute(query, dato['correoInput'],dato['cedula'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})


@correos_empleados.route('/correos_empleados', methods=['DELETE'])
def eliminar_correos_empleados():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        print(datos_nuevos)

        try:
            cursor.execute("{CALL EliminarCorreoElectronico(?, ?)}", datos_nuevos[0]['correoInput'],datos_nuevos[0]['cedula'])

            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
        