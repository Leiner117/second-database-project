from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
correos_empleados = Blueprint('correos_empleados', __name__)


"""CORREOS EMPLEADOS"""

# Ruta para obtener datos de la base de datos

@correos_empleados.route('/correos_empleados', methods=['GET'])
def obtener_correos_empleados():
    datos_nuevos = request.json.get('datos', [])
    print(datos_nuevos)
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        try:
            for dato in datos_nuevos:
                query = 'EXEC LeerCorreoElectronico ?'
                cursor.execute(query, dato['cedula'])
                rows = cursor.fetchall()
                datos = [{'correo': row.Correo, 'cedula' : row.CedulaEmpleado} for row in rows]
            return jsonify({'datos': datos})
        except Exception as e:
            return jsonify({'error': str(e)})
        
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
                cursor.execute(query, dato['correo'],dato['cedula'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
