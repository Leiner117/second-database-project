from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
correos_clientes = Blueprint('correos_clientes', __name__)



"""CORREOS CLIENTES"""

@correos_clientes.route('/correos_clientes', methods=['GET'])
def obtener_correos_clientes():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM correosClientes'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'correo': row.Correo, 'cedula': row.NombreCliente} for row in rows]
        return jsonify({'datos': datos})
    
@correos_clientes.route('/correos_clientes', methods=['POST'])
def enviar_correos_clientes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            # Ejemplo de inserción, ajusta según tu base de datos
            for dato in datos_nuevos:
                query = """
                    EXEC InsertarCorreosClientes ?, ?
                """
                cursor.execute(query, dato['correoInput'],dato['nombre'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
        
@correos_clientes.route('/correos_clientes', methods=['DELETE'])
def eliminar_correos_clientes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL EliminarCorreosClientes(? )}", datos_nuevos[0]['correoInput'],)
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})