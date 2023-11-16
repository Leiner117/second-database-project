from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
mantenimientos = Blueprint('mantemientos', __name__)


@mantenimientos.route('/mantenimientos', methods=['GET'])
def obtener_mantenimientos():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM mantenimientoReparaciones'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'id': row.IdMantenimiento, 'fecha': row.Fecha, 
                  'descripcion': row.Descripcion,
                  'costo':row.Costo,'placa':row.Placa} for row in rows]
        return jsonify({'datos': datos})
    
@mantenimientos.route('/mantenimientos', methods=['POST'])
def enviar_mantenimientos():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        print(datos_nuevos)
        try:
            # Ejemplo de inserción, ajusta según tu base de datos
            for dato in datos_nuevos:
                query = """
                    EXEC InsertarMantenimientoReparaciones ?, ?, ?, ?
                """
                cursor.execute(query, dato['fecha'],dato['descripcion'],dato['costo'],dato['placa'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
        
@mantenimientos.route('/mantenimientos', methods=['PUT'])
def modificar_mantenimientos():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        print(datos_nuevos)
        try:
            cursor.execute("{CALL ActualizarMantenimientoReparaciones(?, ?, ?, ?, ?)}", datos_nuevos[0]['id'],
                        datos_nuevos[0]['fecha'],datos_nuevos[0]['descripcion'],datos_nuevos[0]['costo'],
                        datos_nuevos[0]['placa'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})

@mantenimientos.route('/mantenimientos', methods=['DELETE'])
def eliminar_mantenimientos():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            cursor.execute("{CALL EliminarMantenimientoReparaciones(?)}", datos_nuevos[0]['id'],)
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
        