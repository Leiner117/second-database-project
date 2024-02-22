from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
vehiculo = Blueprint('vehiculo', __name__)

"""VEHICULOS"""

@vehiculo.route('/vehiculos', methods=['GET'])
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
@vehiculo.route('/vehiculos', methods=['POST'])
def enviar_datos_vehiculos():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        
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


@vehiculo.route('/vehiculos', methods=['PUT'])
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

@vehiculo.route('/vehiculos', methods=['DELETE'])
def eliminar_datos_vehiculos():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL EliminarVehiculo(?)}", datos_nuevos[0]['placa'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
