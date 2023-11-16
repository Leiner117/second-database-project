from flask import Blueprint, request, jsonify,current_app as app
from bd import Bd
cursor = Bd().cursor
conn = Bd().conn
consultas = Blueprint('consultas', __name__)


@consultas.route('/consultas', methods=['GET'])
def obtener_consultas():
    with app.app_context():
        # Ejemplo de consulta, ajusta según tu base de datos
        query = 'EXEC ConsultaConductoresDisponibles'
        cursor.execute(query)
        rows = cursor.fetchall()

        # Convertir resultados a un formato que Astro pueda entender
        datos = [{'nombreConductor': row.NombreConductor, 
                  'cedulaConductor': row.CedulaConductor,} for row in rows]
        return jsonify({'datos': datos})
    
