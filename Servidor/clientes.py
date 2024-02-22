from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
clientes = Blueprint('clientes', __name__)

"""CLIENTES"""

@clientes.route('/clientes', methods=['GET'])
def obtener_datos_clientes():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM clientes'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'Nombre':row.Nombre,'CantidadViajes':row.CantidadViajes,'CantidadTransacciones':row.CantidadTransacciones} for row in rows]
        return jsonify({'datos': datos})

# Ruta para enviar datos a la base de datos
@clientes.route('/clientes', methods=['POST'])
def enviar_datos_clientes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            # Ejemplo de inserción, ajusta según tu base de datos
            for dato in datos_nuevos:
                query = """
                    EXEC InsertarCliente ?
                """
                cursor.execute(query, dato['nombre'])
            conn.commit()
            return jsonify({'mensaje': 'Datos de vehículos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})


@clientes.route('/clientes', methods=['PUT'])
def modificar_datos_clientes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL ActualizarCliente(?)}", datos_nuevos[0]['cliente'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})

@clientes.route('/clientes', methods=['DELETE'])
def eliminar_datos_clientes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL EliminarCliente(?)}", datos_nuevos[0]['nombre'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
