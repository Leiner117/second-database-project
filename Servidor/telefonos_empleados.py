from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
telefonos_empleados = Blueprint('telefonos_empleados', __name__)



@telefonos_empleados.route('/telefonos_empleados', methods=['GET'])
def obtener_telefonos_empleados():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM telefonosEmpleados'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'telefono': row.Numero, 'cedula': row.CedulaEmpleado} for row in rows]
        return jsonify({'datos': datos})
    
@telefonos_empleados.route('/telefonos_empleados', methods=['POST'])
def enviar_telefonos_empleados():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            # Ejemplo de inserción, ajusta según tu base de datos
            for dato in datos_nuevos:
                query = """
                    EXEC InsertarTelefono ?, ?
                """
                cursor.execute(query, dato['telefonoInput'],dato['cedula'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})

@telefonos_empleados.route('/telefonos_empleados', methods=['DELETE'])
def eliminar_telefonos_empleados():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL EliminarTelefono(? , ?)}", datos_nuevos[0]['telefonoInput'], 
                        datos_nuevos[0]['cedula'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
        