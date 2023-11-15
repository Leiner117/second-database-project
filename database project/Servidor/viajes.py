from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
viajes = Blueprint('viajes', __name__)


"""VIAJES"""

@viajes.route('/viajes', methods=['GET'])
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


@viajes.route('/viajes', methods=['POST'])
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

@viajes.route('/viajes', methods=['PUT'])
def modificar_datos_viajes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        print(datos_nuevos)
        try:
            cursor.execute("{CALL ActualizarViaje(? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ?, ? )}", 
                        datos_nuevos[0]['idViaje'], 
                        datos_nuevos[0]['cedulaConductor'], datos_nuevos[0]['placa'], 
                        datos_nuevos[0]['nombreCliente'], datos_nuevos[0]['fecha'], 
                        datos_nuevos[0]['hora'], datos_nuevos[0]['cantidadPasajeros'], 
                        datos_nuevos[0]['lugarSalida'], datos_nuevos[0]['lugarLlegada'], 
                        datos_nuevos[0]['descripcion'], datos_nuevos[0]['precio'], 
                        datos_nuevos[0]['estado'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})

@viajes.route('/viajes', methods=['DELETE'])
def eliminar_datos_viajes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL EliminarViaje(?)}", datos_nuevos[0]['idViaje'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
        
