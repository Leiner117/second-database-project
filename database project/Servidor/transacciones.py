from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
transacciones = Blueprint('transacciones', __name__)
'''
Transacciones
'''
@transacciones.route('/transacciones', methods=['GET'])
def obtener_datos_transacciones():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM transacciones'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{
            'idTransaccion': row.IdTransaccion,
            'fecha': row.Fecha,
            'monto': row.Monto,
            'detalle': row.Detalle,} for row in rows]

        return jsonify({'datos': datos})

@transacciones.route('/transacciones', methods=['POST'])
def enviar_datos_transacciones():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            # Ejemplo de llamada a procedimiento almacenado, ajusta según tu base de datos
            for dato in datos_nuevos:
                query = """
                    EXEC InsertarTransaccion ?, ?, ?
                """
                cursor.execute(query, (dato['fecha'], dato['monto'], dato['detalle']))
            conn.commit()
            return jsonify({'mensaje': 'Datos de transacciones enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})

@transacciones.route('/transacciones', methods=['PUT'])
def modificar_datos_transacciones():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL ActualizarTransaccion(? , ? , ? , ?)}",datos_nuevos[0]['idTransaccion'] ,datos_nuevos[0]['fecha'], 
                        datos_nuevos[0]['monto'], datos_nuevos[0]['detalle'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
        

@transacciones.route('/transacciones', methods=['DELETE'])
def eliminar_datos_vehiculos():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL EliminarTransaccion(?)}", datos_nuevos[0]['idTransaccion'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})