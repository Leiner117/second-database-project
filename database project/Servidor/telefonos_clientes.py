from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
telefonos_clientes = Blueprint('telefonos_clientes', __name__)



@telefonos_clientes.route('/telefonos_clientes', methods=['GET'])
def obtener_telefonos_clientes():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'SELECT * FROM telefonosClientes'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'telefono': row.Numero, 'nombre': row.NombreCliente} for row in rows]
        return jsonify({'datos': datos})
    

@telefonos_clientes.route('/telefonos_clientes', methods=['POST'])
def enviar_telefonos_clientes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        try:
            # Ejemplo de inserción, ajusta según tu base de datos
            for dato in datos_nuevos:
                query = """
                    EXEC InsertarTelefonosClientes ?, ?
                """
                cursor.execute(query, dato['telefonoInput'],dato['nombre'])
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})
        

@telefonos_clientes.route('/telefonos_clientes', methods=['DELETE'])
def eliminar_telefonos_clientes():
    with app.app_context():
        datos_nuevos = request.json.get('datos', [])
        print (datos_nuevos)
        try:
            cursor.execute("EXEC EliminarTelefonosClientes ?", datos_nuevos[0]['telefonoInput'],)
            conn.commit()
            return jsonify({'mensaje': 'Datos enviados correctamente'})
        except Exception as e:
            return jsonify({'error': str(e)})